//
//  CHEnvelopeSpecs.m
//  Ching
//
//  Created by Nate Armstrong on 8/3/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import Specta;
@import Expecta;
@import ChingKit;

SpecBegin(CHEnvelopeSpec)

describe(@"CHEnvelope", ^{
	__block NSManagedObjectContext *context;
	beforeAll(^{
		CHInMemoryPersistenceController *persistenceController = [[CHInMemoryPersistenceController alloc] init];
		context = persistenceController.managedObjectContext;
	});

	afterEach(^{
		[context reset];
	});

	it(@"can be inserted into a managed object context", ^{
		CHEnvelope *envelope = [CHEnvelope insertNewObjectInContext:context];
		expect(envelope).toNot.beNil();
	});

	it(@"has required fields", ^{
		CHEnvelope *envelope = [CHEnvelope insertNewObjectInContext:context];
		envelope.budget = [[NSDecimalNumber alloc] initWithDouble:100.0];
		envelope.createdAt = [NSDate new];
		envelope.identifier = 1;

		// no name, expect an error
		NSError *error = nil;
		[context save:&error];
		expect(error).notTo.beNil();

		// set name, no error
		envelope.name = @"Groceries";
		error = nil;
		[context save:&error];
		expect(error).to.beNil();
	});
});

SpecEnd
