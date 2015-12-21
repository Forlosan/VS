//
//  MoreCellInformation.h
//  DWL_Vogue
//
//  Created by dllo on 15/10/26.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "BaseModel.h"

@interface MoreCellInformation : BaseModel
@property(nonatomic, retain)NSString *titleName;
@property(nonatomic, retain)NSString *source;
@property(nonatomic, retain)NSString *image_url;
@property(nonatomic, retain)NSString *urlid;
@property(nonatomic, retain)NSMutableArray *image_urls;

@end


