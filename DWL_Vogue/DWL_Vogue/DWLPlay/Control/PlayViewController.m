//
//  PlayViewController.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/22.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "PlayViewController.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"
#import "PlayCellInformation.h"
#import "PlayCustomViewController.h"
#import "SaveTool.h"

@interface PlayViewController ()<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate, MBProgressHUDDelegate>
@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *playTableViewCellArr;
@property(nonatomic, assign)NSInteger num;
@property(nonatomic, retain)MBProgressHUD *HUD;

@end

@implementation PlayViewController
- (void)dealloc {
    [_tableView release];
    [_playTableViewCellArr release];
    [_HUD release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SaveTool isHaveFolder];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:24 / 255.0 green:23 / 255.0 blue:40 / 255.0 alpha:1];
    self.navigationController.navigationBar.translucent = YES;
    UILabel *playTitle = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 30, 15, 60, 20)];
    playTitle.text = @"旅行·游";
    playTitle.textAlignment = NSTextAlignmentCenter;
    playTitle.textColor = [UIColor whiteColor];
    playTitle.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
    [self.navigationController.navigationBar addSubview:playTitle];
    [playTitle release];
    
    //    TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.275 green:0.305 blue:0.337 alpha:1.000];
//    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.213 green:0.237 blue:0.259 alpha:1.000]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"viewBackLoad.png"]];
    [self.tableView setBackgroundView:imageView];
    [self.view addSubview:self.tableView];
    [_tableView release];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //  MBProgressHUD
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [_HUD release];
    self.HUD.minSize = CGSizeMake(120, 100);
    self.HUD.delegate = self;
    self.HUD.color = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    self.HUD.labelText = @"旅行";
    self.HUD.labelFont = [UIFont systemFontOfSize:14];
    self.HUD.detailsLabelText = @"正在准备";
    self.HUD.detailsLabelFont = [UIFont systemFontOfSize:12];
    [self.HUD show:YES];
    
    //    CreateData
    
    self.num = 1;
    self.playTableViewCellArr = [NSMutableArray array];
    [self createData];
}

- (void)header {
    [self.tableView.header endRefreshing];
}

- (void)footer {
    self.num++;
    NSString *url = [NSString stringWithFormat:@"http://chanyouji.com/api/trips/featured.json?page=%ld", self.num];
    [DWLNetWorkingTool getBodyNetWorking:url body:nil success:^(id result) {
        for (NSMutableDictionary *dic in result) {
            PlayCellInformation *model = [[PlayCellInformation alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.playTableViewCellArr addObject:model];
            [model release];
        }
        [self.tableView.footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(id error) {
        NSLog(@"%@", error);
    }];
}

- (void)createData {
    [DWLNetWorkingTool getBodyNetWorking:@"http://chanyouji.com/api/trips/featured.json?page=1" body:nil success:^(id result) {
        self.playTableViewCellArr = [PlayCellInformation baseModelByArr:result];
        //        NSLog(@"%@", self.playTableViewCellArr);
        [self.tableView reloadData];
        [self.HUD removeFromSuperview];
        self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footer)];
    } failure:^(id error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark  TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playTableViewCellArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuse1 = @"reuse1";
    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
    if (!cell) {
        cell = [[[FoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    [cell.foodimageView sd_setImageWithURL:[NSURL URLWithString:[self.playTableViewCellArr[indexPath.row] front_cover_photo_url]] placeholderImage:[UIImage imageNamed:@"placeholderBig.jpg"]];
    cell.foodHeadLabel.text = [self.playTableViewCellArr[indexPath.row] playTitleName];
    PlayCellInformation *model = self.playTableViewCellArr[indexPath.row];
    NSString *date = [self.playTableViewCellArr[indexPath.row] start_date];
    NSNumber *dat = model.days;
    cell.foodTextLabel.text = [NSString stringWithFormat:@"# 旅行 · %@ & %@ 天", date, dat.stringValue];
//    cell.foodTextLabel.text = @"1";
    [cell.foodTextLabel setHighlighted:NO];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    PlayCustomViewController *custom = [[PlayCustomViewController alloc] init];
    NSString *numId = [self.playTableViewCellArr[indexPath.row] numId].stringValue;
    custom.url = [[@"http://chanyouji.com/api/trips/" stringByAppendingString:numId] stringByAppendingString:@".json"];
    custom.imageUrl = [self.playTableViewCellArr[indexPath.row] front_cover_photo_url];
    custom.play = self.playTableViewCellArr[indexPath.row];
    custom.numID = numId;
    custom.titleName = [self.playTableViewCellArr[indexPath.row] playTitleName];
    [self presentViewController:custom animated:YES completion:nil];
    [custom release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MYHEIGHT * 4 / 9;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
