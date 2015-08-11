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

SpecBegin(TransactionViewControllerSpec)

describe(@"TransactionViewController", ^{

	__block TransactionViewController *_controller;
	beforeAll(^{
		_controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
					   instantiateViewControllerWithIdentifier:@"TransactionViewController"];
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

});

SpecEnd