//
//  DetectionNetworkStatusTool.m
//  DWL_Vogue
//
//  Created by diaowenli on 15/11/13.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "DetectionNetworkStatusTool.h"
#import <MBProgressHUD.h>

static NSString * const AFAppDotNetAPIBaseURLString = @"www.baidu.com";
@implementation DetectionNetworkStatusTool


+ (instancetype)sharedClient {
    static DetectionNetworkStatusTool *_sharedClient = nil;
    static dispatch_once_t onceToken;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DetectionNetworkStatusTool alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NSLog(@"%ld", (long)status);
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWWAN------");
                    UIAlertView *alerView2 = [[UIAlertView alloc] initWithTitle:@"警告" message:@"本引用耗流量非常大请切换WIFI" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alerView2 show];
                    status = YES;
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWiFi------");
                    UIAlertView *alerView1 = [[UIAlertView alloc] initWithTitle:@"警告" message:@"正在使用WIFI请放心使用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [center postNotificationName:@"wlan" object:@"2" userInfo:nil];
                    [alerView1 show];
                    
//                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
//                    hud.mode = MBProgressHUDModeText;
//                    hud.labelText = @"已连接到wifi";
//                    hud.margin = 10.f;
//                    hud.yOffset = 150.f;
//                    hud.removeFromSuperViewOnHide = YES;
//                    [hud hide:YES afterDelay:1.5];

                    
                    status = YES;
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"-------AFNetworkReachabilityStatusNotReachable------");
                    
                    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络异常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alerView show];
                    [center postNotificationName:@"wlan" object:@"1" userInfo:nil];
                    status = NO;
                    break;
                    
                default:
                    break;
            }
        }];
        [_sharedClient.reachabilityManager startMonitoring];
    });
    
    return _sharedClient;
}

@end
