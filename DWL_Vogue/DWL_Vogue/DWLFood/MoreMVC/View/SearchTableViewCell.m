//
//  SearchTableViewCell.m
//  DWL_Vogue
//
//  Created by diaowenli on 15/11/5.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"

@implementation SearchTableViewCell
- (void)dealloc {
    [_searchImageView release];
    [_searchTitleLabel release];
    [_searchContentLabel release];
    
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
    self.searchImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.searchImageView];
    [_searchImageView release];
    
    self.searchTitleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.searchTitleLabel];
    [_searchTitleLabel release];
//    self.searchTitleLabel.textColor = [UIColor whiteColor];
    self.searchTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    
    self.searchContentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.searchContentLabel];
    [_searchContentLabel release];
    self.searchContentLabel.font = [UIFont systemFontOfSize:12];
//    self.seachContentLabel.textColor = [UIColor darkGrayColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.searchImageView.frame = CGRectMake(10, 10, CELLHEIGHT - 20, CELLHEIGHT - 20);
    self.searchTitleLabel.frame = CGRectMake(CELLHEIGHT, 10, CELLWIDTH - CELLHEIGHT - 10, 30);
    self.searchContentLabel.frame = CGRectMake(CELLHEIGHT, 45, CELLWIDTH - CELLHEIGHT - 10, 20);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
