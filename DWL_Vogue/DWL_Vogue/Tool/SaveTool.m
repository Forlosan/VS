//
//  SaveTool.m
//  UI19_豆瓣学习
//
//  Created by dllo on 15/10/13.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import "SaveTool.h"

@implementation SaveTool

+ (void)isHaveFolder {
    
    //  1. 找沙盒路径
    NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //  2. 拼接电影文件夹名
    NSString *playFile = [sandBoxPath stringByAppendingPathComponent:@"MyCollect"];
    //  创建一个文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    //  通过管理者调用方法, 根据路径判断文件夹是否存在
    if (![manager fileExistsAtPath:playFile ]) {
        [manager createDirectoryAtPath:playFile  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSLog(@"%@", playFile );
}

//  判断是否收藏过
+ (BOOL)isHavePlayInPlist:(PlayCellInformation *)play {
    NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"MyCollect/play.plist"];
    
    //  反归档
    NSArray *playArr = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];
    //  遍历
    for (PlayCellInformation *temp in playArr) {
        if ([temp.numId.stringValue isEqualToString:play.numId.stringValue]) {
            return NO;
        }
    }
    return YES;
}

//  增加收藏
+ (void)savePlayToPlist:(PlayCellInformation *)play {
    NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"MyCollect/play.plist"];
    //  直接归档会覆盖掉之前的数据, 所以先进行反归档, 然后添加进去之后再进行归档操作
    NSMutableArray *playArr = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];
    NSLog(@"qwe%@", docPath);
    if (playArr == nil) {
        //  如果为空, 先进行初始化
        playArr = [NSMutableArray array];
    }
    [playArr addObject:play];
    //  归档
    [NSKeyedArchiver archiveRootObject:playArr toFile:docPath];
}

//  取消收藏的方法
+ (void)cancelPlayInPlist:(PlayCellInformation *)play {
    //  写路径
    NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"MyCollect/play.plist"];
    //  反归档
    NSMutableArray *playArr = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];
    //  遍历之后移除相应的对象
    for (PlayCellInformation *temp in playArr) {
        if ([temp.numId.stringValue isEqualToString:play.numId.stringValue]) {
            //  移除
            [playArr removeObject:temp];
            break;
        }
    }
    //  归档
    [NSKeyedArchiver archiveRootObject:playArr toFile:docPath];
}

//+ (BOOL)isHaveInFile:(id)object type:(SaveToolType)type {
//    NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    switch (type) {
//        case SaveToolMovie: {
//            //  拼接电影的文件夹路径
//            NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"Movie/movie.plist"];
//            NSArray *movieArr = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];
//            Movie *mov = object;
//            for (Movie *temp in movieArr) {
//                if ([temp.movieId isEqualToString:mov.movieId]) {
//                    return NO;
//                }
//            }
//        }
//            break;
//            
//        default:
//            return YES;
//            break;
//    }
//    return YES;
//}

@end
