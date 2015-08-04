//
//  CHEnvelope.h
//  Ching
//
//  Created by Nate Armstrong on 8/3/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import CoreData;

#import "CHBaseEntity.h"

@interface CHEnvelope : CHBaseEntity

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDecimalNumber *budget;

+ (instancetype)insertNewObjectInContext:(NSManagedObjectContext *)context;
+ (NSString *)entityName;

- (void)setBudgetWithDouble:(double)budget;

@end
