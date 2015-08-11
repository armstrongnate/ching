//
//  TransactionViewController.m
//  Ching
//
//  Created by Nate Armstrong on 8/10/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "TransactionViewController.h"

@interface TransactionViewController ()

@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation TransactionViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"Transaction";
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.amountCell.textField becomeFirstResponder];
}

- (IBAction)saveButtonTapped:(id)sender
{
	self.transaction.title = self.titleCell.textField.text;
	self.transaction.amount = [NSDecimalNumber decimalNumberWithString:self.amountCell.textField.text];
	NSError *error;
	if ([self.context save:&error])
	{
		[self performSegueWithIdentifier:@"unwindFromTransactionForm:" sender:sender];
	}
}

- (void)setTransaction:(CHTransaction *)transaction
{
	_transaction = transaction;
	self.context = transaction.managedObjectContext;
}

@end
