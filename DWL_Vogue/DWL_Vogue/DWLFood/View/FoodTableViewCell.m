//
//  FoodTableViewCell.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/22.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "FoodTableViewCell.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"

@implementation FoodTableViewCell
- (void)dealloc {
    [_foodimageView release];
    [_foodHeadLabel release];
    [_foodTextLabel release];
    
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
    self.foodimageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.foodimageView];
    self.foodimageView.image = [UIImage imageNamed:@"placeholderBig.jpg"];
    [_foodimageView release];
    
    self.foodHeadLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.foodHeadLabel];
    [_foodHeadLabel release];
    self.foodHeadLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    self.foodHeadLabel.textColor = [UIColor whiteColor];
    self.foodHeadLabel.textAlignment = 1;
    
    self.foodTextLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.foodTextLabel];
    self.foodTextLabel.backgroundColor = [UIColor colorWithRed:0.275 green:0.305 blue:0.337 alpha:1.000];
    self.foodTextLabel.layer.borderWidth = 1;
    self.foodTextLabel.layer.borderColor = [UIColor colorWithRed:0.275 green:0.305 blue:0.337 alpha:1.000].CGColor;
    [_foodTextLabel release];
    self.foodTextLabel.font = [UIFont systemFontOfSize:10];
    self.foodTextLabel.textColor = [UIColor whiteColor];
    self.foodTextLabel.textAlignment = 1;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.foodimageView.frame = CGRectMake(0, 0, CELLWIDTH, CELLHEIGHT - 40);
    self.foodHeadLabel.frame = CGRectMake(10, (CELLHEIGHT - 60) / 2, CELLWIDTH - 20, 20);
    self.foodTextLabel.frame = CGRectMake(0, CELLHEIGHT - 40, CELLWIDTH, 40);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
