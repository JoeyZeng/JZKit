//
//  KXToastView.m
//  QMS
//
//  Created by Angus on 12-5-18.
//  Copyright (c) 2012年 NMH. All rights reserved.
//

#import "KXToastView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+SizeWithFont.h"
//#import "DataDef.h"


const NSInteger kDurationTime = 2;
const NSInteger kTitleHeight = 40;
const NSInteger kViewMargin = 15;
const NSInteger kTextFontSize = 16;
const NSInteger kMarginOffsetY = 10;


typedef enum __TOAST_STATE
{
    kToastStateDidDisappear,
    kToastStateWillAppear,
    kToastStateDidAppear,
    kToastStateWillDisappear

}TOAST_STATE;



@interface KXToastView(PrivateMethod)

- (void)toastWillAppear;
- (void)toastDidAppear;
- (void)toastWillDisappear;
- (void)toastDidDisappear;

- (void)dismissWithDelay:(NSInteger)delaySecond;
- (void)layoutTotast;

@end


@implementation KXToastView


SINGLETON_IMPLE(KXToastView)


- (id)init
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
        
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:8];
        
        mTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [mTextLabel setBackgroundColor:[UIColor clearColor]];
        [mTextLabel setTextAlignment:NSTextAlignmentCenter];
        [mTextLabel setFont:[UIFont systemFontOfSize:kTextFontSize]];
        [mTextLabel setNumberOfLines:0];
        [mTextLabel setTextColor:[UIColor whiteColor]];
        
        [self addSubview:mTextLabel];
    }
    
    return self;
}

- (void)showTitle:(NSString *)title
{
    mTitleText = title;
    [self show];

    [self setNeedsDisplay];
}

- (void)showTitle:(NSString *)title withTimeLen:(NSInteger)timelen
{
    [self showTitle:title];
    mDisAppearTime = timelen;
}


- (void)showTitle:(NSString *)title image:(UIImage *)image
{
    mTitleText = title;
    mImage = image;
    
    [self show];

    [self setNeedsDisplay];    
}


- (void)show
{
    NSArray     *windws = [[UIApplication sharedApplication] windows];
    UIWindow    *topWindow = nil;
    
    
    mDisAppearTime = kDurationTime;
    [self layoutTotast];
    
    if ([windws count] > 0)
    {
        if (mState != kToastStateWillAppear)
        {
            topWindow = [windws objectAtIndex:0];
            
            [self setAlpha:0];
            
            CGSize  winSize = [topWindow bounds].size;
            
            [self setFrame:CGRectMake((winSize.width - mSize.width) / 2, 
                                      (winSize.height - mSize.height) / 2 - kMarginOffsetY,
                                      mSize.width, 
                                      mSize.height)];
             [topWindow addSubview:self];
             
             [UIView beginAnimations:nil context:NULL];
             [UIView setAnimationDelegate:self];
             [UIView setAnimationWillStartSelector:@selector(toastWillAppear)];
             [UIView setAnimationDidStopSelector:@selector(toastDidAppear)];
             [UIView setAnimationDuration:0.3];
             
             [self setAlpha:1];
             
             [UIView commitAnimations];
        }
    }
}

- (void)dismiss
{
    if(mState != kToastStateDidDisappear)
    {
        [self toastDidDisappear];
    }
}

- (void)hide
{
    [self dismissWithDelay:0];
}


- (void)layoutSubviews
{
    [self layoutTotast];
}


- (void)dismissWithDelay:(NSInteger)delaySecond
{
    if ([self subviews])
    {
        if (mState != kToastStateWillDisappear)
        {
            [self setAlpha:1];
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationWillStartSelector:@selector(toastWillDisappear)];
            [UIView setAnimationDidStopSelector:@selector(toastDidDisappear)];
            [UIView setAnimationDelay:delaySecond];
            [UIView setAnimationDuration:0.5];
            
            [self setAlpha:0];
            
            [UIView commitAnimations];
        }
    }
    else 
    {
        [self toastDidDisappear];
    }    
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [mImage drawInRect:mImageRect];
//    [mTitleText drawInRect:mTextLabel.frame withFont:[UIFont systemFontOfSize:15]];
}


- (void)layoutTotast
{
    CGSize  stringSize = [mTitleText commonSizeWithFont:[UIFont systemFontOfSize:kTextFontSize] constrainedToSize:CGSizeMake(280, 100)];
    CGRect  titleRect;
    
    if (mImage)
    {
        CGSize  imageSize = [mImage size];
        
        if (imageSize.width > stringSize.width)
        {
            mSize.width = imageSize.width + 2 * kViewMargin;
            mSize.height = imageSize.height + 2 * kViewMargin + kTitleHeight;
            
            mImageRect = CGRectMake(kViewMargin, kViewMargin, imageSize.width, imageSize.height);
            
            titleRect = CGRectMake(0, imageSize.height + kViewMargin + 5, mSize.width, kTitleHeight);
        }
        else 
        {
            mSize.width = stringSize.width + 2 * kViewMargin;
            mSize.height = stringSize.height + 2 * kViewMargin + kTitleHeight;
            
            mImageRect = CGRectMake((mSize.width - imageSize.width) / 2, kViewMargin, imageSize.width, imageSize.height);
            
            titleRect = CGRectMake(0, imageSize.height + kViewMargin + 5, mSize.width, kTitleHeight);
            
        }
    }
    else 
    {
        mImageRect = CGRectZero;
        mSize.width = stringSize.width + 2 * kViewMargin;
        mSize.height = stringSize.height + 2 * kViewMargin;
        
        titleRect = CGRectMake(0, kViewMargin, mSize.width, stringSize.height);
    }
    
    [mTextLabel setFrame:titleRect];
    [mTextLabel setText:mTitleText];    
}


- (void)toastWillAppear
{
    mState = kToastStateWillAppear;
}


- (void)toastDidAppear
{
    mState = kToastStateDidAppear;
    
    [self dismissWithDelay:mDisAppearTime];
}


- (void)toastWillDisappear
{
    mState = kToastStateWillDisappear; 
}


- (void)toastDidDisappear
{
    mState = kToastStateDidAppear;
    [self removeFromSuperview];
}


@end
