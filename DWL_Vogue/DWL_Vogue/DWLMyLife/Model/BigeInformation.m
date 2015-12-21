//
//  BigeInformation.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/30.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "BigeInformation.h"

@implementation BigeInformation
- (void)dealloc {
    [_titleName release];
    [_content release];
    [_pic release];
    [_article release];
    
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"title"]) {
        self.titleName = value;
    }
}

@end
