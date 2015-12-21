//
//  PersonViewController.h
//  DWL_Vogue
//
//  Created by dllo on 15/10/22.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface PersonViewController : UIViewController
{
    //  成员变量
    sqlite3 *dbPoint;
}
@end
