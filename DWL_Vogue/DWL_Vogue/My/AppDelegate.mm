//
//  AppDelegate.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/21.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "AppDelegate.h"
#import "ClothesViewController.h"
#import "FoodViewController.h"
#import "PlayViewController.h"
#import "MyLifeViewController.h"
#import "PersonViewController.h"
#import "WidthAndHeight.h"
#import "UMSocial.h"
#import "VogueHeader.h"
#import "UMSocialWechatHandler.h"
#import "APService.h"

#define SCREENWIDTH ([UIScreen mainScreen].bounds.size.width/375)
#define SCREENHEIGH ([UIScreen mainScreen].bounds.size.height/667)

@interface AppDelegate ()<UITabBarControllerDelegate, UIScrollViewDelegate>
{
    Reachability *hostReach;
}
@property(nonatomic, retain)UIPageControl *page;


@end

@implementation AppDelegate
- (void)dealloc {
    [_window release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [_window release];
//    
//    // 要使用百度地图，请先启动BaiduMapManager
//    _mapManager = [[BMKMapManager alloc]init];
//    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
//    BOOL ret = [_mapManager start:@"KZbMlGgv4F24vPuuS4venFFZ"  generalDelegate:nil];
//    if (!ret) {
//        NSLog(@"manager start failed!");
//    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    // 1. 注册
    // 系统iOS8.0以上使用
    if ([[[UIDevice currentDevice] systemVersion ] floatValue] >= 8.0f) {
        // 系统iOS8.0 以上使用
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeBadge | UIUserNotificationTypeAlert categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    } else {
        // 系统iOS8.0以下版本
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    }
//    [XGPush startApp:2200165936 appKey:@"I3I1S12HE1IT"];
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        
        [self createView];
        
        
        UIScrollView *myScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT)];
        myScroll.contentSize = CGSizeMake(WINDOWWIDTH * 3, WINDOWHEIGHT);
        for (int i = 0; i < 3; i++) {
            UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(WINDOWWIDTH * i, 0, WINDOWWIDTH, WINDOWHEIGHT)];
            
            myImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%d.jpg", i + 1]];
            [myScroll addSubview:myImage];
            
        }
        myScroll.pagingEnabled = YES;
        myScroll.showsHorizontalScrollIndicator = NO;
        myScroll.bounces = NO;
        [self.window addSubview:myScroll];
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [myScroll addSubview:button];
        button.frame = CGRectMake(WINDOWWIDTH * 2 + WINDOWWIDTH / 2 - 75, WINDOWHEIGHT - 90, 150, 40);
        [button setTitle:@"开启时尚之旅" forState:UIControlStateNormal];
        [button setTintColor:[UIColor whiteColor]];
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        button.layer.cornerRadius = 20;
        [button addTarget:self action:@selector(myAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        myScroll.delegate = self;
        
        self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, WINDOWHEIGHT - 50, WINDOWWIDTH, 30)];
        self.page.numberOfPages = 3;
        self.page.currentPage = 0;
        self.page.backgroundColor = [UIColor clearColor];
        self.page.currentPageIndicatorTintColor = [UIColor whiteColor];
        self.page.pageIndicatorTintColor = [UIColor lightGrayColor];
        [self.window addSubview:self.page];
        
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        [self createView];
    }
    
    //  新浪分享
    [UMSocialData setAppKey:@"563c14a267e58ebf8e0029f0"];
    [DetectionNetworkStatusTool sharedClient];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxcef22fbd7546caaf" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:@"http://blog.sina.com.cn/s/blog_6dcb530b0102w0y3.html"];
    
    
    
    //  设置分享消息类型
//    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
//    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeText;
//    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            NSLog(@"分享成功！");
//        }
//    }];
    
//    //监测网络情况
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
//    //初始化Reachability类，并添加一个监测的网址。
//    hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
////    hostReach = [Reachability reachabilityWithHostName:nil];
//
//    //开始监测
//    [hostReach startNotifier];
    
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
    
    // Required
    [APService setupWithOption:launchOptions];

    
    return YES;
}

