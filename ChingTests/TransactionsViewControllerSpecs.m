//
//  TransactionsViewControllerSpecs.m
//  Ching
//
//  Created by Nate Armstrong on 8/10/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import Specta;
@import Expecta;
@import ChingKit;
#import "OCMock.h"

#import "SpecHelper.h"
#import "TransactionsViewController.h"
#import "TransactionViewController.h"

SpecBegin(TransactionsViewControllerSpec)

describe(@"TransactionsViewController", ^{

	__block SpecHelper *_helper;
	__block TransactionsViewController *_controller;
	beforeAll(^{
		_helper = [[SpecHelper alloc] init];
		_controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TransactionsViewController"];
	});

	afterEach(^{
		[_helper.persistenceController.managedObjectContext reset];
	});

	it(@"should list transactions belonging to an envelope", ^{
		NSManagedObjectContext *context = _helper.persistenceController.managedObjectContext;
		CHEnvelope *envelope = [CHEnvelope insertNewObjectInContext:context];
		envelope.name = @"Groceries";
		[envelope setBudgetWithDouble:100.0];
		CHTransaction *transaction = [CHTransaction insertNewObjectInContext:context];
		transaction.amount = [NSDecimalNumber decimalNumberWithString:@"100.0"];
		transaction.title = @"McDonalds";
		transaction.createdAt = [NSDate date];
		transaction.envelope = envelope;
		_controller.envelope = envelope;
		expect(_controller.title).to.equal(@"Groceries");
		expect(_controller.fetchedResultsController).toNot.beNil();
		expect([_controller.fetchedResultsController.fetchedObjects count]).to.equal(1);
	});

	it(@"should have a button to add a new transaction", ^{
		expect(_controller.view).toNot.beNil();
		expect(_controller.addButton).toNot.beNil();
	});

	it(@"should only show transactions for this month", ^{
		NSManagedObjectContext *context = _helper.persistenceController.managedObjectContext;
		CHEnvelope *envelope = [CHEnvelope insertNewObjectInContext:context];
		CHTransaction *lastMonth = [CHTransaction insertNewObjectInContext:context];
		lastMonth.createdAt = [NSDate dateWithTimeIntervalSinceNow:-(60 * 60 * 24 * 32)];
		lastMonth.envelope = envelope;
		lastMonth.title = @"Last Month";
		CHTransaction *thisMonth = [CHTransaction insertNewObjectInContext:context];
		thisMonth.createdAt = [NSDate new];
		thisMonth.envelope = envelope;
		thisMonth.title = @"This Month";
		_controller.envelope = envelope;
		expect([_controller.fetchedResultsController.fetchedObjects count]).to.equal(1);
		expect([_controller.fetchedResultsController.fetchedObjects lastObject] == thisMonth).to.beTruthy();
	});

	it(@"should only show transactions for envelope", ^{
		NSManagedObjectContext *context = _helper.persistenceController.managedObjectContext;
		CHEnvelope *groceries = [CHEnvelope insertNewObjectInContext:context];
		groceries.name = @"Groceries";
		CHTransaction *harmons = [CHTransaction insertNewObjectInContext:context];
		harmons.createdAt = [NSDate date];
		harmons.envelope = groceries;
		harmons.title = @"Harmons";
		CHEnvelope *entertainment = [CHEnvelope insertNewObjectInContext:context];
		entertainment.name = @"Entertainment";
		CHTransaction *movies = [CHTransaction insertNewObjectInContext:context];
		movies.envelope = entertainment;
		movies.title = @"Movies";
		_controller.envelope = groceries;
		expect(_controller.fetchedResultsController.fetchedObjects.count).to.equal(1);
		expect([_controller.fetchedResultsController.fetchedObjects lastObject] == harmons).to.beTruthy();
	});

	it(@"should wire up add button action", ^{
		UIBarButtonItem *btn = _controller.addButton;
		expect(NSStringFromSelector(btn.action)).to.equal(@"addTransactionButtonTapped:");
	});

	it(@"should perform segue when add button tapped", ^{
		id mock = [OCMockObject partialMockForObject:_controller];
		[[mock expect] performSegueWithIdentifier:@"newTransaction" sender:_controller.addButton];
		[_controller addTransactionButtonTapped:_controller.addButton];
		[mock verify];
	});

	it(@"prepares for new transaction segue", ^{
		NSManagedObjectContext *context = _helper.persistenceController.managedObjectContext;
		_controller.envelope = [CHEnvelope insertNewObjectInContext:context];
		TransactionViewController *tvc = [[TransactionViewController alloc] init];
		UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tvc];
		UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"newTransaction"
																		  source:_controller
																	 destination:nav];
		[_controller prepareForSegue:segue sender:_controller.addButton];
		expect(tvc.transaction).toNot.beNil();
	});
	
});

SpecEnd
