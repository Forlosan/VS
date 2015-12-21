//
//  ClothesCellInformation.m
//  DWL_Vogue
//
//  Created by diaowenli on 15/11/13.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "ClothesCellInformation.h"

@implementation ClothesCellInformation
- (void)dealloc {
    [_gid release];
    [_desc release];
    [_clothesImage release];
    [_clothesTitle release];
    [_publishtime release];
    
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"title"]) {
        self.clothesTitle = value;
    }
    if ([key isEqualToString:@"image"]) {
        self.clothesImage = value;
    }
}
@end
