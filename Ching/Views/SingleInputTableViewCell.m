//
//  SingleInputTableViewCell.m
//  Ching
//
//  Created by Nate Armstrong on 8/3/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "SingleInputTableViewCell.h"

@interface SingleInputTableViewCell ()

- (void)setup;

@end

@implementation SingleInputTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
	if (!(self = [super initWithFrame:frame])) return nil;
	[self setup];
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (!(self = [super initWithCoder:aDecoder])) return nil;
	[self setup];
	return self;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.textField.placeholder = self.placeholder;
	if (!self.dx) self.dx = 15;
}

- (void)setup
{
	[self.contentView addSubview:self.textField];
	[self setTranslatesAutoresizingMaskIntoConstraints:false];
	[self.contentView setTranslatesAutoresizingMaskIntoConstraints:false];
	[self.textField setTranslatesAutoresizingMaskIntoConstraints:false];
}

- (UITextField *)textField
{
	if (!_textField)
	{
		_textField = [[UITextField alloc] init];
		_textField.borderStyle = UITextBorderStyleNone;
		_textField.clearButtonMode = UITextFieldViewModeAlways;
	}
	return _textField;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	self.textField.frame = CGRectInset(self.contentView.frame, self.dx, 0);
}

@end
