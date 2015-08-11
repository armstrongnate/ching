//
//  BaseEntity.m
//  Ching
//
//  Created by Nate Armstrong on 8/3/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import ObjectiveC;

#import "CHBaseEntity.h"

@implementation CHBaseEntity

@dynamic changedAt;
@dynamic createdAt;

+ (NSString *)entityName
{
	return @"CHBaseEntity";
}

+ (instancetype)insertNewObjectInContext:(NSManagedObjectContext *)context
{
	return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

+ (void)load {
	[[NSNotificationCenter defaultCenter] addObserver: (id)[self class]
											 selector: @selector(objectContextWillSave:)
												 name: NSManagedObjectContextWillSaveNotification
											   object: nil];
}

+ (void)objectContextWillSave:(NSNotification*) notification {
	NSManagedObjectContext* context = [notification object];
	NSPredicate* predicate = [NSPredicate predicateWithFormat: @"self isKindOfClass: %@", [self class]];

	// createdAt
	NSSet *insertable = [context.insertedObjects filteredSetUsingPredicate:predicate];
	[insertable makeObjectsPerformSelector:@selector(setCreatedAt:) withObject:[NSDate date]];

	// changedAt
	NSSet* allModified = [context.insertedObjects setByAddingObjectsFromSet: context.updatedObjects];
	NSSet* modifiable = [allModified filteredSetUsingPredicate: predicate];
	[modifiable makeObjectsPerformSelector: @selector(setChangedAt:) withObject: [NSDate date]];
}

- (BOOL)isNewRecord
{
	return self.createdAt == nil;
}

@end
