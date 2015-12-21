//
//  DWLNetWorkingTool.h
//  DWL_Vogue
//
//  Created by diaowenli on 15/12/5.
//  Copyright © 2015年 Forlosan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>

typedef void(^SuccessBlock)(id result);
typedef void(^FailureBlock)(id error);

@interface DWLNetWorkingTool : NSObject<MBProgressHUDDelegate>
+ (void)getBodyNetWorking:(NSString *)strURL body:(NSString *)body success:(SuccessBlock)block failure:(FailureBlock)errorBlock;
+ (void)postBodyNetWorking:(NSString *)strURL body:(NSString *)body success:(SuccessBlock)block failure:(FailureBlock)errorBlock;

@end
