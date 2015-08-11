//
//  EnvelopeViewControllerSpec.m
//  Ching
//
//  Created by Nate Armstrong on 8/4/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import Specta;
@import Expecta;
@import ChingKit;
#import "OCMock.h"

#import "EnvelopeViewController.h"
#import "SingleInputTableViewCell.h"
#import "DecimalInputTableViewCell.h"
#import "CHEnvelope.h"
#import "SpecHelper.h"

SpecBegin(EnvelopeViewControllerSpec)

describe(@"EnvelopeViewController", ^{
	__block SpecHelper *_specHelper;
	beforeAll(^{
		_specHelper = [[SpecHelper alloc] init];
	});
	__block EnvelopeViewController *_vc;
	beforeEach(^{
		[_specHelper.persistenceController.managedObjectContext reset];
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
		_vc = [storyboard instantiateViewControllerWithIdentifier:@"EnvelopeViewController"];
		expect(_vc.tableView).toNot.beNil();
		expect(_vc.view).toNot.beNil();
		expect([_vc.tableView numberOfRowsInSection:0]).to.equal(2);
	});

	it(@"should be the correct class", ^{
		expect(_vc).to.beInstanceOf([EnvelopeViewController class]);
		expect([EnvelopeViewController class]).to.beSubclassOf([UITableViewController class]);
	});

	it(@"should have a name field", ^{
		expect([_vc nameCell]).to.beInstanceOf([SingleInputTableViewCell class]);
		expect([_vc nameCell].placeholder).to.equal(@"Groceries, Rent, Entertainment");
		expect([_vc nameCell].textField.text).to.equal(@"");
	});

	it(@"should have a budget field", ^{
		expect([_vc budgetCell]).to.beInstanceOf([DecimalInputTableViewCell class]);
		expect([_vc budgetCell].placeholder).to.equal(@"100.00");
		expect([_vc budgetCell].textField.text).to.equal(@"");
	});

	it(@"should only allow numbers in budget field", ^{
		[_vc budgetCell].textField.text = @"hello";
		expect([_vc budgetCell].textField.text).to.equal(@"");
	});

	it(@"should set name value given an envelope", ^{
		CHEnvelope *envelope = [CHEnvelope insertNewObjectInContext:_specHelper.persistenceController.managedObjectContext];
		envelope.name = @"Groceries";
		_vc.envelope = envelope;
		expect([_vc nameCell].textField.text).to.equal(@"Groceries");
	});

	it(@"should set budget value given an envelope", ^{
		CHEnvelope *envelope = [CHEnvelope insertNewObjectInContext:_specHelper.persistenceController.managedObjectContext];
		[envelope setBudgetWithDouble:100.0];
		envelope.createdAt = [NSDate date];
		_vc.envelope = envelope;
		expect([_vc budgetCell].textField.text).to.equal(@"100");
	});

	it(@"should have a cancel button", ^{
		UIBarButtonItem *leftBarButtonItem = [_vc navigationItem].leftBarButtonItem;
		expect(leftBarButtonItem).toNot.beNil();
	});

	it(@"should wire up cancel action", ^{
		UIBarButtonItem *button = [_vc navigationItem].leftBarButtonItem;
		expect(NSStringFromSelector(button.action)).to.equal(@"cancelButtonTapped:");
	});

	it(@"should unwind when cancel tapped", ^{
		UIBarButtonItem *cancelButton = [_vc navigationItem].leftBarButtonItem;
		id vcMock = [OCMockObject partialMockForObject:_vc];
		[_vc cancelButtonTapped:cancelButton];
		[[vcMock verify] performSegueWithIdentifier:@"unwindFromEnvelopeForm:" sender:cancelButton];
	});

	it(@"should have a save button", ^{
		expect(_vc.saveButton).toNot.beNil();
	});

	it(@"should wire up save action", ^{
		expect(NSStringFromSelector(_vc.saveButton.action)).to.equal(@"saveButtonTapped:");
	});

	it(@"should set envelope name on save", ^{
		CHEnvelope *envelope = [CHEnvelope insertNewObjectInContext:_specHelper.persistenceController.managedObjectContext];
		_vc.envelope = envelope;
		[_vc nameCell].textField.text = @"Groceries";
		[_vc saveButtonTapped:_vc.saveButton];
		expect(_vc.envelope.name).to.equal(@"Groceries");
	});

	it(@"should set envelope budget on save", ^{
		CHEnvelope *envelope = [CHEnvelope insertNewObjectInContext:_specHelper.persistenceController.managedObjectContext];
		_vc.envelope = envelope;
		[_vc budgetCell].textField.text = @"100.25";
		[_vc saveButtonTapped:_vc.saveButton];
		expect(_vc.envelope.budget).to.equal(100.25);
	});

	it(@"should unwind on save", ^{
		id vcMock = [OCMockObject partialMockForObject:_vc];
		NSManagedObjectContext *context = _specHelper.persistenceController.managedObjectContext;
		_vc.context = context;
		CHEnvelope *envelope = [CHEnvelope insertNewObjectInContext:context];
		_vc.envelope = envelope;
		[_vc nameCell].textField.text = @"Groceries";
		[_vc budgetCell].textField.text = @"100.25";
		[_vc saveButtonTapped:_vc.saveButton];
		[[vcMock verify] performSegueWithIdentifier:@"unwindFromEnvelopeForm:" sender:_vc.saveButton];
	});

});

SpecEnd
