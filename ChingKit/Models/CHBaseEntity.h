//
//  BaseEntity.h
//  Ching
//
//  Created by Nate Armstrong on 8/3/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import CoreData;

@interface CHBaseEntity : NSManagedObject

@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *changedAt;

+ (instancetype)insertNewObjectInContext:(NSManagedObjectContext *)context;
+ (NSString *)entityName;

- (BOOL)isNewRecord;

@end
