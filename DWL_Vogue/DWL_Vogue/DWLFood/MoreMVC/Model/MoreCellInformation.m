//
//  MoreCellInformation.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/26.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "MoreCellInformation.h"

@implementation MoreCellInformation
- (void)dealloc {
    [_titleName release];
    [_source release];
    [_image_url release];
    [_urlid release];
    [_image_urls release];
    
    [super dealloc];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"title"]) {
        self.titleName = value;
    } else if ([key isEqualToString:@"image"]) {
        self.image_url = value;
    } else if ([key isEqualToString:@"source"]) {
        self.source = value;
    } else if ([key isEqualToString:@"url"]) {
        self.urlid = value;
    } else if ([key isEqualToString:@"image_urls"]) {
        self.image_urls = value;
    }
}

@end
