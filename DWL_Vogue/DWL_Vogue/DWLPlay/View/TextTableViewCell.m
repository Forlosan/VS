//
//  TextTableViewCell.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/28.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "TextTableViewCell.h"
#import "WidthAndHeight.h"

@implementation TextTableViewCell
- (void)dealloc {
    [_playTextLabel release];

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
    
    self.playTextLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.playTextLabel];
    [_playTextLabel release];

    self.playTextLabel.textColor = [UIColor colorWithWhite:0.123 alpha:1.000];
    self.playTextLabel.numberOfLines = 0;
    self.playTextLabel.font = [UIFont systemFontOfSize:16];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16], NSFontAttributeName, nil];
    
    CGRect rect = [self.playTextLabel.text boundingRectWithSize:CGSizeMake(CELLWIDTH - 30, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.playTextLabel.frame = CGRectMake(15, 10, CELLWIDTH - 30, rect.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
