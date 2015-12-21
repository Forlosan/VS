//
//  FoodCellInformation.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/23.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "FoodCellInformation.h"

@implementation FoodCellInformation
- (void)dealloc {
    [_taid release];
    [_topic_name release];
    [_topic_url release];
    [_cover_img_new release];
    [_addtime release];
    
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.topic_name forKey:@"topic_name"];
    [aCoder encodeObject:self.topic_url forKey:@"topic_url"];
    [aCoder encodeObject:self.cover_img_new forKey:@"cover_img_new"];
    [aCoder encodeObject:self.addtime forKey:@"addtime"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.topic_name = [aDecoder decodeObjectForKey:@"topic_name"];
        self.topic_url = [aDecoder decodeObjectForKey:@"topic_url"];
        self.cover_img_new = [aDecoder decodeObjectForKey:@"cover_img_new"];
        self.addtime = [aDecoder decodeObjectForKey:@"addtime"];
    }
    return self;
}

- (instancetype)initWithTopic_name:(NSString *)topic_name topic_url:(NSString *)topic_url cover_img_new:(NSString *)cover_img_new addtime:(NSString *)addtime {
    self = [super init];
    if (self) {
        self.topic_name = topic_name;
        self.topic_url = topic_url;
        self.cover_img_new = cover_img_new;
        self.addtime = addtime;
    }
    return self;
}

@end
