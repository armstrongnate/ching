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

+ (instancetype)insertNewObjectInContext:(NSManagedObjectContext *)context;
+ (NSString *)entityName;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDecimalNumber *budget;

@end
