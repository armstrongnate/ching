//
//  CHInMemoryPersistenceController.m
//  Ching
//
//  Created by Nate Armstrong on 8/2/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "CHInMemoryPersistenceController.h"

@interface CHInMemoryPersistenceController()

- (void)initializeCoreData;

@end

@implementation CHInMemoryPersistenceController

- (instancetype)init
{
	if (!(self = [super init])) return nil;
	[self initializeCoreData];
	return self;
}

- (void)initializeCoreData
{
	NSURL *modelURL = [[NSBundle bundleForClass:[CHInMemoryPersistenceController class]] URLForResource:@"DataModel" withExtension:@"momd"];
	NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
	NSError *error = nil;
	if (![coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:&error])
	{
		NSLog(@"Error: %@", error);
	}
	[self setManagedObjectContext:[[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType]];
	self.managedObjectContext.persistentStoreCoordinator = coordinator;
}

@end
