//
//  BudgetInputTableViewCell.m
//  Ching
//
//  Created by Nate Armstrong on 8/4/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "BudgetInputTableViewCell.h"

@implementation BudgetInputTableViewCell

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.textField.keyboardType = UIKeyboardTypeDecimalPad;
}

@end
