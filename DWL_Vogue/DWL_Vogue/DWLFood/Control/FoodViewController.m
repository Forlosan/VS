//
//  FoodViewController.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/22.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "FoodViewController.h"
#import "VogueHeader.h"
#import "ScrollViewInformation.h"
#import "FoodTableViewCell.h"
#import "FoodCellInformation.h"
#import "MoreTableViewCell.h"
#import "FoodWebViewController.h"
#import "MoreTableViewController.h"
#import "WidthAndHeight.h"
#import "FoodScrollWebViewController.h"
#import "FoodCache.h"

@interface FoodViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate, MBProgressHUDDelegate>
@property(nonatomic, retain)UIScrollView *scrollView;
@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *scrollViewArr;
@property(nonatomic, retain)NSMutableArray *foodTableViewCellArr;
@property(nonatomic, assign)NSInteger scrollViewArrCount;
@property(nonatomic, retain)NSMutableArray *numArr;
@property(nonatomic, retain)MBProgressHUD *HUD;
@property(nonatomic, retain)NSMutableArray *colorArr;

@end

@implementation FoodViewController
- (void)dealloc {
    [_tableView release];
    [_scrollView release];
    [_scrollViewArr release];
    [_foodTableViewCellArr release];
    [_numArr release];
    [_HUD release];
    [_colorArr release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [DetectionNetworkStatusTool sharedClient];
    
//    title
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:24 / 255.0 green:23 / 255.0 blue:40 / 255.0 alpha:1];

    self.navigationController.navigationBar.translucent = YES;
    UILabel *foodTitle = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 30, 15, 60, 20)];
    foodTitle.text = @"美食·吃";
    foodTitle.textAlignment = NSTextAlignmentCenter;
    foodTitle.textColor = [UIColor whiteColor];
    foodTitle.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
    [self.navigationController.navigationBar addSubview:foodTitle];
    [foodTitle release];
    
    //    ScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, MYHEIGHT / 3 + 20)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [_scrollView release];
    self.scrollView.contentOffset = CGPointMake(WIDTH, 0);
    
//    TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.275 green:0.305 blue:0.337 alpha:1.000];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.213 green:0.237 blue:0.259 alpha:1.000]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"viewBackLoad.png"]];
    [self.tableView setBackgroundView:imageView];
    [self.view addSubview:self.tableView];
    [_tableView release];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.scrollView;

    
    //  MBProgressHUD
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [_HUD release];
    self.HUD.userInteractionEnabled = NO;
    self.HUD.minSize = CGSizeMake(120, 100);
    self.HUD.delegate = self;
    self.HUD.color = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    self.HUD.labelText = @"美食";
    self.HUD.labelFont = [UIFont systemFontOfSize:14];
    self.HUD.detailsLabelText = @"正在准备";
    self.HUD.detailsLabelFont = [UIFont systemFontOfSize:12];
    [self.HUD show:YES];
    
    //  timer
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    
//    CreateData
    [self createData];

}

#pragma mark  CreateData
- (void)createData {
//    ScrollView
    AFHTTPSessionManager *managerScroll = [AFHTTPSessionManager manager];
    managerScroll.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"text/javascript", @"text/html", @"application/json", nil];
    [managerScroll POST:@"http://www.ecook.cn/public/getHomeContents.shtml" parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSLog(@"scroll");
        NSDictionary *dic = responseObject;
        self.scrollViewArr = [ScrollViewInformation baseModelByArr:dic[@"topRecommends"]];
        
        NSString *sandBoxPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
        //  2. 给文件拼接路径
        NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"foodCaches.plist"];
        
        [NSKeyedArchiver archiveRootObject:self.scrollViewArr toFile:docPath];
        self.scrollViewArrCount = self.scrollViewArr.count;
//        ScrollView
        self.scrollView.contentSize = CGSizeMake(WIDTH * (self.scrollViewArr.count + 2), 0);
        self.tableView.tableHeaderView = self.scrollView;
        
//        firstScrollImageView
        UIImageView *firstScrollImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, MYHEIGHT / 3 + 20)];
        [firstScrollImageView sd_setImageWithURL:[NSURL URLWithString:[self.scrollViewArr[self.scrollViewArrCount - 1] imageid]] placeholderImage:[UIImage imageNamed:@"placeholderBig.jpg"]];
        [self.scrollView addSubview:firstScrollImageView];
        [firstScrollImageView release];
