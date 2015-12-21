//
//  PlayCustomViewController.h
//  DWL_Vogue
//
//  Created by dllo on 15/10/28.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayCellInformation.h"

@interface PlayCustomViewController : UIViewController
@property(nonatomic, retain)NSString *url;
@property(nonatomic, retain)NSString *imageUrl;
@property(nonatomic, retain)NSString *numID;
@property(nonatomic, retain)NSString *titleName;
@property(nonatomic, retain)PlayCellInformation *play;

@end
