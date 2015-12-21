//
//  Text2TableViewCell.h
//  DWL_Vogue
//
//  Created by dllo on 15/10/28.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Text2TableViewCell : UITableViewCell
@property(nonatomic, retain)UIImageView *playImageView;
@property(nonatomic, retain)UILabel *playTextLabel;

-(void)setImageHeight:(CGFloat )height;

@end
