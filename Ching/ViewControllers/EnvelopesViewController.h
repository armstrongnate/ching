//
//  EnvelopesViewController.h
//  Ching
//
//  Created by Nate Armstrong on 8/2/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import UIKit;
@import CoreData;

#import "CoreDataTableViewController.h"

@interface EnvelopesViewController : CoreDataTableViewController

@property (nonatomic, strong) NSManagedObjectContext *context;

@end
