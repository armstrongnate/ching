//
//  CHNumberTextFieldDelegate.m
//  Ching
//
//  Created by Nate Armstrong on 8/4/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "CHNumberTextFieldDelegate.h"

@implementation CHNumberTextFieldDelegate

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"text"] && [object isKindOfClass:[UITextField class]])
	{
		UITextField *textField = (UITextField *)object;
		[self numberizeTextField:textField];
	}
}

- (void)textFieldDidChange:(id)sender
{
	if ([sender isKindOfClass:[UITextField class]])
	{
		[self numberizeTextField:(UITextField *)sender];
	}
}

- (void)numberizeTextField:(UITextField *)textField
{
	NSString *cleanedString = [self convertStringToDecimalString:textField.text];
	[textField removeObserver:self forKeyPath:@"text"];
	textField.text = cleanedString;
	[textField addObserver:self forKeyPath:@"text" options:0 context:nil];

}

- (NSString *)convertStringToDecimalString:(NSString *)string
{
	NSDecimalNumber *decimal = [[NSDecimalNumber alloc] initWithString:string];
	// if there is a '.' join left of '.' with right of '.' by a '.'
	NSRange periodRange = [string rangeOfString:@"."];
	if (periodRange.location != NSNotFound)
	{
		NSString *left, *right;

		left = [string substringToIndex:periodRange.location];
		NSDecimalNumber *leftDecimal = [[NSDecimalNumber alloc] initWithString:left];
		left = [self convertDecimalNumberToString:leftDecimal];

		right = [string substringFromIndex:periodRange.location + 1];
		if ([right rangeOfString:@"."].location != NSNotFound)
		{
			right = [right substringToIndex:[right rangeOfString:@"."].location];
		}
		if (right.length > 0) right = [NSString stringWithFormat:@".%@", right];
		NSDecimalNumber *rightDecimal = [[NSDecimalNumber alloc] initWithString:right];
		right = [self convertDecimalNumberToString:rightDecimal];
		if (right.length >= 2) right = [right substringFromIndex:2];

		return [NSString stringWithFormat:@"%@.%@", left, right];
	}
	return [self convertDecimalNumberToString:decimal];
}

- (NSString *)convertDecimalNumberToString:(NSDecimalNumber *)decimal
{
	if ([decimal compare:[NSDecimalNumber notANumber]] == NSOrderedSame)
	{
		return @"";
	}
	NSString *decimalString = [NSString stringWithFormat:@"%@", decimal];
	return decimalString;
}

@end
