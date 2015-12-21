//
//  SetPersonTableViewCell.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/27.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "SetPersonTableViewCell.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"

@implementation SetPersonTableViewCell
- (void)dealloc {
    [_setImageView release];
    [_setLabel release];
    [_rightImageView release];
    
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
    self.setImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.setImageView];
    [_setImageView release];
    self.setImageView.backgroundColor = [UIColor lightGrayColor];
    
    self.setLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.setLabel];
    [_setLabel release];
    self.setLabel.font = [UIFont systemFontOfSize:15];
    
    self.rightImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.rightImageView];
    [_rightImageView release];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.setImageView.frame = CGRectMake(10, 10, CELLHEIGHT - 20, CELLHEIGHT - 20);
    self.setLabel.frame = CGRectMake(CELLHEIGHT + 5, CELLHEIGHT / 4, CELLWIDTH / 2, CELLHEIGHT / 2);
    self.rightImageView.frame = CGRectMake(CELLWIDTH - 33, CELLHEIGHT / 2 - 10, 20, 20);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
