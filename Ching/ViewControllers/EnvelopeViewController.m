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

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

- (void)setEnvelope:(CHEnvelope *)envelope
{
	_envelope = envelope;
}

- (SingleInputTableViewCell *)nameCell
{
	return (SingleInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (SingleInputTableViewCell *)budgetCell
{
	return (SingleInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	SingleInputTableViewCell *cell = (SingleInputTableViewCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
	if (self.envelope)
	{
    	switch (indexPath.row)
		{
    		case 0:
    			cell.textField.text = [self.envelope name];
    			break;
    		case 1:
            	cell.textField.text = [NSNumberFormatter localizedStringFromNumber:[self.envelope budget] numberStyle:NSNumberFormatterDecimalStyle];

    		default:
    			break;
    	}
	}
	return cell;
}


@end
