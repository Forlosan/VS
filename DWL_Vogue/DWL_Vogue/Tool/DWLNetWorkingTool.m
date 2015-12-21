//
//  DWLNetWorkingTool.m
//  DWL_Vogue
//
//  Created by diaowenli on 15/12/5.
//  Copyright © 2015年 Forlosan. All rights reserved.
//

#import "DWLNetWorkingTool.h"
#import "VogueHeader.h"

@implementation DWLNetWorkingTool

+ (void)getBodyNetWorking:(NSString *)strURL body:(NSString *)body success:(SuccessBlock)success failure:(FailureBlock)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, id parameters, NSError **error) {
        return parameters;
    }];
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",  nil]];
    [manager GET:strURL parameters:body success:^(NSURLSessionDataTask *task, id responseObject) {
        [[[self class] alloc] saveDataToPlist:responseObject url:strURL];
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        success([[[self class] alloc] displayContentWithUrl:strURL]);
        failure(error);
    }];
}

+ (void)postBodyNetWorking:(NSString *)strURL body:(NSString *)body success:(SuccessBlock)success failure:(FailureBlock)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, id parameters, NSError **error) {
        return parameters;
    }];
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",  nil]];
    [manager POST:strURL parameters:body success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([body isEqualToString:@""]) {
            [[[self class] alloc] saveDataToPlist:responseObject url:strURL];
        } else {
            [[[self class] alloc] saveDataToPlist:responseObject url:body];
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([body isEqualToString:@""]) {
            success([[[self class] alloc] displayContentWithUrl:strURL]);
        } else {
            success([[[self class] alloc] displayContentWithUrl:body]);
        }
        failure(error);
    }];
}

//  归档
- (void)saveDataToPlist:(id)data url:(NSString *)url {
    //    创建缓存文件夹
    //  文件管理
    //  1. 找到沙盒路径
    NSArray *sandBox = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *sandBoxPath = sandBox[0];
    //  创建一个文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    //  要拼接一个文件夹的路径
    //  文件夹的名字没有拓展名
    NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"MyCaches"];
    
    //  根据路径创建一个文件夹
    if (![manager fileExistsAtPath:sandBoxPath]) {
        [manager createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *sandBoxMyCachesPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
    //  2. 给文件拼接路径
    url = [url substringFromIndex:0];
    NSString *URL = [url stringByReplacingOccurrencesOfString:@"/" withString:@"V"];
    NSString *plist = [URL stringByAppendingString:@"VogueShow.plist"];
    NSString *dataPath = [sandBoxMyCachesPath stringByAppendingPathComponent:plist];
    [NSKeyedArchiver archiveRootObject:data toFile:dataPath];
}

//  反归档
- (id)displayContentWithUrl:(NSString *)url {
    //  1. 找路径
    NSString *sandBoxMyCachesPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
    //  2. 给文件拼接路径
    NSString *URL = [url stringByReplacingOccurrencesOfString:@"/" withString:@"V"];
    NSString *plist = [URL stringByAppendingString:@"VogueShow.plist"];
    NSString *dataPath = [sandBoxMyCachesPath stringByAppendingPathComponent:plist];
    //  3. 反归档
    id data = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    return data;
}

@end
