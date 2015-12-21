//
//  PersonViewController.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/22.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "PersonViewController.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"
#import "SetPersonTableViewCell.h"
#import "CollectViewController.h"
#import "SetViewController.h"
#import "Singleton.h"
#import <MessageUI/MessageUI.h>
#import "UMSocial.h"
#import "OursViewController.h"

@interface PersonViewController ()<UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate>
@property(nonatomic, retain)UITableView *personTableView;
@property(nonatomic, assign)NSUInteger num;
@property(nonatomic, retain)NSArray *imageArr;
@property(nonatomic, retain)NSArray *nameArr;
@property(nonatomic, assign)NSInteger row;
@property(nonatomic, retain)UILabel *nameLabel;
@property(nonatomic, retain)UIImageView *avatarImageView;
@property(nonatomic, retain)NSArray *name2Arr;
@property(nonatomic, retain)UITableView *setTableView;
@property(nonatomic, retain)UIAlertView *alertView;
@property(nonatomic, retain)UIAlertAction *archiveAction;
@property(nonatomic, retain)UIAlertView *logAlertView;
@property(nonatomic, retain)UIAlertView *successAlert;
@property(nonatomic, retain)UIAlertView *versionAlert;

@end

@implementation PersonViewController
- (void)dealloc {
    [_personTableView release];
    [_nameArr release];
    [_imageArr release];
    [_nameLabel release];
    [_avatarImageView release];
    [_name2Arr release];
    [_setTableView release];
    [_alertView release];
    [_archiveAction release];
    [_logAlertView release];
    [_successAlert release];
    [_versionAlert release];
    
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.imageArr = @[@"iconfont-lvyou.png", @"chi.jpg", @"big.jpg", @"wan.jpg", @"set.png"];
        self.nameArr = @[@"旅游 · 玩", @"美食 · 吃", @"潮流 · 穿", @"生活 · BIG", @"设置"];
        self.name2Arr = @[@"清除缓存", @"意见反馈", @"关于我们", @"版本检测", @"登录"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:24 / 255.0 green:23 / 255.0 blue:40 / 255.0 alpha:1];
    self.navigationController.navigationBar.translucent = YES;
    UILabel *personTitle = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 30, 15, 60, 20)];
    personTitle.text = @"个人";
    personTitle.textAlignment = NSTextAlignmentCenter;
    personTitle.textColor = [UIColor whiteColor];
    personTitle.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
    [self.navigationController.navigationBar addSubview:personTitle];
    [personTitle release];
  
//    HeadView
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT / 3)];
    [self.view addSubview:headView];
    [headView release];
    
//    backImageView
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT / 3)];
    backImageView.image = [UIImage imageNamed:@"person.jpg"];
    [headView addSubview:backImageView];
    [backImageView release];
    

    
    //  nameLabel
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, HEIGHT / 6 + 10, 150, 30)];
    [headView addSubview:self.nameLabel];
    self.nameLabel.text = [Singleton shareSingleton].titleStr;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    [_nameLabel release];

//    TableView
    self.personTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:self.personTableView];
    self.personTableView.tableHeaderView = headView;
    [_personTableView release];
    self.personTableView.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:238 / 255.0 blue:244 / 255.0 alpha:1];
    self.personTableView.delegate = self;
    self.personTableView.dataSource = self;
    

    NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [sandBoxPath stringByAppendingPathComponent:@"MY.sqlite"];
    
    int result = sqlite3_open([dbPath UTF8String], &dbPoint);
    if (result == SQLITE_OK) {
        NSLog(@"开启成功");
    } else {
        NSLog(@"开启失败");
    }
    NSLog(@"%@", dbPath);
    
//    CreateData
    self.num = 100;
    [self createData];
    
}

- (void)avatarButtonAction {
    
}

- (void)createData {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if (section == 1){
        return 1;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *reuse = @"reuse";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
        cell.textLabel.text = self.name2Arr[indexPath.row];
        //        [cell.textLabel setHighlighted:NO];
        return cell;
    } else if (indexPath.section == 1) {
        static NSString *CellIdentifier = @"Cell";
        SetPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[SetPersonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.setImageView.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
        cell.setImageView.backgroundColor = [UIColor whiteColor];
        cell.setLabel.text = self.nameArr[indexPath.row];
        self.row = indexPath.row;
        return cell;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.num = indexPath.row;
    if (indexPath.section == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.row == 0) {
            
            
            // 创建一个文件管理者
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSLog(@"%@", cachePath);
            CGFloat cacheSize = [self folderSizeAtPath:cachePath];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@%.2fM", @"清除共", cacheSize] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self clearCache:cachePath];
            }];
            [alert addAction:alertok];
            UIAlertAction *alertaction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }];
            [alert addAction:alertaction];
            [self presentViewController:alert animated:YES completion:^{
            }];
        } else if (indexPath.row == 1) {
            [self sendEmail];
        } else if (indexPath.row == 2) {
            OursViewController *ours = [[OursViewController alloc] init];
            [self presentViewController:ours animated:YES completion:nil];
            [ours release];
        }
