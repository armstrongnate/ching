//
//  EnvelopesViewControllerSpec.m
//  Ching
//
//  Created by Nate Armstrong on 8/2/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import Specta;
@import Expecta;
@import ChingKit;
#import "OCMock.h"

#import "EnvelopesViewController.h"
#import "EnvelopeViewController.h"

SpecBegin(EnvelopesViewControllerSpec)

describe(@"EnvelopesViewController", ^{
	__block NSManagedObjectContext *context;
	beforeAll(^{
    	CHInMemoryPersistenceController *persistenceController = [[CHInMemoryPersistenceController alloc] init];
		context = persistenceController.managedObjectContext;
    	CHEnvelope *envelope = [CHEnvelope insertNewObjectInContext:context];
    	envelope.name = @"Groceries";
    	envelope.budget = [[NSDecimalNumber alloc] initWithDouble:100.0];
    	envelope.identifier = 1;
	});

	__block EnvelopesViewController *_vc;
	beforeEach(^{
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
		UISplitViewController *splitVC = [storyboard instantiateInitialViewController];
    	UINavigationController *nav = [[splitVC viewControllers] firstObject];
		_vc = (EnvelopesViewController *)[nav visibleViewController];
		_vc.context = context;

		expect(_vc.view).toNot.beNil();
		expect(_vc).to.beInstanceOf([EnvelopesViewController class]);
		expect(splitVC).to.beInstanceOf([UISplitViewController class]);
	});

	it(@"should be instantiated from the storyboard", ^{
		expect(_vc).toNot.beNil();
	});

	it(@"should contain a table view", ^{
		expect(_vc.tableView).toNot.beNil();
	});

	it(@"should contain an envelope", ^{
		expect([_vc.tableView numberOfRowsInSection:0]).to.equal(1);
		UITableViewCell *cell = [_vc.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
		expect(cell.textLabel.text).to.equal(@"Groceries");
	});

	it(@"should have an add button", ^{
		expect(_vc.addButton).toNot.beNil();
	});

	it(@"should wire up add button action", ^{
		UIBarButtonItem *button = _vc.addButton;
		expect(NSStringFromSelector(button.action)).to.equal(@"addEnvelopeButtonTapped:");
	});

	it(@"should perform segue when add button tapped", ^{
		id envelopesMock = [OCMockObject partialMockForObject:_vc];
		[[envelopesMock expect] performSegueWithIdentifier:@"newEnvelope" sender:_vc.addButton];
		[_vc addEnvelopeButtonTapped:_vc.addButton];
		[envelopesMock verify];
	});

	it(@"should prepare for new envelope segue", ^{
		EnvelopeViewController *evc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"EnvelopeViewController"];
		UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:evc];
		UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"newEnvelope" source:_vc destination:nav];
		[_vc prepareForSegue:segue sender:_vc.addButton];
		expect(evc.context).notTo.beNil();
		expect(evc.title).to.equal(@"New Envelope");
		expect(evc.envelope).notTo.beNil();
		expect(evc.envelope.name).to.beNil();
		expect(evc.envelope.budget).to.equal(0);
	});

});

SpecEnd
