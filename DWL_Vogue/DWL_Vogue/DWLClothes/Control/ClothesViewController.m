//
//  ClothesViewController.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/22.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "ClothesViewController.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"
#import "ClothesCollectionViewCell.h"
#import "ClothesCellInformation.h"
#import "ClothesTableViewCell.h"


@interface ClothesViewController ()< UITableViewDelegate, UITableViewDataSource, MBProgressHUDDelegate>
@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *clothesVogueArr;
@property(nonatomic, retain)UIView *headView;
@property(nonatomic, retain)UIButton *leftButton;
@property(nonatomic, retain)UIButton *rightbutton;
@property(nonatomic, retain)UILabel *centerLabel;
@property(nonatomic, retain)UICollectionView *collectionView;
@property(nonatomic, assign)NSInteger num;
@property(nonatomic, retain)MBProgressHUD *HUD;

@end

@implementation ClothesViewController
- (void)dealloc {
    [_tableView release];
    [_headView release];
    [_clothesVogueArr release];
    [_centerLabel release];
    [_collectionView release];
    [_HUD release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:24 / 255.0 green:23 / 255.0 blue:40 / 255.0 alpha:1];

    self.navigationController.navigationBar.translucent = YES;
    UILabel *clothesTitle = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 30, 15, 60, 20)];
    clothesTitle.text = @"潮流·穿";
    clothesTitle.textAlignment = NSTextAlignmentCenter;
    clothesTitle.textColor = [UIColor whiteColor];
    clothesTitle.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
    [self.navigationController.navigationBar addSubview:clothesTitle];
    [clothesTitle release];
    
    //    TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.275 green:0.305 blue:0.337 alpha:1.000];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.213 green:0.237 blue:0.259 alpha:1.000]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"viewBackLoad.png"]];
    [self.tableView setBackgroundView:imageView];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.275 green:0.305 blue:0.337 alpha:1.000];
    [_tableView release];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //  MBProgressHUD
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [_HUD release];
    self.HUD.minSize = CGSizeMake(120, 100);
    self.HUD.delegate = self;
    self.HUD.color = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    self.HUD.labelText = @"潮流";
    self.HUD.labelFont = [UIFont systemFontOfSize:14];
    self.HUD.detailsLabelText = @"正在准备";
    self.HUD.detailsLabelFont = [UIFont systemFontOfSize:12];
    [self.HUD show:YES];
    
//    CreateData
    self.num = 0;
    [self createData];

}

- (void)leftButtonAction {
    self.leftButton.backgroundColor = [UIColor lightGrayColor];
    self.rightbutton.backgroundColor = [UIColor clearColor];
}

- (void)rightButtonAction {
    self.rightbutton.backgroundColor = [UIColor lightGrayColor];
    self.leftButton.backgroundColor =[UIColor clearColor];
}

- (void)createData {
    NSString *bodyStr = @"appVersion=2.0.9.5&eskyToken=YTAzYTEyMTk0MWIxNWQzYzU3NmY3N2Y4ZmM5YmJiMGE%3D&pageIndex=1&pageSize=20&styleId=1";
    [DWLNetWorkingTool postBodyNetWorking:@"http://esky.esquire.com.cn:8080/trends/query/querySpecial.json" body:bodyStr success:^(id result) {
        self.clothesVogueArr = [NSMutableArray array];
        self.clothesVogueArr = [ClothesCellInformation baseModelByArr:result[@"data"]];
        [self.tableView reloadData];
        [self.HUD removeFromSuperview];
        self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footer)];
    } failure:^(id error) {
        NSLog(@"%@", error);
    }];
}

- (void)footer {
    self.num = self.num + 20;
    
    NSString *str1 = @"appVersion=2.0.9.5&eskyToken=YTAzYTEyMTk0MWIxNWQzYzU3NmY3N2Y4ZmM5YmJiMGE%3D&pageIndex=1&pageSize=";
    NSString *str2 = [str1 stringByAppendingString:[NSString stringWithFormat:@"%ld", self.num]];
    NSString *bodyStr = [str2 stringByAppendingString:@"&styleId=1"];
    
    [DWLNetWorkingTool postBodyNetWorking:@"http://esky.esquire.com.cn:8080/trends/query/querySpecial.json" body:bodyStr success:^(id result) {
        self.clothesVogueArr = [NSMutableArray array];
        self.clothesVogueArr = [ClothesCellInformation baseModelByArr:result[@"data"]];
        [self.tableView.footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(id error) {
        NSLog(@"%@", error);
    }];    
}

#pragma mark  TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.clothesVogueArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuse1 = @"reuse1";
    ClothesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
    if (!cell) {
        cell = [[[ClothesTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *arr = [[self.clothesVogueArr[indexPath.row] clothesImage] componentsSeparatedByString:@"|"];
    [cell.clothesImageView sd_setImageWithURL:[NSURL URLWithString:arr[1]] placeholderImage:[UIImage imageNamed:@"placeholderSmall.jpg"]];
    cell.clothesHeadLabel.text = [self.clothesVogueArr[indexPath.row] clothesTitle];
    cell.clothesIntroLabel.text = [self.clothesVogueArr[indexPath.row] desc];
    cell.clothesTextLabel.text = [@"# 潮流 · 私藏 & " stringByAppendingString:[self.clothesVogueArr[indexPath.row] publishtime]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    ClothesWebViewController *web = [[ClothesWebViewController alloc] init];
    NSString *str = [@"http://esky.esquire.com.cn:8080/html/special/" stringByAppendingString:[self.clothesVogueArr[indexPath.row] gid]];
    web.url = [str stringByAppendingString:@"_300.html?userId=(null)&device=iphone5&gender=(null)&version=2.0.9.5"];
//    [self.navigationController pushViewController:web animated:YES];
    [self presentViewController:web animated:YES completion:nil];
    [web release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return WIDTH + 20;
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
