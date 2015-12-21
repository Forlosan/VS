//
//  DetectionNetworkStatusTool.h
//  DWL_Vogue
//
//  Created by diaowenli on 15/11/13.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface DetectionNetworkStatusTool : AFHTTPSessionManager

// AFnetworking监测网络变化
+ (instancetype)sharedClient;

@property(nonatomic, assign)BOOL status;

@end
