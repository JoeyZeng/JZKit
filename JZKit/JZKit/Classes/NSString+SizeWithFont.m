//
//  NSString+FDDExtention.m
//  SecondHouseBroker
//
//  Created by Yohunl on 14-8-18.
//  Copyright (c) 2014年 Lin Dongpeng. All rights reserved.
//

#import "NSString+SizeWithFont.h"

@implementation NSString (SizeWithFont)


- (CGSize)commonSizeWithFont:(UIFont *)font
{
    CGSize size;
    if ([self respondsToSelector:@selector(sizeWithAttributes:)]) {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(sizeWithAttributes:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(sizeWithAttributes:)];
        NSDictionary *attributes = @{ NSFontAttributeName:font };
        [invocation setArgument:&attributes atIndex:2];
        [invocation invoke];
        [invocation getReturnValue:&size];
    } else {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(sizeWithFont:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(sizeWithFont:)];
        [invocation setArgument:&font atIndex:2];
        [invocation invoke];
        [invocation getReturnValue:&size];
    }
    return size;
}

- (CGSize)commonSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize resultSize;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(boundingRectWithSize:options:attributes:context:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(boundingRectWithSize:options:attributes:context:)];
        NSDictionary *attributes = @{ NSFontAttributeName:font };
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        NSStringDrawingContext *context;
        [invocation setArgument:&size atIndex:2];
        [invocation setArgument:&options atIndex:3];
        [invocation setArgument:&attributes atIndex:4];
        [invocation setArgument:&context atIndex:5];
        [invocation invoke];
        CGRect rect;
        [invocation getReturnValue:&rect];
        resultSize = rect.size;
    } else {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(sizeWithFont:constrainedToSize:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(sizeWithFont:constrainedToSize:)];
        [invocation setArgument:&font atIndex:2];
        [invocation setArgument:&size atIndex:3];
        [invocation invoke];
        [invocation getReturnValue:&resultSize];
    }
    
    return resultSize;
}

@end
