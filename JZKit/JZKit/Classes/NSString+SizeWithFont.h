//
//  NSString+FDDExtention.h
//  SecondHouseBroker
//
//  Created by Yohunl on 14-8-18.
//  Copyright (c) 2014年 Lin Dongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (SizeWithFont)
- (CGSize)commonSizeWithFont:(UIFont *)font;
- (CGSize)commonSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
@end
