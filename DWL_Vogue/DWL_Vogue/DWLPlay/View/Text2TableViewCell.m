//
//  Text2TableViewCell.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/28.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "Text2TableViewCell.h"
#import "WidthAndHeight.h"
#import "VogueHeader.h"

@implementation Text2TableViewCell
- (void)dealloc {
    [_playTextLabel release];
    [_playImageView release];
    
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
    self.playImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.playImageView];
    [_playImageView release];
    
    self.playTextLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.playTextLabel];
    [_playTextLabel release];
    
    self.playTextLabel.textColor = [UIColor colorWithWhite:0.123 alpha:1.000];
    
    self.playTextLabel.numberOfLines = 0;
    self.playTextLabel.font = [UIFont systemFontOfSize:16];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    CGFloat imageViewHeight = (self.contentView.frame.size.width - 20) * self.playImageView.image.size.height / self.playImageView.image.size.width;
//    self.playImageView.frame = CGRectMake(10, 10, CELLWIDTH - 20, imageViewHeight);
    self.playImageView.frame = CGRectMake(10, 10, CELLWIDTH - 20, (CELLWIDTH - 20) / 4 * 3);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16], NSFontAttributeName, nil];
    
    CGRect rect = [self.playTextLabel.text boundingRectWithSize:CGSizeMake(CELLWIDTH - 30, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        self.playTextLabel.frame = CGRectMake(15, (CELLWIDTH - 20) / 4 * 3 + 20, CELLWIDTH - 30, rect.size.height);
//    self.playTextLabel.frame = CGRectMake(15, imageViewHeight + 20, CELLWIDTH - 30, rect.size.height);
   
}

//-(void)setImageHeight:(CGFloat )height{
//
//    
//    self.imageView.frame
//    
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