//        centre
        for (NSInteger i = 0; i < self.scrollViewArrCount; i++) {
            UIImageView *scrollImageView= [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * (i + 1), 0, WIDTH, MYHEIGHT / 3 + 20)];
            [scrollImageView sd_setImageWithURL:[NSURL URLWithString:[self.scrollViewArr[i] imageid]]placeholderImage:[UIImage imageNamed:@"placeholderBig.jpg"]];
            [self.scrollView addSubview:scrollImageView];
            [scrollImageView release];
            UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClick:imageView:)];
            imageTap.delegate = self;
            [scrollImageView addGestureRecognizer:imageTap];
            [imageTap release];
            scrollImageView.userInteractionEnabled = YES;
            scrollImageView.tag = 100 + i;
        }
//        last
        UIImageView *lastScrollImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * (self.scrollViewArrCount + 1), 0, WIDTH, MYHEIGHT / 3 + 20)];
        [lastScrollImageView sd_setImageWithURL:[NSURL URLWithString:[self.scrollViewArr[0] imageid]]placeholderImage:[UIImage imageNamed:@"placeholderBig.jpg"]];
        [self.scrollView addSubview:lastScrollImageView];
        [lastScrollImageView release];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"SCROLL失败: %@", error);
        //            scroll
        //  1. 找路径
        NSString *sandBoxPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
        //  2. 给文件拼接路径
        NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"foodCaches.plist"];
        //  3. 反归档
        NSMutableArray *tempArr = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];
        self.scrollViewArr = [NSMutableArray array];
        self.scrollViewArr = tempArr;
        self.scrollViewArrCount = self.scrollViewArr.count;
        //  ScrollView
        self.scrollView.contentSize = CGSizeMake(WIDTH * (self.scrollViewArr.count + 2), 0);
        self.tableView.tableHeaderView = self.scrollView;
        
        //  firstScrollImageView
        UIImageView *firstScrollImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, MYHEIGHT / 3 + 20)];
        [firstScrollImageView sd_setImageWithURL:[NSURL URLWithString:[self.scrollViewArr[self.scrollViewArrCount - 1] imageid]]];
        [self.scrollView addSubview:firstScrollImageView];
        [firstScrollImageView release];
        //  centre
        for (NSInteger i = 0; i < self.scrollViewArrCount; i++) {
            UIImageView *scrollImageView= [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * (i + 1), 0, WIDTH, MYHEIGHT / 3 + 20)];
            [scrollImageView sd_setImageWithURL:[NSURL URLWithString:[self.scrollViewArr[i] imageid]]];
            [self.scrollView addSubview:scrollImageView];
            [scrollImageView release];
            UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClick:imageView:)];
            imageTap.delegate = self;
            [scrollImageView addGestureRecognizer:imageTap];
            [imageTap release];
            scrollImageView.userInteractionEnabled = YES;
            scrollImageView.tag = 100 + i;
        }
        //  last
        UIImageView *lastScrollImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * (self.scrollViewArrCount + 1), 0, WIDTH, MYHEIGHT / 3 + 20)];
        [lastScrollImageView sd_setImageWithURL:[NSURL URLWithString:[self.scrollViewArr[0] imageid]]];
        [self.scrollView addSubview:lastScrollImageView];
        [lastScrollImageView release];
    }];
//   FoodCell
    AFHTTPSessionManager *managerCell = [AFHTTPSessionManager manager];
    managerCell.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"text/javascript", @"text/html", @"application/json", nil];
    [managerCell GET:@"http://app.iliangcang.com/topic/listinfo?app_key=iphone&build=148&cat_id=9&osVersion=83&sig=300594866%7C6a2ffbf219f851162991b380978528e757157501&user_id=300594866&v=2.2.5" parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *keysArr = responseObject[@"data"][@"keys"];
        self.foodTableViewCellArr = [NSMutableArray array];
        for (NSInteger i = 0; i < keysArr.count; i++) {
            NSDictionary *dic = responseObject[@"data"][@"infos"];
            for (NSMutableDictionary *dic1 in dic[keysArr[i]]) {
                FoodCellInformation *food = [[FoodCellInformation alloc] init];
                [food setValuesForKeysWithDictionary:dic1];
                [self.foodTableViewCellArr addObject:food];
                [food release];
            }
        };
        NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"MyCaches/foodCellCaches.plist"];
        [NSKeyedArchiver archiveRootObject:self.foodTableViewCellArr toFile:docPath];
        [self.tableView reloadData];
        [self.HUD removeFromSuperview];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"CELL失败: %@", error);
