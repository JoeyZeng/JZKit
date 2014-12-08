//
//  FDDTextFeildCell.h
//  SecondHouseBroker
//
//  Created by lingyohunl on 14/10/30.
//  Copyright (c) 2014年 房多多. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDDUITableViewCell.h"
#import "FddKeyBoardToolBar.h"
@interface FDDTextFeildCell : FDDUITableViewCell

@property (nonatomic,weak)id<FddKeyBoardToolBarDelegate> actionDelegate;
/**
 *  标题文本,距离左边的边距,默认为15
 */
@property (nonatomic,assign)CGFloat textOriginX;


/**
 *  标题文本的宽度,默认为80
 */
@property (nonatomic,assign)CGFloat textWidth;

/**
 *  textField起始位置距离textLabel的间距.默认为34
 */
@property (nonatomic,assign)CGFloat fieldSpace;


@property (nonatomic, readonly) UILabel * textLabel;
@property (nonatomic, readonly) UITextField * textField;


@property (nonatomic, strong) FddKeyBoardToolBar *actionBar;
@property (nonatomic,assign) BOOL keyboardBarFlag;

@end
