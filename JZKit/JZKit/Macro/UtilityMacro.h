//
//  UtilityMacro.h
//  QMS
//
//  Created by AngusLiu on 12-3-8.
//  Copyright 2012年 NMH. All rights reserved.
//

#import <Foundation/Foundation.h>


#define STRETCHABLE_IMAGE(imageName, w, h) [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:w topCapHeight:h]

#define RESIZE_CELL_IMAGE(imageName) [[UIImage imageNamed:imageName] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)]

#define EASYIMAGE(imageName) [UIImage imageNamed:imageName]


#define BUTTON_TITLE_FONT [UIFont boldSystemFontOfSize:16]

//RGB转UIColor函数
#define	UIColorFromRGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0  \
                                                 blue:b/255.0 alpha:1.0]



/**
 *  使用方式是UIColorHexFromRGB(0x067AB5);
 */
#define UIColorHexFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorHexFromRGBAlpha(rgbValue,alp) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alp]




//全局变量
#define g_pNotificationCenter [NSNotificationCenter defaultCenter]
#define g_pFileMgr [NSFileManager defaultManager]
#define g_pUserDefaults  [NSUserDefaults standardUserDefaults]
#define g_pAccelerometer [UIAccelerometer sharedAccelerometer]



#define BARBUTTON(TITLE, SELECTOR) [[[UIBarButtonItem alloc] initWithWithTitle:TITLE \
                                  style:UIBarbuttonItemStylePlain    \
                                  target:self      \
                                  action:SELECTOE] autorelease]      \

//字符串
#define KXString(a)         NSLocalizedString(a, nil)


//打印日志
#ifdef DEBUG
#define KXLOG(format, ...)  NSLog(format, ##__VA_ARGS__)
#else
#define KXLOG(format, ...)
#endif


//错误检测，错误检测宏会有写入日志文件功能
#define CHECK(a)            do { \
                                if (!(a)) { \
                                   KXLogError();  \
                                }  \
                            } while(0)

#define CHECKV(a)           do {  \
                                if (!(a)) { \
                                   KXLogError();  \
                                   return;    \
                                }  \
                            } while(0)

#define CHECKU(a)           do {  \
                                if (!(a)) { \
                                    KXLogError();  \
                                    return 0;    \
                                }   \
                            } while(0)

#define CHECKN(a)           do {  \
                                if (!(a)) { \
                                    KXLogError();  \
                                    return -1;    \
                                }   \
                            } while(0)

#define CHECKP(a)           do {  \
                                if (!(a)) { \
                                    KXLogError();  \
                                    return nil;    \
                                }   \
                            } while(0)

#define CHECKB(a)           do {  \
                                if (!(a)) { \
                                    KXLogError();  \
                                    return NO;    \
                                }   \
                            } while(0)

#define RELEASE_SAFELY(a)   do {  \
                               [a release];  \
                               a = nil;   \
                            } while(0)

#define RETAIN_SAFELY(_left, _right)  do {  \
                                         id  _tmpLeft = _right;  \
                                         if (_left != _tmpLeft) {  \
                                            [_left release];   \
                                             _left = [_tmpLeft retain];  \
                                         }   \
                                      } while(0)

#define COPY_SAFELY(_left, _right)  do {  \
                                        id  _tmpLeft = _right;  \
                                        if (_left != _tmpLeft) {  \
                                        [_left release];   \
                                        _left = [_tmpLeft copy];  \
                                        }   \
} while(0)
                                             



#define CLEAR_TABLEVIEW_HEADER(tableView)     do {   \
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero]; \
        [headerView setBackgroundColor:[UIColor clearColor]];  \
        [tableView setTableHeaderView:headerView];  \
        [headerView release];  \
    }while(0)

#define CLEAR_TABLEVIEW_FOOTER(tableView)      do {     \
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];  \
        [footerView setBackgroundColor:[UIColor clearColor]];      \
        [tableView setTableFooterView:footerView];     \
        [footerView release];      \
    }while(0)



