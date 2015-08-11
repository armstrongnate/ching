//
//  TransactionsViewController.h
//  Ching
//
//  Created by Nate Armstrong on 8/9/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import ChingKit;

#import "CoreDataTableViewController.h"

@interface TransactionsViewController : CoreDataTableViewController

@property (nonatomic, strong) CHEnvelope *envelope;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *addButton;

- (IBAction)addTransactionButtonTapped:(id)sender;
- (IBAction)unwindFromTransactionForm:(UIStoryboardSegue *)segue;

@end
