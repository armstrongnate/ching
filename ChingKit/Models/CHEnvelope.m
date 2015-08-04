//
//  CHEnvelope.m
//  Ching
//
//  Created by Nate Armstrong on 8/3/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "CHEnvelope.h"

@implementation CHEnvelope

@dynamic name;
@dynamic budget;

+ (NSString *)entityName
{
	return @"CHEnvelope";
}

+ (instancetype)insertNewObjectInContext:(NSManagedObjectContext *)context
{
	return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

- (void)setBudgetWithDouble:(double)budget
{
	self.budget = [[NSDecimalNumber alloc] initWithDouble:budget];
}

@end
