//
//  LifeViewController.h
//  DWL_Vogue
//
//  Created by dllo on 15/10/27.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LifeViewControllerDelegate <NSObject>

- (void)takeName:(NSString *)str;

@end

typedef void (^Block)(NSString *);
//typedef void (^Block1)(NSString *);
@interface LifeViewController : UIViewController
@property(nonatomic, copy)Block block;
//@property(nonatomic, copy)Block1 block1;
@property(nonatomic, assign)id<LifeViewControllerDelegate>delegate;
@property(nonatomic, copy)NSString *str;


@end
