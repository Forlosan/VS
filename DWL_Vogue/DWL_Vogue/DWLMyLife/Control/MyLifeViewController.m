//
//  MyLifeViewController.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/22.
//  Copyright (c) 2015年 Forlosan. All rights reserved.                          
//

#import "MyLifeViewController.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"
#import "LifeViewController.h"
#import "MyLifeWebViewController.h"
#import "MyLifeBigeWebViewController.h"
#import "BigeInformation.h"


@interface MyLifeViewController ()<UITableViewDelegate, UITableViewDataSource, LifeViewControllerDelegate, MBProgressHUDDelegate>
@property(nonatomic, retain)UIButton *titleButton;
@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *myLifeArr;
@property(nonatomic, retain)NSString *strURl;
@property(nonatomic, retain)NSString *strURLBlock;
@property(nonatomic, retain)NSString *titleName;
@property(nonatomic, retain)MBProgressHUD *HUD;

@end

@implementation MyLifeViewController
- (void)dealloc {
    [_tableView release];
    [_myLifeArr release];
    [_strURl release];
    [_strURLBlock release];
    [_titleName release];
    [_HUD release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:24 / 255.0 green:23 / 255.0 blue:40 / 255.0 alpha:1];

    self.navigationController.navigationBar.translucent = YES;
    self.titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.titleButton.frame = CGRectMake(WIDTH / 2 - 50, 15, 100, 20);
    [self.titleButton setTitle:@"时尚·生活↓" forState:UIControlStateNormal];
    [self.titleButton setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar addSubview:self.titleButton];
    self.titleButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
    [self.navigationController.navigationBar addSubview:self.titleButton];
    [self.titleButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    //    TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"viewBackLoad.png"]];
    [self.tableView setBackgroundView:imageView];
    [self.view addSubview:self.tableView];
    [_tableView release];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    createData
    [self createData];
    
}

- (void)createData {
    //  MBProgressHUD
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [_HUD release];
//    self.HUD.minSize = CGSizeMake(120, 100);
    self.HUD.delegate = self;
    self.HUD.color = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    self.HUD.labelText = @"Vogue Show";
    self.HUD.labelFont = [UIFont systemFontOfSize:14];
    self.HUD.detailsLabelText = @"正在准备";
    self.HUD.detailsLabelFont = [UIFont systemFontOfSize:12];
    [self.HUD show:YES];
    
    if (self.strURl == nil) {
        self.strURl = BIGE;
        self.titleName = @"生活 · 格调";
    } else {
        self.strURl = self.strURLBlock;
    }
    if ([self.strURl isEqualToString:BIGE]) {
        [DWLNetWorkingTool getBodyNetWorking:self.strURl body:nil success:^(id result) {
            self.myLifeArr = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in result[@"data"][@"items"]) {
                if (dic[@"article"] != nil) {
                    BigeInformation *bige = [[BigeInformation alloc] init];
                    [bige setValuesForKeysWithDictionary:dic];
                    [self.myLifeArr addObject:bige];
                    [bige release];
                }
            }
            [_myLifeArr release];
            [self.tableView reloadData];
            [self.HUD removeFromSuperview];
        } failure:^(id error) {
            NSLog(@"%@", error);
        }];
    } else {
        [DWLNetWorkingTool getBodyNetWorking:self.strURl body:nil success:^(id result) {
            NSArray *keysArr = result[@"data"][@"keys"];
            self.myLifeArr = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < keysArr.count; i++) {
                NSDictionary *dic = result[@"data"][@"infos"];
                for (NSMutableDictionary *dic1 in dic[keysArr[i]]) {
                    FoodCellInformation *food = [[FoodCellInformation alloc] init];
                    [food setValuesForKeysWithDictionary:dic1];
                    [self.myLifeArr addObject:food];
                    [food release];
                }
            };
            [_myLifeArr release];
            [self.tableView reloadData];
            [self.HUD removeFromSuperview];
        } failure:^(id error) {
            NSLog(@"%@", error);
        }];
    }
}

- (void)click {
    [self.HUD removeFromSuperview];
    LifeViewController *lifeVC = [[LifeViewController alloc] init];
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:lifeVC animated:YES completion:Nil];
    [lifeVC release];
    
    void (^block)(NSString *) = ^(NSString *url) {
        self.strURLBlock = url;
        [self createData];
        //  单行刷新
        //    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    };
    lifeVC.block = block;
    
    lifeVC.delegate = self;
//    void (^block1)(NSString *) = ^(NSString *titleName) {
//        self.titleName = titleName;
//    };
//    lifeVC.block1 = block1;
    
}

- (void)takeName:(NSString *)str {
    self.titleName = str;
}

#pragma mark  TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myLifeArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.titleName isEqualToString:@"生活 · 格调"]) {
        static NSString *reuse1 = @"reuse1";
        FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (!cell) {
            cell = [[[FoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1] autorelease];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *url = [self.myLifeArr[indexPath.row] pic][@"url"];
        [cell.foodimageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholderBig.jpg"]];
        cell.foodHeadLabel.text = [self.myLifeArr[indexPath.row] titleName];
        NSString *bige = [self.myLifeArr[indexPath.row] content];
        cell.foodTextLabel.text = [@"# 生活 · 格调 & " stringByAppendingString:bige];
        [cell.foodTextLabel setHighlighted:NO];
        return cell;
        
    } else {
        static NSString *reuse1 = @"reuse1";
        FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (!cell) {
            cell = [[[FoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1] autorelease];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.foodimageView sd_setImageWithURL:[NSURL URLWithString:[self.myLifeArr[indexPath.row] cover_img_new]] placeholderImage:[UIImage imageNamed:@"placeholderBig.jpg"]];
        cell.foodHeadLabel.text = [self.myLifeArr[indexPath.row] topic_name];
        NSString *str = [[self.myLifeArr[indexPath.row] addtime] substringWithRange:NSMakeRange(0, 10)];
        NSString *str1 = [[@"# " stringByAppendingString:self.titleName] stringByAppendingString:@" & "];
        cell.foodTextLabel.text = [str1 stringByAppendingString:str];
        [cell.foodTextLabel setHighlighted:NO];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if ([self.titleName isEqualToString:@"生活 · 格调"]) {
        MyLifeBigeWebViewController *web = [[MyLifeBigeWebViewController alloc] init];
        web.url = [self.myLifeArr[indexPath.row] article][@"weburl"];
        web.titleName = self.titleName;
        [self presentViewController:web animated:YES completion:nil];
        [web release];
    } else {
        MyLifeWebViewController *web = [[MyLifeWebViewController alloc] init];
        web.url = [self.myLifeArr[indexPath.row] topic_url];
        web.titleName = self.titleName;
        [self presentViewController:web animated:YES completion:nil];
        [web release];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MYHEIGHT / 3 + 20;
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
