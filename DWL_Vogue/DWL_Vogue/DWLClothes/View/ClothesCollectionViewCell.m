//
//  ClothesCollectionViewCell.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/26.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "ClothesCollectionViewCell.h"
#import "WidthAndHeight.h"

@implementation ClothesCollectionViewCell
- (void)dealloc {
    [_clothesImageView release];
    [_clothesLabel release];
    
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clothesImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CELLWIDTH, CELLHEIGHT - 20)];
        [self.contentView addSubview:self.clothesImageView];
        [_clothesImageView release];
        self.clothesImageView.backgroundColor = [UIColor lightGrayColor];
        
        self.clothesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CELLHEIGHT - 20, CELLWIDTH, 20)];
        [self.contentView addSubview:self.clothesLabel];
        [_clothesLabel release];
        self.clothesLabel.textColor = [UIColor whiteColor];
        self.clothesLabel.textAlignment = 1;
        self.clothesLabel.font = [UIFont systemFontOfSize:10];
        self.clothesLabel.backgroundColor = [UIColor colorWithRed:0.306 green:0.293 blue:0.319 alpha:1.000];
    }
    return self;
}
@end
