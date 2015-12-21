//
//  MoreTableViewCell.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/23.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "MoreTableViewCell.h"
#import "MoreTableViewController.h"
#import "WidthAndHeight.h"

@implementation MoreTableViewCell
- (void)dealloc {
    [_moreImageView release];
    [_moreLabel release];
    [_blackView release];
    [_colorArr release];
    
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    self.moreImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.moreImageView];
    [_moreImageView release];
    
    self.moreLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.moreLabel];
    self.moreLabel.text = @"点击查看更多美食";
    self.moreLabel.textColor = [UIColor whiteColor];
    self.moreLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    self.moreLabel.textAlignment = 1;
    [_moreLabel release];
    
    self.blackView = [[UIView alloc] init];
    self.blackView.frame = CGRectMake(0, 3, CELLWIDTH,CELLHEIGHT - 6);

    [self.moreImageView addSubview:self.blackView];
//    [self performSelector:@selector(change) withObject:self afterDelay:0.1];

//    self.blackView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.3];
    [_blackView release];
}

- (void)change {
//    [self.blackView.layer addSublayer:[self shadowAsInverse]];
   
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.moreImageView.frame = CGRectMake(0, 3, CELLWIDTH ,CELLHEIGHT - 6);
    self.moreLabel.frame = CGRectMake(0, CELLHEIGHT / 3, CELLWIDTH, 30);

}

- (CAGradientLayer *)shadowAsInverse
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    newShadow.frame = CGRectMake(0, 0, CELLWIDTH, CELLHEIGHT);
    //添加渐变的颜色组合（颜色透明度的改变）
    self.colorArr = [NSMutableArray array];
    for (NSInteger i = 0; i < CELLHEIGHT; i++) {
        id color = (id)[[[UIColor blackColor] colorWithAlphaComponent:0.9 / CELLHEIGHT * i] CGColor];
        [self.colorArr addObject:color];
    }
    for (NSInteger i = CELLHEIGHT - 1; i >= 0; i--) {
        id color = (id)[[[UIColor blackColor] colorWithAlphaComponent:0.9 / CELLHEIGHT * i] CGColor];
        [self.colorArr addObject:color];
    }
    
    newShadow.colors = self.colorArr;
    return newShadow;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
