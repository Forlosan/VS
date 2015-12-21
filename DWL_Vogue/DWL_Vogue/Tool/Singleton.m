//
//  Singleton.m
//  UI19_单例
//
//  Created by dllo on 15/10/13.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton
- (void)dealloc {
    [_titleStr release];
    [_urlStr release];
    
    [super dealloc];
}

+ (instancetype)shareSingleton {
    static Singleton *single;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[Singleton alloc] init];
    });
    return single;

}


@end
