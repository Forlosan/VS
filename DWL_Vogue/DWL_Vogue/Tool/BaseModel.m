//
//  BaseModel.m
//  UI23_基类
//
//  Created by dllo on 15/10/19.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSMutableArray *)baseModelByArr:(NSArray *)arr {
    NSMutableArray *modelArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
//        @autoreleasepool {
            //  通过便利构造器来创建对象
            id model = [[self class] baseModelWithDic:dic];
            [modelArr addObject:model];
//        }
    }
    return modelArr;
}

+ (instancetype)baseModelWithDic:(NSDictionary *)dic {
    //  通过多态创建对象
    id model = [[[[self class] alloc] initWithDic:dic] autorelease];
    return model;
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
