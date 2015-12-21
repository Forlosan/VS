//
//  MoreTableViewController.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/26.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "MoreTableViewController.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"
#import "MoreFoodTableViewCell.h"
#import "MoreCellInformation.h"
#import "MoreWebViewController.h"
#import "SearchViewController.h"

@interface MoreTableViewController ()<UITableViewDelegate, UITableViewDataSource, MBProgressHUDDelegate>
@property(nonatomic, retain)UITableView *moreTableView;
@property(nonatomic, retain)NSMutableArray *moreArr;
@property(nonatomic, retain)UIImageView *imageView;
@property(nonatomic, assign)NSInteger num;
@property(nonatomic, retain)MBProgressHUD *HUD;
@property(nonatomic, assign)BOOL result;
@end

@implementation MoreTableViewController
- (void)dealloc {
    [_moreTableView release];
    [_moreArr release];
    [_imageView release];
    [_HUD release];
    
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
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [leftButton setTintColor:[UIColor whiteColor]];
    [leftButton addTarget:self action:@selector(leftButtonClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake(0, 0, 20, 20);
    [rightButton setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [rightButton setTintColor:[UIColor whiteColor]];
    [rightButton addTarget:self action:@selector(rightButtonClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    
    self.moreTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Load-1242*2208.png"]];
    [self.moreTableView setBackgroundView:imageView];
    [self.view addSubview:self.moreTableView];
    [_moreTableView release];
    self.moreTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.moreTableView.delegate = self;
    self.moreTableView.dataSource = self;
    
    //  MBProgressHUD
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [_HUD release];
    self.HUD.delegate = self;
    self.HUD.minSize = CGSizeMake(120, 100);
    self.HUD.color = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    self.HUD.labelText = @"美食";
    self.HUD.labelFont = [UIFont systemFontOfSize:14];
    self.HUD.detailsLabelText = @"正在准备";
    self.HUD.detailsLabelFont = [UIFont systemFontOfSize:12];
    [self.HUD show:YES];

    
//    imageView
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 35, (WIDTH - 40) / 3, (WIDTH - 40) / 4)];
//    [_imageView release];
    
//    Data
    self.num = 20;
    [self createData];
}

- (void)footer {
    NSString *str1 = [NSString string];
    NSString *str2 = [NSString string];
    if (self.num <= 80) {
        self.num = self.num + 30;
        str1 = [NSString stringWithFormat:@"http://a3.go2yd.com/Website/channel/news-list-for-channel?appid=food2&cend=%ld", self.num];
        str2 = [NSString stringWithFormat:@"&channel_id=1408443616&cstart=%ld", self.num - 30];
    } else {
        self.num = self.num + 29;
        str1 = [NSString stringWithFormat:@"http://a3.go2yd.com/Website/channel/news-list-for-channel?appid=food2&cend=%ld", self.num];
        str2 = [NSString stringWithFormat:@"&channel_id=1408443616&cstart=%ld", self.num - 30];
    }
    NSString *str3 = @"&cv=2.0.4&distribution=com.apple.appstore&fields%5B%5D=title&fields%5B%5D=url&fields%5B%5D=source&fields%5B%5D=date&fields%5B%5D=image&fields%5B%5D=image_urls&fields%5B%5D=comment_count&fields%5B%5D=like&infinite=true&net=wifi&platform=0&refresh=0&version=010904";
    NSString *str4 = [[str1 stringByAppendingString:str2] stringByAppendingString:str3];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"JSESSIONID=SAH0gO7Ju8QlSCgItd7HYQ" forHTTPHeaderField:@"Cookie"];
    [manager GET:str4 parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        for (NSDictionary *dic in responseObject[@"result"]) {
            NSMutableArray *arr = dic[@"image_urls"];
            if (arr.count == 3) {
                MoreCellInformation *moreCell = [[MoreCellInformation alloc] init];
                [moreCell setValuesForKeysWithDictionary:dic];
                [self.moreArr addObject:moreCell];
                [moreCell release];
            }
        }
        NSLog(@"%ld", self.num);
        [self.moreTableView.footer endRefreshing];
        [self.moreTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];

}

- (void)createData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"JSESSIONID=SAH0gO7Ju8QlSCgItd7HYQ" forHTTPHeaderField:@"Cookie"];
    [manager GET:@"http://a3.go2yd.com/Website/channel/news-list-for-channel?appid=food2&cend=30&channel_id=1408443616&cstart=0&cv=2.0.4&distribution=com.apple.appstore&fields%5B%5D=title&fields%5B%5D=url&fields%5B%5D=source&fields%5B%5D=date&fields%5B%5D=image&fields%5B%5D=image_urls&fields%5B%5D=comment_count&fields%5B%5D=like&infinite=true&net=wifi&platform=0&refresh=0&version=010904" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        self.moreArr = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"result"]) {
            NSMutableArray *arr = dic[@"image_urls"];
            if (arr.count == 3) {
                MoreCellInformation *moreCell = [[MoreCellInformation alloc] init];
                [moreCell setValuesForKeysWithDictionary:dic];
                [self.moreArr addObject:moreCell];
                [moreCell release];
            }
        }
        [self.moreTableView reloadData];
        [self.HUD removeFromSuperview];
        self.moreTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footer)];
        self.moreTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.moreTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 15);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld", self.moreArr.count);
    return self.moreArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuse1 = @"reuse1";
    MoreFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
    [cell.textLabel setHighlighted:NO];
    if (!cell) {
        cell = [[[MoreFoodTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.moreTitleLabel.text = [self.moreArr[indexPath.row] titleName];
    cell.moreTitleLabel.textColor = [UIColor colorWithRed:0.275 green:0.305 blue:0.337 alpha:1.000];
    cell.moreTextLabel.text = [@"# 美食 · 菜谱 & " stringByAppendingString:[self.moreArr[indexPath.row] source]];
    cell.moreTextLabel.textColor = [UIColor colorWithRed:0.275 green:0.305 blue:0.337 alpha:1.000];
    NSString *str1 = [self.moreArr[indexPath.row] image_urls][0];
    NSString *str2 = [self.moreArr[indexPath.row] image_urls][1];
    NSString *str3 = [self.moreArr[indexPath.row] image_urls][2];
    NSString *url1 = [[@"http://i3.go2yd.com/image.php?url=" stringByAppendingString:str1] stringByAppendingString:@"&type=thumbnail_900x000"];
    NSString *url2 = [[@"http://i3.go2yd.com//image.php?url=" stringByAppendingString:str2] stringByAppendingString:@"&type=thumbnail_900x000"];
    NSString *url3 = [[@"http://i3.go2yd.com/image.php?url=" stringByAppendingString:str3] stringByAppendingString:@"&type=thumbnail_900x000"];
    [cell.moreImageView1 sd_setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"placeholderWhite.jpg"]];
    [cell.moreImageView2 sd_setImageWithURL:[NSURL URLWithString:url2] placeholderImage:[UIImage imageNamed:@"placeholderWhite.jpg"]];
    [cell.moreImageView3 sd_setImageWithURL:[NSURL URLWithString:url3] placeholderImage:[UIImage imageNamed:@"placeholderWhite.jpg"]];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WIDTH / 4 + 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    MoreWebViewController *web = [[MoreWebViewController alloc] init];
    web.url = [self.moreArr[indexPath.row] urlid];
    [self presentViewController:web animated:YES completion:nil];
    [web release];
}

- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClick {
    SearchViewController *search = [[SearchViewController alloc] init];
    [self presentViewController:search animated:YES completion:^{
        
        
    }];
    [search release];
}

- (UIImage *)cutImage:(UIImage*)image
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (self.imageView.frame.size.width / self.imageView.frame.size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * self.imageView.frame.size.height / self.imageView.frame.size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height *self.imageView.frame.size.width / self.imageView.frame.size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
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
