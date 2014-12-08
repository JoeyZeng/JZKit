//
//  FDDTextViewCell.m
//  SecondHouseBroker
//
//  Created by lingyohunl on 14/10/30.
//  Copyright (c) 2014年 房多多. All rights reserved.
//

#import "FDDTextViewCell.h"
#import "NSString+SizeWithFont.h"
#import "UIView+Helpers.h"
#import "UtilityMacro.h"

@interface FDDTextViewCell ()<UITextViewDelegate>

@end
@implementation FDDTextViewCell

@synthesize textView = _textView;
@synthesize textLabel = _textLabel;
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


-(void)initialInternal{
    _textOriginX = 15;
    _textWidth = 60;
    _textViewSpace = 15;
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.textLabel];
    //self.textView.delegate = self;
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = [self.textLabel.text commonSizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(_textWidth, 1000)];
    
    self.textLabel.frame = CGRectMake(_textOriginX, (self.frameSizeHeight - size.height)/2, _textWidth, size.height);
    if (size.height == 0) {
        self.textLabel.frame = CGRectZero;
    }

    self.textView.frame = CGRectMake(self.textLabel.frameMaxX + _textViewSpace, 0, self.frameSizeWidth - self.textLabel.frameMaxX - _textViewSpace, self.frameSizeHeight);
    
    
    
}



#pragma mark - Properties

-(UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [UILabel new];
        [_textLabel setFont:[UIFont systemFontOfSize:15]];
        _textLabel.textColor = UIColorHexFromRGB(0x000000);
    }
    return _textLabel;
}

-(GCPlaceholderTextView *)textView
{
    if (!_textView) {
        _textView = [GCPlaceholderTextView new];
        [_textView setFont:[UIFont systemFontOfSize:15]];
        _textView.textColor = UIColorHexFromRGB(0x000000);
    }
    return _textView;
}



-(FddKeyBoardToolBar *)actionBar {
    if (!_actionBar) {
        _actionBar = [[FddKeyBoardToolBar alloc] initWithDelegate:self.actionDelegate];
    }
    return _actionBar;
}

-(void)setKeyboardBarFlag:(BOOL)keyboardBarFlag {
    _keyboardBarFlag = keyboardBarFlag;
    if (_keyboardBarFlag ) {
        _textView.inputAccessoryView = self.actionBar;
    }
}
-(void)setActionDelegate:(id<FddKeyBoardToolBarDelegate>)actionDelegate {
    _actionDelegate = actionDelegate;
    if (actionDelegate) {
        self.keyboardBarFlag = YES;
    }
    
    _actionBar.actionBarDelegate = _actionDelegate;
    
}




#pragma mark - UITextViewDelegate

//-(void)textViewDidEndEditing:(UITextView *)textView{
//    
//}
//
//-(void)textViewDidChange:(UITextView *)textView{
//    
//}



-(BOOL)cellBecomeFirstResponder
{
    return [self.textView becomeFirstResponder];
}

-(BOOL)cellResignFirstResponder
{
    return [self.textView resignFirstResponder];
}
@end