#define     SHOW_VIEWCONTROLLER_DELEGATE(viewCtrlClass)        do {   \
            viewCtrlClass *viewCtrl = [[viewCtrlClass alloc] init];  \
            [viewCtrl setDelegate:self];                   \
            [self.navigationController pushViewController:viewCtrl animated:YES];\
            [viewCtrl release];  \
            }while(0)  

#define     SHOW_VIEWCONTROLLER(viewCtrlClass)        do {   \
            viewCtrlClass *viewCtrl = [[viewCtrlClass alloc] init];  \
            [self.navigationController pushViewController:viewCtrl animated:YES];\
            [viewCtrl release];  \
            }while (0)  


//iphone当前语言
#define ISCHINESE [[[g_pUserDefaults objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans"]

// 选择
#define CN_VS_EN(a,b) (ISCHINESE?(a):(b))

#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)






//yohunl add 20140526
#ifndef __has_feature
#define __has_feature(x) 0
#endif
#if __has_feature(objc_arc)
#define IF_ARC(with, without) with
#else
#define IF_ARC(with, without) without
#endif

#define $new(Klass) IF_ARC([[Klass alloc] init], [[[Klass alloc] init] autorelease])
#define $eql(a,b)   [(a) isEqual:(b)]

#define $arr(...)   [NSArray arrayWithObjects:__VA_ARGS__, nil]
#define $marr(...)  [NSMutableArray arrayWithObjects:__VA_ARGS__, nil]
#define $marrnew    [NSMutableArray array]
#define $set(...)   [NSSet setWithObjects:__VA_ARGS__, nil]
#define $mset(...)  [NSMutableSet setWithObjects:__VA_ARGS__, nil]
#define $msetnew    [NSMutableSet set]
#define $dict(...)  [NSDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]
#define $mdict(...) [NSMutableDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]
#define $mdictnew   [NSMutableDictionary dictionary]
#define $str(...)   [NSString stringWithFormat:__VA_ARGS__]
#define $mstr(...)  [NSMutableString stringWithFormat:__VA_ARGS__]
#define $mstrnew    [NSMutableString string]

#define trim(str)   (str==nil?@"":str)

#define $bool(val)      [NSNumber numberWithBool:(val)]
#define $char(val)      [NSNumber numberWithChar:(val)]
#define $double(val)    [NSNumber numberWithDouble:(val)]
#define $float(val)     [NSNumber numberWithFloat:(val)]
#define $int(val)       [NSNumber numberWithInt:(val)]
#define $integer(val)   [NSNumber numberWithInteger:(val)]
#define $long(val)      [NSNumber numberWithLong:(val)]
#define $longlong(val)  [NSNumber numberWithLongLong:(val)]
#define $short(val)     [NSNumber numberWithShort:(val)]
#define $uchar(val)     [NSNumber numberWithUnsignedChar:(val)]
#define $uint(val)      [NSNumber numberWithUnsignedInt:(val)]
#define $uinteger(val)  [NSNumber numberWithUnsignedInteger:(val)]
#define $ulong(val)     [NSNumber numberWithUnsignedLong:(val)]
#define $ulonglong(val) [NSNumber numberWithUnsignedLongLong:(val)]
#define $ushort(val)    [NSNumber numberWithUnsignedShort:(val)]

#define $nonretained(val) [NSValue valueWithNonretainedObject:(val)]
#define $pointer(val)     [NSValue valueWithPointer:(val)]
#define $point(val)       [NSValue valueWithPoint:(val)]
#define $range(val)       [NSValue valueWithRange:(val)]
#define $rect(val)        [NSValue valueWithRect:(val)]
#define $size(val)        [NSValue valueWithSize:(val)]

#define $safe(obj)        ((NSNull *)(obj) == [NSNull null] ? nil : (obj))

//IM合法验证
#define IMILLIGAL @"(.*)([0-9]|[一二三四五六七八九零壹贰叁肆伍陆柒捌玖①②③④⑤⑥⑦⑧⑨⑩㈠㈡㈢㈣㈤㈥㈦㈧㈨㈩ⅠⅡⅢⅣⅤⅥⅦⅧⅨ⑴⑵⑶⑷⑸⑹⑺⑻⑼])(.*)"
#define IS_IM_ILLIGAL(string)  [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", IMILLIGAL] evaluateWithObject:string]


#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
