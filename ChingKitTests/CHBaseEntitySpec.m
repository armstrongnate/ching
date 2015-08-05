//
//  CHBaseEntitySpec.m
//  Ching
//
//  Created by Nate Armstrong on 8/4/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import Specta;
@import Expecta;
@import ChingKit;

SpecBegin(CHBaseEntitySpec)

describe(@"CHBaseEntity", ^{
	__block NSManagedObjectContext *_context;
	__block CHBaseEntity *_entity;
	beforeAll(^{
		CHInMemoryPersistenceController *persistenceController = [[CHInMemoryPersistenceController alloc] init];
		_context = persistenceController.managedObjectContext;
	});

	beforeEach(^{
        _entity = [CHBaseEntity insertNewObjectInContext:_context];
	});

	afterEach(^{
		[_context reset];
	});

	it(@"sets timestamps on create", ^{
		NSError *error;
		[_context save:&error];
		[_context refreshObject:_entity mergeChanges:YES];
		expect(_entity.createdAt).toNot.beNil();
		expect(_entity.changedAt).toNot.beNil();
		expect(error).to.beNil();
	});

	it(@"sets only changedAt on update", ^{
		// create it first
		NSError *error;
		[_context save:&error];
		[_context refreshObject:_entity mergeChanges:YES];

		// now update
		NSDate *createdAt = _entity.createdAt;
		NSDate *changedAt = [NSDate date];
		_entity.changedAt = changedAt;
		[_context save:&error];
		[_context refreshObject:_entity mergeChanges:YES];
		expect(_entity.createdAt).to.equal(createdAt);
		expect(_entity.changedAt).toNot.equal(changedAt);
	});

	it(@"has 'new' state", ^{
		expect([_entity isNewRecord]).to.beTruthy();
		NSError *error;
		[_context save:&error];
		[_context refreshObject:_entity mergeChanges:YES];
		expect([_entity isNewRecord]).to.beFalsy();
	});
});

SpecEnd
