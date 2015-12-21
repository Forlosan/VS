//
//  CollectViewController.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/31.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "CollectViewController.h"
#import "WidthAndHeight.h"
#import "VogueHeader.h"
#import "PlayCellInformation.h"
#import "PlayCustomViewController.h"


@interface CollectViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property(nonatomic, retain)UITableView *collectTableView;
@property(nonatomic, assign)BOOL result;
@property(nonatomic, retain)NSMutableAttributedString *attribute;
@property(nonatomic, retain)UIAlertView *alert;

@end

@implementation CollectViewController
- (void)dealloc {
    [_str release];
    [_imageStr release];
    [_collectTableView release];
    [_collectArr release];
    [_attribute release];
    [_alert release];
//    self.searchBar.delegate = nil;
    
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    
    //    TableView
    self.collectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.collectTableView];
    [_collectTableView release];
    self.collectTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"viewBackLoad.png"]];
//    self.collectTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Load-1242*2208.png"]];
    self.collectTableView.delegate = self;
    self.collectTableView.dataSource = self;
    self.collectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [self.view addSubview:headView];
    headView.backgroundColor = [UIColor colorWithRed:54 / 255.0 green:53 / 255.0 blue:68 / 255.0 alpha:1];
    [headView release];
    
    UIButton *headButton = [UIButton buttonWithType:UIButtonTypeSystem];
    headButton.frame = CGRectMake(16, 25, 32, 32);
    [headButton setImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [headButton setTintColor:[UIColor whiteColor]];
    [headView addSubview:headButton];
    [headButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *collectTitle = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 30, 32, 60, 20)];
    collectTitle.text = @"收藏";
    collectTitle.textAlignment = NSTextAlignmentCenter;
    collectTitle.textColor = [UIColor whiteColor];
    collectTitle.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
    [headView addSubview:collectTitle];
    [collectTitle release];
    
    NSLog(@"dsfasdf%ld", self.collectArr.count);
    if (self.collectArr.count == 0) {
        self.alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有可以旅行的收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        self.alert.alertViewStyle = UIAlertViewStyleDefault;
        [_alert release];
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismissAlert) userInfo:nil repeats:NO];
        [self.alert show];
    }
    
}

- (void)dismissAlert {
    [self.alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)leftButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.collectArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuse = @"reuse";
    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[[FoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PlayCellInformation *play = self.collectArr[indexPath.row];
    [cell.foodimageView sd_setImageWithURL:[NSURL URLWithString:play.front_cover_photo_url]];
    cell.foodHeadLabel.text = play.playTitleName;
    NSString *date = [self.collectArr[indexPath.row] start_date];
    cell.foodTextLabel.text = [NSString stringWithFormat:@"# 旅行 · %@ & %@ 天", date, play.days.stringValue, nil];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MYHEIGHT * 4 / 9;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayCustomViewController *custom = [[PlayCustomViewController alloc] init];
    NSString *numId = [self.collectArr[indexPath.row] numId].stringValue;
    custom.url = [[@"http://chanyouji.com/api/trips/" stringByAppendingString:numId] stringByAppendingString:@".json"];
    custom.imageUrl = [self.collectArr[indexPath.row] front_cover_photo_url];
    custom.play = self.collectArr[indexPath.row];
    [self presentViewController:custom animated:YES completion:nil];
    [custom release];
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