//#pragma mark - 监测网络情况，当网络发生改变时会调用
//- (void)reachabilityChanged:(NSNotification *)note {
//    Reachability* curReach = [note object];
//    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
//    NetworkStatus status = [curReach currentReachabilityStatus];
//    if (status == 0) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"当前没有网络连接";
//        hud.margin = 10.f;
//        hud.yOffset = 150.f;
//        hud.removeFromSuperViewOnHide = YES;
//        [hud hide:YES afterDelay:3];
//    } else if (status == 1) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"已连接到wifi";
//        hud.margin = 10.f;
//        hud.yOffset = 150.f;
//        hud.removeFromSuperViewOnHide = YES;
//        [hud hide:YES afterDelay:1.5];
//    } else if (status == 2) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"Vogue Show的BIG很高";
//        hud.detailsLabelText = @"请尽量在Wifi下浏览";
//        hud.detailsLabelFont = [UIFont systemFontOfSize:14];
//        hud.margin = 10.f;
//        hud.yOffset = 150.f;
//        hud.removeFromSuperViewOnHide = YES;
//        [hud hide:YES afterDelay:2];
//    }
//    
//}

- (void)createView {
    
//    tabBar
    MyLifeViewController *lifeVC = [[MyLifeViewController alloc] init];
    UINavigationController *lifeNAVC = [[UINavigationController alloc] initWithRootViewController:lifeVC];
    lifeNAVC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"生活" image:[UIImage imageNamed:@"life.png"] selectedImage:[UIImage imageNamed:@"life.png"]] autorelease];
    ClothesViewController *clothesVC = [[ClothesViewController alloc] init];
    UINavigationController *clothesNAVC = [[UINavigationController alloc] initWithRootViewController:clothesVC];
    clothesNAVC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"衣" image:[UIImage imageNamed:@"clothes@2x.png"] selectedImage:[UIImage imageNamed:@"clothes@2x.png"]] autorelease];
    FoodViewController *foodVC = [[FoodViewController alloc] init];
    UINavigationController *foodNAVC = [[UINavigationController alloc] initWithRootViewController:foodVC];
    foodNAVC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"食" image:[UIImage imageNamed:@"food@2x.png"] selectedImage:[UIImage imageNamed:@"food@2x.png"]] autorelease];
    PlayViewController *playVC = [[PlayViewController alloc] init];
    UINavigationController *playNAVC = [[UINavigationController alloc] initWithRootViewController:playVC];
    playNAVC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"玩" image:[UIImage imageNamed:@"play@2x.png"] selectedImage:[UIImage imageNamed:@"play@2x.png"]] autorelease];
    PersonViewController *personVC = [[PersonViewController alloc] init];
    UINavigationController *personNAVC = [[UINavigationController alloc] initWithRootViewController:personVC];
    personNAVC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"个人" image:[UIImage imageNamed:@"person@2x.png"] selectedImage:[UIImage imageNamed:@"person@2x.png"]] autorelease];
//    set
    UITabBarController *tab = [[UITabBarController alloc] init];
    tab.viewControllers = @[lifeNAVC, clothesNAVC, foodNAVC, playNAVC, personNAVC];
    self.window.rootViewController = tab;
    tab.tabBar.barTintColor = [UIColor colorWithRed:24 / 255.0 green:23 / 255.0 blue:40 / 255.0 alpha:1];
    tab.tabBar.tintColor = [UIColor whiteColor];
    tab.selectedIndex = 4;
    tab.delegate = self;
//    release
    [lifeVC release];
    [lifeNAVC release];
    [clothesVC release];
    [clothesNAVC release];
    [foodVC release];
    [foodNAVC release];
    [playVC release];
    [playNAVC release];
    [personVC release];
    [personNAVC release];
    [tab release];
    
//    创建缓存文件夹
    //  文件管理
    //  1. 找到沙盒路径
    NSArray *sandBox = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *sandBoxPath = sandBox[0];
    //    NSLog(@"%@", sandBoxPath);
    //    NSLog(@"%@", sandBox);
    
    //  创建一个文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    //  要拼接一个文件夹的路径
    //  文件夹的名字没有拓展名
    NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"MyCaches"];
    
    //  根据路径创建一个文件夹
    [manager createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:nil];
    
}

//  微信
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

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

- (void)myAction
{
    [self createView];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    
    self.page.currentPage = scrollView.contentOffset.x / scrollView.window.frame.size.width;
}

// 1. 注册失败返回error
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    NSLog(@"error=============%@", error);
//}
//
//// 5. 发送通知成功返回通知内容
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    NSLog(@"userInfo===========%@", userInfo);
//}
//
//// 2.注册成功APNS返回Token
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    NSLog(@"deviceToken========%@", deviceToken.description);
//    
//    // 3. 将获得的Token发送给自己的服务器
////    [XGPush registerDevice:deviceToken];
//    
//}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [APService registerDeviceToken:deviceToken];
    NSLog(@"deviceToken ======= %@", deviceToken);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
    NSLog(@"userInfo ======= %@", userInfo);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // 将角标清零
    [application setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
