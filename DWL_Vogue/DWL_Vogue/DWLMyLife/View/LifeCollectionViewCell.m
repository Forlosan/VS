//
//  LifeCollectionViewCell.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/29.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "LifeCollectionViewCell.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"

@implementation LifeCollectionViewCell
- (void)dealloc {
    [_lifeLabel release];
    [_lifeImageView release];
    
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.lifeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CELLWIDTH, CELLHEIGHT)];
        [self.contentView addSubview:self.lifeImageView];
        [_lifeImageView release];
        
        self.lifeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CELLHEIGHT / 2 - 10, CELLWIDTH, 20)];
        [self.contentView addSubview:self.lifeLabel];
        [_lifeLabel release];
        self.lifeLabel.textColor = [UIColor whiteColor];
        self.lifeLabel.textAlignment = 1;
        self.lifeLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

@end