//        } else if (indexPath.row == 3) {
//            NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];    //获取项目名称
//            
//            NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];      //获取项目版本号
//            
//            
//            
//            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//            CFShow(infoDictionary);
//            // app名称
//            NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
//            // app版本
//            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//            // app build版本
//            NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
//            NSString *app = [@"Vogue Show当前版本 " stringByAppendingString:app_build];
//            self.versionAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:app delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
//            self.versionAlert.alertViewStyle = UIAlertViewStyleDefault;
//            
//            [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismissAlertView:) userInfo:nil repeats:NO];
//            [self.versionAlert show];
//        }
        
    } else {
        if (indexPath.row == 0) {
            [self.personTableView reloadData];
            CollectViewController *collect = [[CollectViewController alloc] init];
            collect.imageStr = self.imageArr[indexPath.row];
            collect.str = self.nameArr[indexPath.row];
            NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/MyCollect/play.plist"];
            NSMutableArray *playArr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            collect.collectArr = playArr;
            [self presentViewController:collect animated:YES completion:nil];
            [collect release];
        }
        
    [self.personTableView reloadData];
//    CollectViewController *collect = [[CollectViewController alloc] init];
//    collect.imageStr = self.imageArr[indexPath.row];
//    collect.str = self.nameArr[indexPath.row];
//    [self presentViewController:collect animated:YES completion:nil];
//    [collect release];
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"  设置";
    } else if (section == 1) {
        return @"  我的收藏";
    } else {
        return @" ";
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.personTableView.contentSize = CGSizeMake(0, HEIGHT - 108);
}

//  自定义section
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    // Create label with section title
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.frame = CGRectMake(12, 5, 300, 20);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    label.text = sectionTitle;
    
    // Create header view and add label as a subview
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)] autorelease];
    [sectionView setBackgroundColor:[UIColor colorWithRed:239 / 255.0 green:238 / 255.0 blue:244 / 255.0 alpha:1]];
    [sectionView addSubview:label];
    return sectionView;
}

- (void)dismissAlertView:(NSTimer *)timer {
    [self.versionAlert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)successAlertView:(NSTimer *)timer {
    [self.successAlert dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark 清除缓存
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
    }else if (buttonIndex == 1) {
        // 创建一个文件管理者
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        [self clearCache:cachePath];
    }
}
-(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}
- (float )folderSizeAtPath:(NSString *)folderPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath])
        return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize / (1024.0 * 1024.0);
}

- (long long)fileSizeAtPath:(NSString *)filePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

- (void)dismissLogAlertView:(NSTimer *)timer {
    [self.logAlertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)addAction:(UIAlertAction *)action {
    if (action == self.archiveAction) {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            
            //  获取微博用户名、uid、token等
            
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                
                NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                [self dismissViewControllerAnimated:YES completion:nil];
                [Singleton shareSingleton].urlStr = snsAccount.iconURL;
                [Singleton shareSingleton].titleStr = snsAccount.userName;
                
            }});
        
        //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
        [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
            NSLog(@"SnsInformation is %@",response.data);
            //        [Singleton shareSingleton].urlStr = response.data[@"profile_image_url"];
            //        [Singleton shareSingleton].titleStr = response.data[@"screen_name"];
        }];
        
    }
}

#pragma mark 意见反馈
- (void)sendEmail {
    Class mailClass = NSClassFromString(@"MFMailComposeViewController");
    if (mailClass) {
        if ([mailClass canSendMail]) {
            [self displayMailBox];
        }
        else {
            [self showMailBoxOnDevice];
        }
    }else {
        [self showMailBoxOnDevice];
    }
}

// 打开设备自带的邮箱工具
- (void)showMailBoxOnDevice {
    NSString *mail = @"1030253565@qq.com";
    mail = [mail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mail]];
}

- (void)displayMailBox {
    // 创建邮件视图VC
    MFMailComposeViewController *mailBox = [[MFMailComposeViewController alloc] init];
    // 填写收件人地址
    NSArray *recipient = [NSArray arrayWithObject:@"1030253565@qq.com"];
    [mailBox setToRecipients:recipient];
    // 填写主题
    [mailBox setSubject:@"意见反馈"];
    // 填写邮件内容
    NSString *messageBody = @"<请输入您要反馈的意见, 我们会虚心接受您的意见并及时做出修改!>";
    [mailBox setMessageBody:messageBody isHTML:YES];
    // 添加一个文件
    //    UIImage *image = [UIImage imageNamed:@"hehe.jpg"];
    //    NSData *data = UIImagePNGRepresentation(image);
    //    [mailBox addAttachmentData:data mimeType:@"" fileName:@"随便填.jpg"];
    // 设置代理人
    mailBox.mailComposeDelegate = self;
    
    [self presentViewController:mailBox animated:YES completion:^{
        
    }];
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    NSString *message;
    switch (result) {
        case MFMailComposeResultCancelled:
            message = @"取消发送";
            NSLog(@"%@", message);
            break;
        case MFMailComposeResultSaved:
            message = @"保存草稿";
            NSLog(@"%@", message);
            break;
        case MFMailComposeResultSent:
            message = @"已发送";
            NSLog(@"%@", message);
            break;
        case MFMailComposeResultFailed:
            message = @"发送失败";
            NSLog(@"%@", message);
            break;
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark  ② 视图将要出现
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    NSLog(@"%s", __FUNCTION__);
//    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[Singleton shareSingleton].urlStr]];
//    self.nameLabel.text = [Singleton shareSingleton].titleStr;
//    NSLog(@"%@", [Singleton shareSingleton].titleStr);
//}

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
