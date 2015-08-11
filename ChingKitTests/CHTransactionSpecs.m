//
//  CHTransactionSpecs.m
//  Ching
//
//  Created by Nate Armstrong on 8/10/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import Specta;
@import Expecta;
@import ChingKit;

SpecBegin(CHTransactionSpec)

describe(@"CHTransaction", ^{
	__block NSManagedObjectContext *_context;
	beforeAll(^{
		CHInMemoryPersistenceController *persistenceController = [[CHInMemoryPersistenceController alloc] init];
		_context = persistenceController.managedObjectContext;
	});

	afterEach(^{
		[_context reset];
	});

	it(@"can be inserted into a managed object context", ^{
		CHTransaction *transaction = [CHTransaction insertNewObjectInContext:_context];
		expect(transaction).notTo.beNil();
	});

	it(@"can have an amount", ^{
		CHTransaction *transaction = [CHTransaction insertNewObjectInContext:_context];
		transaction.amount = [[NSDecimalNumber alloc] initWithDouble:100.0];
		expect(transaction.amount).to.equal(100.0);
	});

	it(@"can have a title", ^{
		CHTransaction *transaction = [CHTransaction insertNewObjectInContext:_context];
		transaction.title = @"McDonalds";
		expect(transaction.title).to.equal(@"McDonalds");
	});

	it(@"can belong to an envelope", ^{
		CHTransaction *transaction = [CHTransaction insertNewObjectInContext:_context];
		transaction.envelope = [CHEnvelope insertNewObjectInContext:_context];
		expect(transaction.envelope).toNot.beNil();
	});

});

SpecEnd