//        cell
        //  1. 找路径
        NSString *sandCellBoxPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
        //  2. 给文件拼接路径
        NSString *docCellPath = [sandCellBoxPath stringByAppendingPathComponent:@"foodCellCaches.plist"];
        //  3. 反归档
        NSMutableArray *tempCellArr = [NSKeyedUnarchiver unarchiveObjectWithFile:docCellPath];
        self.foodTableViewCellArr = [NSMutableArray array];
        self.foodTableViewCellArr = tempCellArr;
        [self.tableView reloadData];
        [self.HUD removeFromSuperview];
    }];
    
}

#pragma mark  ScrollView
- (void)scrollViewClick:(UITapGestureRecognizer *)tap imageView:(UIImageView *)imageView {
    FoodScrollWebViewController *web = [[FoodScrollWebViewController alloc] init];
    web.url = [self.scrollViewArr[tap.view.tag - 100] uri];
    NSLog(@"%@", web.url);
//    [self.navigationController pushViewController:web animated:YES];
    [self presentViewController:web animated:YES completion:nil];
    [web release];
}

- (void)changeImage {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + WIDTH, 0) animated:NO];
    NSInteger i = self.scrollViewArr.count;
    if (self.scrollView.contentOffset.x == (i + 1) * WIDTH) {
        self.scrollView.contentOffset = CGPointMake(WIDTH, 0);
    } else if (self.scrollView.contentOffset.x == 0) {
        self.scrollView.contentOffset = CGPointMake(i * WIDTH, 0);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger i = self.scrollViewArr.count;
    if (self.scrollView.contentOffset.x == (i + 1) * WIDTH) {
        self.scrollView.contentOffset = CGPointMake(WIDTH, 0);
    } else if (self.scrollView.contentOffset.x == 0) {
        self.scrollView.contentOffset = CGPointMake(i * WIDTH, 0);
    }
}

#pragma mark  TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.foodTableViewCellArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *reuse = @"reuse";
        MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (!cell) {
            cell = [[[MoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse] autorelease];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:0.275 green:0.305 blue:0.337 alpha:1.000];
        cell.moreImageView.image = [UIImage imageNamed:@"more.png"];
//        [cell.moreImageView.layer addSublayer:[self shadowAsInverse]];
        return cell;

    } else {
        static NSString *reuse1 = @"reuse1";
        FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (!cell) {
            cell = [[[FoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1] autorelease];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.foodimageView sd_setImageWithURL:[NSURL URLWithString:[self.foodTableViewCellArr[indexPath.row - 1] cover_img_new]] placeholderImage:[UIImage imageNamed:@"placeholderBig.jpg"]];
        cell.foodHeadLabel.text = [self.foodTableViewCellArr[indexPath.row - 1] topic_name];
        NSString *str = [[self.foodTableViewCellArr[indexPath.row] addtime] substringWithRange:NSMakeRange(0, 10)];
        cell.foodTextLabel.text = [@"# 美食 · " stringByAppendingString:str];
        [cell.foodTextLabel setHighlighted:NO];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.row == 0) {
#pragma mark  more
        MoreTableViewController *moreTVC = [[MoreTableViewController alloc] init];
        [self.navigationController pushViewController:moreTVC animated:YES];
        [moreTVC release];
    } else {
        FoodWebViewController *web = [[FoodWebViewController alloc] init];
        web.url = [self.foodTableViewCellArr[indexPath.row] topic_url];
//        [self.navigationController pushViewController:web animated:YES];
        [self presentViewController:web animated:YES completion:nil];
        [web release];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return MYHEIGHT / 3;
    } else {
    return MYHEIGHT / 3 + 20;
    }
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
