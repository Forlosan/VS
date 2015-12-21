//
//  FoodCache.m
//  DWL_Vogue
//
//  Created by dllo on 15/11/3.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "FoodCache.h"

@implementation FoodCache

+ (void)addCollect:(ScrollViewInformation *)scrollFood {
    NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"MyCaches/foodCaches.plist"];
    NSMutableArray *foodCachesArr = [NSMutableArray array];
    [foodCachesArr addObject:scrollFood];
    [NSKeyedArchiver archiveRootObject:foodCachesArr toFile:docPath];
    
}
@end
