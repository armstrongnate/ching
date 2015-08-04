//
//  EnvelopeViewController.h
//  Ching
//
//  Created by Nate Armstrong on 8/4/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import UIKit;
@import ChingKit;

@class SingleInputTableViewCell;

@interface EnvelopeViewController : UITableViewController

@property (nonatomic, strong) CHEnvelope *envelope;
@property (nonatomic, strong) NSManagedObjectContext *context;

- (SingleInputTableViewCell *)nameCell;
- (SingleInputTableViewCell *)budgetCell;

@end
