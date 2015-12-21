//
//  FoodCellInformation.h
//  DWL_Vogue
//
//  Created by dllo on 15/10/23.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "BaseModel.h"

@interface FoodCellInformation : BaseModel<NSCoding>
@property(nonatomic, retain)NSString *taid;
@property(nonatomic, retain)NSString *topic_name;
@property(nonatomic, retain)NSString *topic_url;
@property(nonatomic, retain)NSString *cover_img_new;
@property(nonatomic, retain)NSString *addtime;

- (instancetype)initWithTopic_name:(NSString *)topic_name topic_url:(NSString *)topic_url cover_img_new:(NSString *)cover_img_new addtime:(NSString *)addtime;

@end
