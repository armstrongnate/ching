//
//  CHNumberTextFieldDelegate.m
//  Ching
//
//  Created by Nate Armstrong on 8/4/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "CHNumberTextFieldDelegate.h"

@implementation CHNumberTextFieldDelegate

#pragma mark - UITextFieldDelegate

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"text"] && [object isKindOfClass:[UITextField class]])
	{
		UITextField *textField = (UITextField *)object;
		[self stripNonDecimalCharactersFromTextField:textField];
	}
}

- (void)stripNonDecimalCharactersFromTextField:(UITextField *)textField
{
	NSString *cleanedString = [[textField.text componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet]] componentsJoinedByString:@""];
	[textField removeObserver:self forKeyPath:@"text"];
	textField.text = cleanedString;
	[textField addObserver:self forKeyPath:@"text" options:0 context:nil];

}

- (void)textFieldDidChange:(id)sender
{
	if ([sender isKindOfClass:[UITextField class]])
	{
		[self stripNonDecimalCharactersFromTextField:(UITextField *)sender];
	}
}

@end
