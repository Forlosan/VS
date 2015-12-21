//
//  PlayCellInformation.h
//  DWL_Vogue
//
//  Created by dllo on 15/10/24.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "BaseModel.h"

@interface PlayCellInformation : BaseModel<NSCoding>
@property(nonatomic, copy)NSNumber *numId;
@property(nonatomic, copy)NSString *playTitleName;
@property(nonatomic, copy)NSString *start_date;
@property(nonatomic, copy)NSNumber *days;
@property(nonatomic, copy)NSString *front_cover_photo_url;
@end
