//
//  EnvelopesViewController.m
//  Ching
//
//  Created by Nate Armstrong on 8/2/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import ChingKit;

#import "EnvelopesViewController.h"

@implementation EnvelopesViewController

- (void)setContext:(NSManagedObjectContext *)context
{
	_context = context;
	if (context)
	{
		NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[CHEnvelope entityName]];
		request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
																  ascending:YES
																   selector:@selector(localizedCaseInsensitiveCompare:)]];
		request.predicate = nil; // all envelopes
		self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
	}
	else
	{
		self.fetchedResultsController = nil;
	}
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Envelope"];
	CHEnvelope *envelope = [self.fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = envelope.name;
	return cell;
}

@end
