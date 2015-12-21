//
//  Singleton.h
//  UI19_单例
//
//  Created by dllo on 15/10/13.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject
@property(nonatomic, retain)NSString *urlStr;
@property(nonatomic, retain)NSString *titleStr;
+ (instancetype)shareSingleton;

@end
