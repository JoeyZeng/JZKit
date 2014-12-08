//
//  FddKeyBoardToolBar.m
//  SecondHouseBroker
//
//  Created by lingyohunl on 14/11/12.
//  Copyright (c) 2014年 房多多. All rights reserved.
//

#import "FddKeyBoardToolBar.h"
@interface FddKeyBoardToolBar ()
@property (strong, readwrite, nonatomic) UISegmentedControl *navigationControl;
@end

@implementation FddKeyBoardToolBar

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (!self)
        return nil;
    
    [self sizeToFit];
    
    
    
    self.barStyle = UIBarStyleDefault;
    self.translucent = YES;
    
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleActionBarDone:)];
    self.navigationControl = [[UISegmentedControl alloc] initWithItems:@[@"上一个",@"下一个"]];
    self.navigationControl.momentary = YES;

//    self.navigationControl.segmentedControlStyle = UISegmentedControlStyleBar;

    self.navigationControl.tintColor = self.tintColor;
    [self.navigationControl addTarget:self action:@selector(handleActionBarPreviousNext:) forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *prevNextWrapper = [[UIBarButtonItem alloc] initWithCustomView:self.navigationControl];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self setItems:[NSArray arrayWithObjects:prevNextWrapper, flexible, doneButton, nil]];
    self.actionBarDelegate = delegate;
    
    return self;
}

- (void)handleActionBarPreviousNext:(UISegmentedControl *)segmentedControl
{
    if ([self.actionBarDelegate respondsToSelector:@selector(actionBar:navigationControlValueChanged:)])
        [self.actionBarDelegate actionBar:self navigationControlValueChanged:segmentedControl];
}

- (void)handleActionBarDone:(UIBarButtonItem *)doneButtonItem
{
    if ([self.actionBarDelegate respondsToSelector:@selector(actionBar:doneButtonPressed:)])
        [self.actionBarDelegate actionBar:self doneButtonPressed:doneButtonItem];
}

-(void)setSegment0Flag:(BOOL)falg {
    [self.navigationControl setEnabled:falg forSegmentAtIndex:0];
}
-(void)setSegment1Flag:(BOOL)falg {
    [self.navigationControl setEnabled:falg forSegmentAtIndex:1];
    
}


@end
