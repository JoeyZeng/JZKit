//
//  FDDTextFeildCell.m
//  SecondHouseBroker
//
//  Created by lingyohunl on 14/10/30.
//  Copyright (c) 2014年 房多多. All rights reserved.
//

#import "FDDTextFeildCell.h"
#import "NSString+SizeWithFont.h"
#import "UtilityMacro.h"
#import "UIView+Helpers.h"

@implementation FDDTextFeildCell
@synthesize textField = _textField;
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
    _textWidth = 100;
    _fieldSpace = 15;
    [self.contentView addSubview:self.textLabel];
    [self.contentView addSubview:self.textField];
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = [self.textLabel.text commonSizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(_textWidth, 1000)];
    
    self.textLabel.frame = CGRectMake(_textOriginX, (self.frameSizeHeight - size.height)/2, _textWidth, size.height);
    self.textField.frame = CGRectMake(self.textLabel.frameMaxX + _fieldSpace, 0, self.frameSizeWidth - self.textLabel.frameMaxX - _fieldSpace, self.frameSizeHeight);
    
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

-(UITextField *)textField
{
    if (!_textField) {
        _textField = [UITextField new];
        [_textField setFont:[UIFont systemFontOfSize:15]];
        _textField.textColor = UIColorHexFromRGB(0x000000);
    
        if (self.keyboardBarFlag) {
            _textField.inputAccessoryView = self.actionBar;
        }
        
    }
    return _textField;
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
        _textField.inputAccessoryView = self.actionBar;
    }
}
-(void)setActionDelegate:(id<FddKeyBoardToolBarDelegate>)actionDelegate {
    _actionDelegate = actionDelegate;
    if (actionDelegate) {
        self.keyboardBarFlag = YES;
    }
    
    _actionBar.actionBarDelegate = _actionDelegate;
    
}

-(BOOL)cellBecomeFirstResponder
{
    return [self.textField becomeFirstResponder];
}

-(BOOL)cellResignFirstResponder
{
    return [self.textField resignFirstResponder];
}




@end
