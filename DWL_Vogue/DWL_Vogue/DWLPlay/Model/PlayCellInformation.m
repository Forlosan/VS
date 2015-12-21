//
//  PlayCellInformation.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/24.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "PlayCellInformation.h"

@implementation PlayCellInformation
- (void)dealloc {
    [_numId release];
    [_playTitleName release];
    [_start_date release];
    [_front_cover_photo_url release];
    
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
        if ([key isEqualToString:@"id"]) {
            self.numId = value;
        } else if ([key isEqualToString:@"name"]) {
            self.playTitleName = value;
        }
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.numId forKey:@"numId"];
    [aCoder encodeObject:self.playTitleName forKey:@"playTitleName"];
    [aCoder encodeObject:self.start_date forKey:@"start_date"];
    [aCoder encodeObject:self.days forKey:@"days"];
    [aCoder encodeObject:self.front_cover_photo_url forKey:@"front_cover_photo_url"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.numId = [aDecoder decodeObjectForKey:@"numId"];
        self.playTitleName = [aDecoder decodeObjectForKey:@"playTitleName"];
        self.start_date = [aDecoder decodeObjectForKey:@"start_date"];
        self.days = [aDecoder decodeObjectForKey:@"days"];
        self.front_cover_photo_url = [aDecoder decodeObjectForKey:@"front_cover_photo_url"];
    }
    return self;
}

@end
