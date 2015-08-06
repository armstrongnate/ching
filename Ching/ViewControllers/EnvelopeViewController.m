//
//  EnvelopeViewController.m
//  Ching
//
//  Created by Nate Armstrong on 8/4/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "EnvelopeViewController.h"
#import "SingleInputTableViewCell.h"

@interface EnvelopeViewController ()

@end

@implementation EnvelopeViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[[self nameCell].textField becomeFirstResponder];
}

- (void)setEnvelope:(CHEnvelope *)envelope
{
	_envelope = envelope;
	[self nameCell].textField.text = [self.envelope name];
	[self budgetCell].textField.text = [NSNumberFormatter localizedStringFromNumber:[self.envelope budget] numberStyle:NSNumberFormatterDecimalStyle];
	if ([envelope isNewRecord])
	{
		[self budgetCell].textField.text = @"";
	}
}

- (SingleInputTableViewCell *)nameCell
{
	return (SingleInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (SingleInputTableViewCell *)budgetCell
{
	return (SingleInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
}

- (IBAction)cancelButtonTapped:(id)sender
{
	[self performSegueWithIdentifier:@"unwindFromEnvelopeForm:" sender:sender];
}

@end
