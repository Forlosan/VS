//
//  SaveTool.h
//  UI19_豆瓣学习
//
//  Created by dllo on 15/10/13.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayCellInformation.h"

typedef NS_ENUM(NSUInteger, SaveToolType) {
    SaveToolMovie,
    SaveToolActivity,
    SaveToolCinema,
};
@interface SaveTool : NSObject

+ (void)isHaveFolder;

+ (BOOL)isHavePlayInPlist:(PlayCellInformation *)play;

+ (void)savePlayToPlist:(PlayCellInformation *)play;

+ (void)cancelPlayInPlist:(PlayCellInformation *)play;

//+ (BOOL)isHaveInFile:(id)object type:(SaveToolType)type;

@end
