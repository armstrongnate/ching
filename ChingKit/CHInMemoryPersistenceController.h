//
//  CHInMemoryPersistenceController.h
//  Ching
//
//  Created by Nate Armstrong on 8/2/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import CoreData;

@interface CHInMemoryPersistenceController : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
