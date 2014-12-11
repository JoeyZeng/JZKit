//
//  UtilityMacro.h
//  QMS
//
//  Created by AngusLiu on 12-3-8.
//  Copyright 2012年 NMH. All rights reserved.
//

#import <Foundation/Foundation.h>

//RGB转UIColor函数
#define	UIColorFromRGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0  \
                                                 blue:b/255.0 alpha:1.0]


/**
 *  使用方式是UIColorHexFromRGB(0x067AB5);
 */
#define UIColorHexFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorHexFromRGBAlpha(rgbValue,alp) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alp]

// 系统机型相关
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


// tool
#define $trim(str)   (str==nil?@"":str)
#define $safe(obj)        ((NSNull *)(obj) == [NSNull null] ? nil : (obj))

// frame
#define kScreenWidth             ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight            ([[UIScreen mainScreen] bounds].size.height)

