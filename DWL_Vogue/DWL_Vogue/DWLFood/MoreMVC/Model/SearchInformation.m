//
//  SearchInformation.m
//  DWL_Vogue
//
//  Created by diaowenli on 15/11/4.
//  Copyright © 2015年 Forlosan. All rights reserved.
//

#import "SearchInformation.h"

@implementation SearchInformation
- (void)dealloc {
    [_content release];
    [_searchName release];
    [_searchUrl release];
    [_imageid release];
    
    [super dealloc];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"name"]) {
        self.searchName = value;
    } else if ([key isEqualToString:@"url"]) {
        self.searchUrl = value;
    } else if ([key isEqualToString:@"content"]) {
        self.content = value;
    } else if ([key isEqualToString:@"imageid"]) {
        self.imageid = value;
    }
}
@end
