//
//  MoreFoodTableViewCell.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/26.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "MoreFoodTableViewCell.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"

@implementation MoreFoodTableViewCell
- (void)dealloc {
    [_moreImageView1 release];
    [_moreImageView2 release];
    [_moreImageView3 release];
    [_moreTextLabel release];
    [_moreTitleLabel release];
    
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
    self.moreImageView1 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.moreImageView1];
    [_moreImageView1 release];
//    self.moreImageView1.contentMode = UIViewContentModeScaleAspectFill;
//    self.contentView.clipsToBounds = YES;

    
    self.moreImageView2 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.moreImageView2];
    [_moreImageView2 release];

    
    self.moreImageView3 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.moreImageView3];
    [_moreImageView3 release];
 
    
    self.moreTitleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.moreTitleLabel];
    [_moreTitleLabel release];
    self.moreTitleLabel.textColor = [UIColor whiteColor];
    self.moreTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
//    self.moreTitleLabel.font = [UIFont systemFontOfSize:16];
    self.moreTextLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.moreTextLabel];
    [_moreTextLabel release];
    self.moreTextLabel.font = [UIFont systemFontOfSize:11];
    self.moreTextLabel.textColor = [UIColor whiteColor];
    self.moreTextLabel.textAlignment = 1;

}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.moreTitleLabel.frame = CGRectMake(10, 10, CELLWIDTH - 20, 20);
    self.moreImageView1.frame = CGRectMake(10, 35, (CELLWIDTH - 40) / 3, (CELLWIDTH - 40) / 4 + 20);
    self.moreImageView2.frame = CGRectMake(20 + (CELLWIDTH - 40) / 3, 35, (CELLWIDTH - 40) / 3, (CELLWIDTH - 40) / 4 + 20);
    self.moreImageView3.frame = CGRectMake(30 + (CELLWIDTH - 40) / 3 * 2, 35, (CELLWIDTH - 40) / 3, (CELLWIDTH - 40) / 4 + 20);
    self.moreTextLabel.frame = CGRectMake(10, 35 + (CELLWIDTH - 40) / 4 + 20, CELLWIDTH - 20, 30);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
