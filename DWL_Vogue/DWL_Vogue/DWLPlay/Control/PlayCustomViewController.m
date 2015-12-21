//
//  PlayCustomViewController.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/28.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "PlayCustomViewController.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"
#import "TextTableViewCell.h"
#import "TextCellInformation.h"
#import "Text2TableViewCell.h"
#import "SaveTool.h"
#import "UMSocial.h"

@interface PlayCustomViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *textArr;
@property(nonatomic, retain)NSMutableArray *imageTextArr;
@property(nonatomic, retain)UIImageView *headImageView;
@property(nonatomic, assign)NSInteger sum;
@property(nonatomic, retain)NSString *dayStr;
@property(nonatomic, assign)BOOL result;
@property(nonatomic, retain)UIAlertView *alert;
@property(nonatomic, retain)UIButton *collectButton;
@property(nonatomic, retain)NSString *nameStr;
@property(nonatomic, retain)UIActivityIndicatorView *acView;
@property(nonatomic, retain)NSString *text1;
@property(nonatomic, retain)NSMutableArray *daysArr;

@end

@implementation PlayCustomViewController
- (void)dealloc {
    [_url release];
    [_imageUrl release];
    [_tableView release];
    [_textArr release];
    [_imageTextArr release];
    [_headImageView release];
    [_dayStr release];
    [_alert release];
    [_play release];
    [_nameStr release];
    [_acView release];
    [_text1 release];
    [_daysArr release];
    [_numID release];
    [_titleName release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@", self.url);
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [_tableView release];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    CellBackView
    UIView *cellBackView = [[UIView alloc
                         ] initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
    cellBackView.backgroundColor = [UIColor colorWithRed:0.807 green:0.861 blue:0.861 alpha:0];
    [self.view addSubview:cellBackView];
    cellBackView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.1];
    [cellBackView release];
    //  backButton
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(10, 20, 30, 30);
    [backButton setImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [backButton setTintColor:[UIColor whiteColor]];
    [cellBackView addSubview:backButton];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    //  shareButton
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    shareButton.frame = CGRectMake(WIDTH - 40, 25, 20, 20);
//    [shareButton setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    imageView.image = [UIImage imageNamed:@"share.png"];
    [shareButton addSubview:imageView];
    shareButton.frame = CGRectMake(WIDTH - 40, 20, 30, 30);
    [shareButton setTintColor:[UIColor whiteColor]];
    [cellBackView addSubview:shareButton];
    [shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    
    //  collectButton
    self.collectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.collectButton.frame = CGRectMake(WIDTH - 80, 25, 20, 20);
    [_collectButton setImage:[UIImage imageNamed:@"collect.png"] forState:UIControlStateNormal];
    [cellBackView addSubview:self.collectButton];
    
    if ([SaveTool isHavePlayInPlist:self.play]) {
        [self.collectButton setTintColor:[UIColor whiteColor]];
        [self.collectButton addTarget:self action:@selector(collectAction) forControlEvents:UIControlEventTouchUpInside];
        self.result = YES;
    } else {
        [self.collectButton setTintColor:[UIColor colorWithRed:39 / 255.0 green:38 / 255.0 blue:55 / 255.0 alpha:1]];
        [self.collectButton addTarget:self action:@selector(collectAction) forControlEvents:UIControlEventTouchUpInside];
        self.result = NO;
    }
    
//    HeadView
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT / 3 + 30)];
    self.tableView.tableHeaderView = headView;
    [headView release];
    //  headImageView
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT / 3)];
    [headView addSubview:self.headImageView];
    [_headImageView release];
    //  headLabel
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT / 3, WIDTH, 30)];
    headLabel.text = @"寻找心灵的旅程";
    headLabel.textColor = [UIColor colorWithWhite:0.123 alpha:1.000];
    headLabel.font = [UIFont systemFontOfSize:10];
    headLabel.textAlignment = 1;
    [headView addSubview:headLabel];
    [headLabel release];
    
//    acView
    self.acView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 32.0f, 32.0f)];
    self.acView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.acView.center = self.view.center;
    [self.view addSubview:self.acView];
    [_acView release];
    [self.acView startAnimating];
    
    [self createData];
}

- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)shareAction {
    NSString *title1 = [@"#<Vogue Show>寻找心的旅程#\n" stringByAppendingString:self.nameStr];
    NSString *title2 = [title1 stringByAppendingString:@"// \n"];
    NSLog(@"%@", [self.textArr[0] descriptionText]);
    if ([self.textArr[0] descriptionText].length == 0) {
        self.text1 = [[self.textArr[1] descriptionText] substringWithRange:NSMakeRange(0, 20)];
    } else {
        self.text1 = [[self.textArr[0] descriptionText] substringWithRange:NSMakeRange(0, 20)];
    }
    NSString *text2 = [self.text1 stringByAppendingString:@"...\n"];
    NSString *tt = [title2 stringByAppendingString:text2];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageUrl]];
    UIImage *image = [UIImage imageWithData:data];

    //  分享
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"563c14a267e58ebf8e0029f0" shareText:tt shareImage:image shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToWechatTimeline,UMShareToRenren,nil] delegate:nil];
    //  UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToRenren
    
    //  设置点击分享内容跳转链接
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [@"http://chanyouji.com/trips/" stringByAppendingString:self.numID];
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = [@"http://chanyouji.com/trips/" stringByAppendingString:self.numID];
    //  设置title
    [UMSocialData defaultData].extConfig.wechatSessionData.title = self
    .titleName;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.titleName;

}

- (void)collectAction {
    if (self.result) {
        [self.collectButton setTintColor:[UIColor colorWithRed:39 / 255.0 green:38 / 255.0 blue:55 / 255.0 alpha:1]];
        self.alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        self.alert.alertViewStyle = UIAlertViewStyleDefault;
        [_alert release];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(dismissAlertView:) userInfo:nil repeats:NO];
        [self.alert show];
        [SaveTool savePlayToPlist:self.play];
        self.result = NO;
        
    } else {
        [self.collectButton setTintColor:[UIColor whiteColor]];
        self.alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已取消收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        self.alert.alertViewStyle = UIAlertViewStyleDefault;
        [_alert release];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(dismissAlertView:) userInfo:nil repeats:NO];
        [self.alert show];
        
        [SaveTool cancelPlayInPlist:self.play];
        self.result = YES;
    }

}

//  timer
- (void)dismissAlertView:(NSTimer *)timer {
    [self.alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)createData {
    [DWLNetWorkingTool getBodyNetWorking:self.url body:nil success:^(id result) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
        NSLog(@"%@", result);
        self.textArr = [NSMutableArray array];
#pragma mark
        for (NSMutableDictionary *daysDic in result[@"trip_days"]) {
            self.nameStr = result[@"name"];
            for (NSMutableDictionary *nodesDic in daysDic[@"nodes"]) {
                for (NSMutableDictionary *notesDic in nodesDic[@"notes"]) {
                    TextCellInformation *textCell = [[TextCellInformation alloc] init];
                    [textCell setValuesForKeysWithDictionary:notesDic];
                    [self.textArr addObject:textCell];
                    [textCell release];
                }
            }
        }
        [self.tableView reloadData];
        [self.acView stopAnimating];
    } failure:^(id error) {
        NSLog(@"%@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.textArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.textArr[indexPath.row] photo] == nil) {
        static NSString *reuse = @"reuse";
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (!cell) {
            cell = [[[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse] autorelease];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:0.958 green:0.990 blue:1.000 alpha:1.000];
        cell.playTextLabel.text = [self.textArr[indexPath.row] descriptionText];
        return cell;
    }
    else {
        static NSString *reuse1 = @"reuse1";
        Text2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (!cell) {
            cell = [[[Text2TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1] autorelease];
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:0.958 green:0.990 blue:1.000 alpha:1.000];
        cell.playTextLabel.text = [self.textArr[indexPath.row] descriptionText];
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:       [self.textArr[indexPath.row] photo][@"url"]]];
//        cell.playImageView.image = [UIImage imageWithData:data];
        
//        [cell setImageHeight:200];
        [cell.playImageView sd_setImageWithURL:[NSURL URLWithString:[self.textArr[indexPath.row] photo][@"url"]] placeholderImage:[UIImage imageNamed:@"placeholderBlue.jpg"]];
    return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.textArr[indexPath.row] photo][@"url"]]];
//    UIImage *image = [UIImage imageWithData:data];
////
//    CGFloat picHeight = self.view.frame.size.width * image.size.height / image.size.width;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16], NSFontAttributeName , nil];
    
    CGRect rect = [[self.textArr[indexPath.row] descriptionText] boundingRectWithSize:CGSizeMake(WIDTH - 30, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    if ([self.textArr[indexPath.row] photo] == nil) {
        
        return rect.size.height + 20;
    }
        else {
        
//
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16], NSFontAttributeName , nil];
//        
//         CGRect rect = [[self.textArr[indexPath.row] descriptionText] boundingRectWithSize:CGSizeMake(WIDTH - 30, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        return (WIDTH - 20) / 4 * 3 + 20 + rect.size.height + 10;
//            return picHeight + rect.size.height + 40;
    }
}

#pragma mark 分享微信
//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
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
