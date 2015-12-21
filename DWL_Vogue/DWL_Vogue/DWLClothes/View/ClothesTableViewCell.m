//
//  ClothesTableViewCell.m
//  DWL_Vogue
//
//  Created by diaowenli on 15/11/13.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "ClothesTableViewCell.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"

@implementation ClothesTableViewCell
- (void)dealloc {
    [_clothesHeadLabel release];
    [_clothesImageView release];
    [_clothesIntroLabel release];
    [_clothesTextLabel release];
    
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
    self.clothesImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.clothesImageView];
    self.clothesImageView.image = [UIImage imageNamed:@"placeholderBig.jpg"];
    [_clothesImageView release];
    
    self.clothesHeadLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.clothesHeadLabel];
    [_clothesHeadLabel release];
    self.clothesHeadLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    self.clothesHeadLabel.textColor = [UIColor whiteColor];
    self.clothesHeadLabel.textAlignment = 1;
    
    self.clothesIntroLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.clothesIntroLabel];
    [_clothesIntroLabel release];
    self.clothesIntroLabel.font = [UIFont systemFontOfSize:12];
    self.clothesIntroLabel.textColor = [UIColor whiteColor];
    self.clothesIntroLabel.numberOfLines = 0;
    
    self.clothesTextLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.clothesTextLabel];
    self.clothesTextLabel.backgroundColor = [UIColor colorWithRed:0.275 green:0.305 blue:0.337 alpha:1.000];
    self.clothesTextLabel.layer.borderWidth = 1;
    self.clothesTextLabel.layer.borderColor = [UIColor colorWithRed:0.275 green:0.305 blue:0.337 alpha:1.000].CGColor;
    [_clothesTextLabel release];
    self.clothesTextLabel.font = [UIFont systemFontOfSize:10];
    self.clothesTextLabel.textColor = [UIColor whiteColor];
    self.clothesTextLabel.textAlignment = 1;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.clothesImageView.frame = CGRectMake(0, 0, CELLWIDTH, CELLHEIGHT - 40);
    self.clothesHeadLabel.frame = CGRectMake(52, (CELLHEIGHT - 60) / 5 * 3 , CELLWIDTH - 104, 20);
//    self.clothesIntroLabel.frame = CGRectMake(30, (CELLHEIGHT - 60) / 5 * 3 + 30, CELLWIDTH - 60, 50);
    self.clothesTextLabel.frame = CGRectMake(0, CELLHEIGHT - 40, CELLWIDTH, 40);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, nil];
    
    CGRect rect = [self.clothesIntroLabel.text boundingRectWithSize:CGSizeMake(CELLWIDTH - 100, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.clothesIntroLabel.frame = CGRectMake(52, (CELLHEIGHT - 60) / 5 * 3 + 40, CELLWIDTH - 104, rect.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
