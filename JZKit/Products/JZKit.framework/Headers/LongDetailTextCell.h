//
//  LongDetailTextCell.h
//  SecondHouseBroker
//
//  Created by Yohunl on 14-8-18.
//  Copyright (c) 2014年 Lin Dongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDDUITableViewCell.h"
/**
 *  长详细文本视图
 */
@interface LongDetailTextCell : FDDUITableViewCell

/**
 *  标题文本,距离左边的边距,默认为15
 */
@property (nonatomic,assign)CGFloat textOriginX;


/**
 *  标题文本的宽度,默认为80
 */
@property (nonatomic,assign)CGFloat textWidth;

/**
 *  详细文本起始位置距离标题文本的间距.默认为34
 */
@property (nonatomic,assign)CGFloat detailSpace;
/**
 *  详细文本的宽度.默认为168
 */
@property (nonatomic,assign)CGFloat detailWidth;

/**
 *  详细文本和cell的上下的间距,目前我们是只能是一致的间距.默认为14.
 */
@property (nonatomic,assign)CGFloat detailTopBottomSpace;

/**
 *  计算出来的最佳推荐的高度,当然可以不用
 */
@property(nonatomic,assign)CGFloat recommendHeight;

/**
 *  设置cell的最小高度,默认为44;
 */
@property (nonatomic,assign) CGFloat minCellHeight;


-(void)setText:(NSString *)text1 detail:(NSString *)text2;
@end
