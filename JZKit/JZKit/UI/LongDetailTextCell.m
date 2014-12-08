//
//  LongDetailTextCell.m
//  SecondHouseBroker
//
//  Created by Yohunl on 14-8-18.
//  Copyright (c) 2014年 Lin Dongpeng. All rights reserved.
//

#import "LongDetailTextCell.h"
#import "NSString+SizeWithFont.h"
#import "UIView+Helpers.h"

@implementation LongDetailTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialInternal];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initialInternal];
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialInternal];
    }
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

  
}


-(void)initialInternal{
    _textOriginX = 15;
    _detailSpace = 20;
    _detailWidth = 168;
    _textWidth = 80;
    _detailTopBottomSpace = 14;
    _minCellHeight = 44;
    self.detailTextLabel.numberOfLines = 0;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = [self.textLabel.text commonSizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(_textWidth, 1000)];

    self.textLabel.frame = CGRectMake(_textOriginX, _detailTopBottomSpace, _textWidth, size.height);
    self.detailTextLabel.frame = CGRectMake(self.textLabel.frameMaxX + _detailSpace, _detailTopBottomSpace, _detailWidth, self.frameSizeHeight - _detailTopBottomSpace * 2);
    
}

-(void)setText:(NSString *)text1 detail:(NSString *)text2;{
    self.textLabel.text = text1;
    
    self.detailTextLabel.text = text2;
    CGSize size = [text2 commonSizeWithFont:self.detailTextLabel.font constrainedToSize:CGSizeMake(_detailWidth, 1000)];
    _recommendHeight = size.height + 2 + _detailTopBottomSpace*2;
    if (_recommendHeight < _minCellHeight) {
        _recommendHeight = _minCellHeight;
    }
    self.frameSizeHeight = _recommendHeight;
    
    
    
    
}
@end
