//
//  TransactionViewControllerSpecs.m
//  Ching
//
//  Created by Nate Armstrong on 8/10/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import Specta;
@import Expecta;
#import "OCMock.h"

#import "TransactionViewController.h"
#import "TransactionsViewController.h"
#import "DecimalInputTableViewCell.h"
#import "SpecHelper.h"

SpecBegin(TransactionViewControllerSpec)

describe(@"TransactionViewController", ^{

	__block TransactionViewController *_controller;
	__block SpecHelper *_helper;
	beforeAll(^{
		_controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
					   instantiateViewControllerWithIdentifier:@"TransactionViewController"];
		_helper = [[SpecHelper alloc] init];

		expect(_controller.view).toNot.beNil();
	});

	afterEach(^{
		[_helper.persistenceController.managedObjectContext reset];
	});

	it(@"can be initialized from storyboard", ^{
		expect(_controller).toNot.beNil();
		expect(_controller).to.beInstanceOf([TransactionViewController class]);
		expect(_controller.view).toNot.beNil();
	});

	it(@"should have a cancel button", ^{
		UIBarButtonItem *cancel = _controller.navigationItem.leftBarButtonItem;
		expect(cancel).toNot.beNil();
	});

	it(@"should have an amount field", ^{
		expect(_controller.amountCell).toNot.beNil();
		expect(_controller.amountCell).to.beInstanceOf([DecimalInputTableViewCell class]);
	});

	it(@"should have a title field", ^{
		expect(_controller.titleCell).toNot.beNil();
		expect(_controller.titleCell).to.beInstanceOf([SingleInputTableViewCell class]);
	});

	it(@"should have a save button", ^{
		UIBarButtonItem *save = _controller.navigationItem.rightBarButtonItem;
		expect(save).toNot.beNil();
		expect(NSStringFromSelector(save.action)).to.equal(@"saveButtonTapped:");
	});

	it(@"should unwind on save", ^{
		NSManagedObjectContext *context = _helper.persistenceController.managedObjectContext;
		CHEnvelope *envelope = [CHEnvelope insertNewObjectInContext:context];
		envelope.name = @"Groceries";
		envelope.budget = [NSDecimalNumber decimalNumberWithString:@"100.0"];
		id mock = [OCMockObject partialMockForObject:_controller];
		CHTransaction *transaction = [CHTransaction insertNewObjectInContext:context];
		_controller.transaction = transaction;
		_controller.amountCell.textField.text = @"100.0";
		_controller.titleCell.textField.text = @"Harmons";
		[_controller saveButtonTapped:nil];
		[[mock verify] performSegueWithIdentifier:@"unwindFromTransactionForm:" sender:nil];
	});

});

SpecEnd