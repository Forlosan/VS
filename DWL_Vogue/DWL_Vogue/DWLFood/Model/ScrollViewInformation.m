//
//  ScrollViewInformation.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/22.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "ScrollViewInformation.h"

@implementation ScrollViewInformation
- (void)dealloc {
    [_imageid release];
    [_uri release];
    [_numId release];
    
    [super dealloc];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"imageid"]) {
        self.imageid = [[@"http://pic.ecook.cn/web/" stringByAppendingString:value] stringByAppendingString:@".jpg!m3"];
    } else if ([key isEqualToString:@"id"]) {
        self.numId = value;
    }
    else if ([key isEqualToString:@"uri"]){
       self.uri = value;
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.imageid forKey:@"imageid"];
    [aCoder encodeObject:self.uri forKey:@"uri"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.imageid = [aDecoder decodeObjectForKey:@"imageid"];
        self.uri = [aDecoder decodeObjectForKey:@"uri"];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)imageid uri:(NSString *)uri {
    self = [super init];
    if (self) {
        self.imageid = imageid;
        self.uri = uri;
    }
    return self;
}

@end
