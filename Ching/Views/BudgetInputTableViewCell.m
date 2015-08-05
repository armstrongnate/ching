//
//  BudgetInputTableViewCell.m
//  Ching
//
//  Created by Nate Armstrong on 8/4/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "BudgetInputTableViewCell.h"
#import "CHNumberTextFieldDelegate.h"

@interface BudgetInputTableViewCell ()

@property (nonatomic, strong) CHNumberTextFieldDelegate *numberDelegate;

@end

@implementation BudgetInputTableViewCell

- (void)dealloc
{
	[self.textField removeObserver:self.numberDelegate forKeyPath:@"text"];
	[self.textField removeTarget:self.numberDelegate
						  action:@selector(textFieldDidChange:)
				forControlEvents:UIControlEventEditingChanged];
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.textField.keyboardType = UIKeyboardTypeDecimalPad;

	// programmatic changes (textField.text = @"something")
	[self.textField addObserver:self.numberDelegate
					 forKeyPath:@"text"
						options:0
						context:nil];

	// user input changes (UIKit observer)
	[self.textField addTarget:self.numberDelegate
					   action:@selector(textFieldDidChange:)
			 forControlEvents:UIControlEventEditingChanged];
}

- (CHNumberTextFieldDelegate *)numberDelegate
{
	if (!_numberDelegate)
	{
		_numberDelegate = [[CHNumberTextFieldDelegate alloc] init];
	}
	return _numberDelegate;
}

@end
