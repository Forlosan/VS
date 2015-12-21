//
//  SetViewController.m
//  DWL_Vogue
//
//  Created by dllo on 15/11/1.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "SetViewController.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"
#import <MessageUI/MessageUI.h>
#import "UMSocial.h"
#import "Singleton.h"
#import "OursViewController.h"

@interface SetViewController ()<UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>
@property(nonatomic, retain)NSArray *nameArr;
@property(nonatomic, retain)UITableView *setTableView;
@property(nonatomic, retain)UIAlertView *alertView;
@property(nonatomic, retain)UIAlertAction *archiveAction;
@property(nonatomic, retain)UIAlertView *logAlertView;
@property(nonatomic, retain)UIAlertView *successAlert;
@property(nonatomic, retain)UIAlertView *versionAlert;

@end

@implementation SetViewController
- (void)dealloc {
    [_nameArr release];
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
        self.nameArr = @[@"清除缓存", @"意见反馈", @"关于我们", @"版本检测", @"登录"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    TableView
    self.setTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.self.setTableView];
    [_setTableView release];
    self.setTableView.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:238 / 255.0 blue:244 / 255.0 alpha:1];
    self.setTableView.delegate = self;
    self.setTableView.dataSource = self;
    
    
    
//    HeadView
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [self.view addSubview:headView];
    headView.backgroundColor = [UIColor colorWithRed:54 / 255.0 green:53 / 255.0 blue:68 / 255.0 alpha:1];
    [headView release];
//
    UIButton *headButton = [UIButton buttonWithType:UIButtonTypeSystem];
    headButton.frame = CGRectMake(16, 25, 32, 32);
    [headButton setImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [headButton setTintColor:[UIColor whiteColor]];
    [headView addSubview:headButton];
    [headButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 30, 32, 60, 20)];
    [headView addSubview:headLabel];
    headLabel.text = @"设置";
    headLabel.textAlignment = 1;
    headLabel.textColor = [UIColor whiteColor];
    headLabel.font = [UIFont systemFontOfSize:15];
    [headLabel release];
}

- (void)leftButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *reuse = @"reuse";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse] autorelease];
        }
        cell.textLabel.text = self.nameArr[indexPath.row];
//        [cell.textLabel setHighlighted:NO];
        return cell;
    } else {
        static NSString *reuse1 = @"reuse1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1] autorelease];
    }
        cell.textLabel.text = self.nameArr[indexPath.row + 4];
        cell.textLabel.textAlignment = 1;
        cell.textLabel.textColor = [UIColor redColor];
//    [cell.textLabel setHighlighted:NO];
    return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
        } else if (indexPath.row == 3) {
            NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];    //获取项目名称
            
            NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];      //获取项目版本号
            
            
            
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            CFShow(infoDictionary);
            // app名称
            NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
            // app版本
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            // app build版本
            NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
            NSString *app = [@"Vogue Show当前版本 " stringByAppendingString:app_build];
            self.versionAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:app delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            self.versionAlert.alertViewStyle = UIAlertViewStyleDefault;
            
            [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismissAlertView:) userInfo:nil repeats:NO];
            [self.versionAlert show];
        }
    }
    
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

//- (void)dismissAlertView:(NSTimer *)timer {
//    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @" ";
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.setTableView.contentSize = CGSizeMake(0, HEIGHT - 150);
}

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

    // Create header view and add label as a subview
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)] autorelease];
    [sectionView setBackgroundColor:[UIColor colorWithRed:239 / 255.0 green:238 / 255.0 blue:244 / 255.0 alpha:1]];
    [sectionView addSubview:label];
    return sectionView;
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
