//
//  TransactionsViewController.m
//  Ching
//
//  Created by Nate Armstrong on 8/9/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "TransactionsViewController.h"
#import "TransactionViewController.h"

@interface TransactionsViewController ()

@end

@implementation TransactionsViewController

- (void)setEnvelope:(CHEnvelope *)envelope
{
	_envelope = envelope;
	[self setupFetchedResultsController];
	self.title = envelope.name;
}

- (void)setupFetchedResultsController
{
	if (self.envelope.managedObjectContext)
	{
		NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[CHTransaction entityName]];
		request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title"
																  ascending:YES
																   selector:@selector(localizedCaseInsensitiveCompare:)]];
		NSDate *now = [NSDate date];
		NSDate *start = [now dateAtBeginningOfMonth];
		NSDate *end = [now dateAtBeginningOfNextMonth];
		request.predicate = [NSPredicate predicateWithFormat:@"envelope = %@ AND createdAt >= %@ AND createdAt < %@", self.envelope, start, end];
		self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
																			managedObjectContext:self.envelope.managedObjectContext
																			  sectionNameKeyPath:nil
																					   cacheName:nil];
	}
	else
	{
		self.fetchedResultsController = nil;
	}
}

- (IBAction)addTransactionButtonTapped:(id)sender
{
	[self performSegueWithIdentifier:@"newTransaction" sender:sender];
}

- (IBAction)unwindFromTransactionForm:(UIStoryboardSegue *)segue
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"newTransaction"])
	{
		TransactionViewController *tvc = (TransactionViewController *)[segue.destinationViewController topViewController];
		NSManagedObjectContext *childContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
		childContext.parentContext = self.envelope.managedObjectContext;
		tvc.transaction = [CHTransaction insertNewObjectInContext:childContext];
	}
}

@end
