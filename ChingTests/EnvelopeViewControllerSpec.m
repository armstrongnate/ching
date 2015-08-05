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
#import "BudgetInputTableViewCell.h"
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
	});

	it(@"should have a budget field", ^{
		expect([_vc budgetCell]).to.beInstanceOf([BudgetInputTableViewCell class]);
		expect([_vc budgetCell].placeholder).to.equal(@"100.00");
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
		_vc.envelope = envelope;
		expect([_vc budgetCell].textField.text).to.equal(@"100");
	});
});

SpecEnd
