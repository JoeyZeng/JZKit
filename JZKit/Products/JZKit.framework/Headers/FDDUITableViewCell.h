//
//  FDDUITableViewCell.h
//  SecondHouseBroker
//
//  Created by Yohunl on 14-6-11.
//  Copyright (c) 2014年 Lin Dongpeng. All rights reserved.
//
/**
 *  带有分隔线的公共Cell类
 *
 */
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SecondHouseCellType) {
    SecondHouseCellTypeFirst,
    SecondHouseCellTypeMiddle,
    SecondHouseCellTypeLast,
    SecondHouseCellTypeSingle,
    SecondHouseCellTypeAny,
    SecondHouseCellTypeHaveTop,
    SecondHouseCellTypeHaveBottom,
    SecondHouseCellTypeNone
};

@protocol FDDUITableViewCellDelegate <NSObject>

@optional
-(BOOL)cellBecomeFirstResponder;
-(BOOL)cellResignFirstResponder;
@end
@interface FDDUITableViewCell : UITableViewCell

/**
 *  分隔线的颜色值,默认为0xd9d9d9
 */
@property (nonatomic,strong) UIColor *lineColor;
/**
 *  分隔线是上,还是下,还是中间的
 */
@property(nonatomic,assign)SecondHouseCellType cellType;

/**
 *  上横线
 */
@property (strong, nonatomic)  UIView *lineviewTop;

/**
 *  下横线,都是用来分隔cell的
 */
@property (strong, nonatomic)  UIView *lineviewBottom;

/**
 *  标识分隔线是不是ios7的风格,ios7的风格,是中间的分隔线都会在最前面留一些空
 */
@property(nonatomic,assign)BOOL ios7SeperatorStyle;


/**
 *  分割线了偏移量,默认是15,只是在IOS7模式下才起作用,也就是ios7SeperatorStyle为YES
 */
@property(nonatomic,assign) int separateLineOffset;

-(void)setCellType:(SecondHouseCellType)type;

-(void)setSeperatorLineForIOS7 :(NSIndexPath *)indexPath numberOfRowsInSection: (NSInteger)numberOfRowsInSection;
@end
