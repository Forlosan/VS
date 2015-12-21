//
//  ScrollViewInformation.h
//  DWL_Vogue
//
//  Created by dllo on 15/10/22.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "BaseModel.h"

@interface ScrollViewInformation : BaseModel<NSCoding>
@property(nonatomic, retain)NSString *imageid;
@property(nonatomic, retain)NSString *uri;
@property(nonatomic, retain)NSString *numId;

- (instancetype)initWithName:(NSString *)imageid uri:(NSString *)uri;

@end
