//
//  SingleInputTableViewCell.m
//  Ching
//
//  Created by Nate Armstrong on 8/3/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import ChingKit;

#import "SingleInputTableViewCell.h"

static CGFloat const FontSize = 15;
static CGFloat const LeftMargin = 15;
static CGFloat const LabelSpacing = 10;

@interface SingleInputTableViewCell ()

@property (nonatomic, strong) UILabel *labelView;

@end

@implementation SingleInputTableViewCell

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.textField.placeholder = self.placeholder;
	if (self.placeholder != nil)
	{
    	self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder
																		   attributes:@{ NSFontAttributeName : [UIFont italicSystemFontOfSize:FontSize] }];
	}
	self.labelView.text = self.label;
}

- (UITextField *)textField
{
	if (!_textField)
	{
		_textField = [[UITextField alloc] init];
		[self.contentView addSubview:_textField];
		_textField.borderStyle = UITextBorderStyleNone;
		_textField.font = [UIFont systemFontOfSize:FontSize];
	}
	return _textField;
}

- (UILabel *)labelView
{
	if (!_labelView)
	{
		_labelView = [[UILabel alloc] init];
		_labelView.textColor = [UIColor primaryColor];
		_labelView.font = [UIFont boldSystemFontOfSize:FontSize];
		[self.contentView addSubview:_labelView];
	}
	return _labelView;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	[self.labelView sizeToFit];
	self.labelView.frame = CGRectMake(LeftMargin, 0, self.labelView.frame.size.width, self.bounds.size.height);
	CGFloat textFieldLeft = CGRectGetMaxX(self.labelView.frame) + LabelSpacing;
	self.textField.frame = CGRectMake(textFieldLeft, 0, self.bounds.size.width - textFieldLeft, self.bounds.size.height);
}

@end
