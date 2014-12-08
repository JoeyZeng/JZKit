//
//  UIImage+Tint.h
//
//  Created by Matt Gemmell on 04/07/2010.
//  Copyright 2010 Instinctive Code.
//

#import <UIKit/UIKit.h>

@interface UIImage (MGTint)

- (UIImage *)imageTintedWithColor:(UIColor *)color;
- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageOfSize:(CGSize)size color:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
