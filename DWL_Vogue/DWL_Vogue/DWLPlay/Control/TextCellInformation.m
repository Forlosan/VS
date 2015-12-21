//
//  TextCellInformation.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/30.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "TextCellInformation.h"

@implementation TextCellInformation
- (void)dealloc {
    [_photo release];
    [_descriptionText release];
    
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.descriptionText = value;
    }
}
@end
