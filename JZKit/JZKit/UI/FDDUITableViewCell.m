//
//  FDDUITableViewCell.m
//  SecondHouseBroker
//
//  Created by Yohunl on 14-6-11.
//  Copyright (c) 2014年 Lin Dongpeng. All rights reserved.
//

#import "FDDUITableViewCell.h"
#import "UIImage+Tint.h"
#import "UtilityMacro.h"
#import "UIView+Helpers.h"

@implementation FDDUITableViewCell
{
    BOOL _isInitialize;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self internalInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [self internalInit];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self internalInit];
    }
    return self;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
}

-(void)internalInit{
    
    if (_isInitialize) {
        return;
    }
    _lineColor = UIColorHexFromRGB(0xd9d9d9);
    _isInitialize = YES;
   
    _lineviewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frameSizeWidth, 0.5)];
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:_lineviewTop.bounds];
    imgview.image = [UIImage imageWithColor:_lineColor size:_lineviewTop.frameSize];
    [_lineviewTop addSubview:imgview];
    
    _lineviewTop.backgroundColor = [UIColor clearColor];
    _lineviewBottom = [[UIView alloc]initWithFrame:CGRectMake(0, self.frameSizeHeight - 0.5, self.frameSizeWidth, 0.5)];
    _lineviewBottom.backgroundColor = [UIColor clearColor];
    
    UIImageView *imgview2 = [[UIImageView alloc]initWithFrame:_lineviewBottom.bounds];
    imgview2.image = [UIImage imageWithColor:_lineColor size:_lineviewBottom.frameSize];
    [_lineviewBottom addSubview:imgview2];
    

    [self addSubview:_lineviewBottom];
    [self addSubview:_lineviewTop];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frameSizeWidth, self.frameSizeHeight)];
    view.backgroundColor = [UIColor whiteColor];
    self.backgroundView = view;
    //self.backgroundColor = [UIColor whiteColor];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frameSizeWidth, self.frameSizeHeight)];
    view1.backgroundColor = UIColorFromRGB(213, 213, 213);;
    
    self.selectedBackgroundView = view1;
}

-(void)setCellType:(SecondHouseCellType)type{
    _cellType = type;
    switch (type) {
            
        case SecondHouseCellTypeFirst:
            _lineviewTop.hidden = NO;
            _lineviewBottom.hidden = YES;
            break;
        case SecondHouseCellTypeMiddle:
            _lineviewTop.hidden = NO;
            _lineviewBottom.hidden = YES;
            break;
        case SecondHouseCellTypeLast:
            _lineviewTop.hidden = NO;
            _lineviewBottom.hidden = NO;
            break;
        case SecondHouseCellTypeSingle:
            _lineviewTop.hidden = NO;
            _lineviewBottom.hidden = NO;
            break;
        case SecondHouseCellTypeAny:
            _lineviewTop.hidden = YES;
            _lineviewBottom.hidden = YES;
            break;
        case SecondHouseCellTypeHaveTop:
            _lineviewTop.hidden = NO;
            _lineviewBottom.hidden = YES;
            break;
        case SecondHouseCellTypeHaveBottom:
            _lineviewTop.hidden = YES;
            _lineviewBottom.hidden = NO;
            break;
        default:
            break;
            
    }
    [self setNeedsLayout];
    
}

- (int)separateLineOffset
{
    if (_separateLineOffset == 0) {
        _separateLineOffset = 15;   // 默认15
    }
    return _separateLineOffset;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (_ios7SeperatorStyle) {
        switch (_cellType) {
                
            case SecondHouseCellTypeFirst:
                _lineviewTop.frame = CGRectMake(0, 0, self.frameSizeWidth, 0.5);
                break;
            case SecondHouseCellTypeMiddle:
                _lineviewTop.frame = CGRectMake(self.separateLineOffset, 0, self.frameSizeWidth - self.separateLineOffset, 0.5);
                break;
            case SecondHouseCellTypeLast:
                _lineviewTop.frame = CGRectMake(self.separateLineOffset, 0, self.frameSizeWidth - self.separateLineOffset, 0.5);
                
                _lineviewBottom.frame = CGRectMake(0, self.frameSizeHeight - 0.5, self.frameSizeWidth , 0.5);
                _lineviewBottom.hidden = NO;
                break;
            case SecondHouseCellTypeSingle:
                _lineviewTop.frame = CGRectMake(0, 0, self.frameSizeWidth, 0.5);
                _lineviewBottom.frame =CGRectMake(0, self.frameSizeHeight - 0.5, self.frameSizeWidth, 0.5);
                break;
            case SecondHouseCellTypeAny:
                _lineviewTop.frame = CGRectMake(0, 0, self.frameSizeWidth, 0.5);
                _lineviewBottom.frame =CGRectMake(0, self.frameSizeHeight - 0.5, self.frameSizeWidth, 0.5);
                break;
            default:
                break;
        }

    }
    else {
        _lineviewTop.frame = CGRectMake(0, 0, self.frameSizeWidth, 0.5);
        _lineviewBottom.frame =CGRectMake(0, self.frameSizeHeight - 0.5, self.frameSizeWidth, 0.5);
    }
    
}


-(void)setSeperatorLineForIOS7 :(NSIndexPath *)indexPath numberOfRowsInSection: (NSInteger)numberOfRowsInSection{
    [self setIos7SeperatorStyle:YES];
    if (indexPath.row == 0 && numberOfRowsInSection == 1){
        [self setCellType:SecondHouseCellTypeSingle];
    }
    else if (indexPath.row == 0 && numberOfRowsInSection > 1){
        [self setCellType:SecondHouseCellTypeFirst];
    }
    else if (indexPath.row > 0 && indexPath.row < numberOfRowsInSection - 1 && numberOfRowsInSection > 2){
        [self setCellType:SecondHouseCellTypeMiddle];
    }
    else if (indexPath.row == numberOfRowsInSection - 1 && numberOfRowsInSection > 1){
        [self setCellType:SecondHouseCellTypeLast];
    }
}

@end
