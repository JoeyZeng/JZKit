//
//  FddKeyBoardToolBar.h
//  SecondHouseBroker
//
//  Created by lingyohunl on 14/11/12.
//  Copyright (c) 2014年 房多多. All rights reserved.
//
/**
 *  在键盘上增加一个控件,提供上一个,下一个,还有完成按钮
 */
#import <UIKit/UIKit.h>
@protocol FddKeyBoardToolBarDelegate;
@interface FddKeyBoardToolBar : UIToolbar
- (id)initWithDelegate:(id)delegate;
@property (strong, readonly, nonatomic) UISegmentedControl *navigationControl;
@property (weak, readwrite, nonatomic) id<FddKeyBoardToolBarDelegate> actionBarDelegate;
-(void)setSegment0Flag:(BOOL)falg;
-(void)setSegment1Flag:(BOOL)falg;
@end

@protocol FddKeyBoardToolBarDelegate <NSObject>

- (void)actionBar:(FddKeyBoardToolBar *)actionBar navigationControlValueChanged:(UISegmentedControl *)navigationControl;
- (void)actionBar:(FddKeyBoardToolBar *)actionBar doneButtonPressed:(UIBarButtonItem *)doneButtonItem;

@end
