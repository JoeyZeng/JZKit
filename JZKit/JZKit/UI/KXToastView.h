//
//  KXToastView.h
//  QMS
//
//  Created by Angus on 12-5-18.
//  Copyright (c) 2012年 NMH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilityMacro.h"
#import "SingletonMacro.h"

@interface KXToastView : UIView
{
    CGRect      mImageRect;
    
    UIImage     *mImage;
    UILabel     *mTextLabel;
    NSString    *mTitleText;
    
    CGSize      mSize;
    CGFloat     mDurationTime;
    
    NSInteger   mState;
    NSInteger   mDisAppearTime;//提示消失时长，默认2s
}

SINGLETON_INTERFACE(KXToastView);


//显示文字提示
- (void)showTitle:(NSString *)title;
- (void)showTitle:(NSString *)title withTimeLen:(NSInteger) timelen;

//显示文字提示，信息框上方居显示图片
- (void)showTitle:(NSString *)title image:(UIImage *)image;


- (void)dismiss;

@end


#define         g_pToastMgr     [KXToastView sharedInstance]


