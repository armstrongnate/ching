//
//  TransactionViewController.h
//  Ching
//
//  Created by Nate Armstrong on 8/10/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import UIKit;
@import ChingKit;

#import "SingleInputTableViewCell.h"

@interface TransactionViewController : UITableViewController

@property (nonatomic, strong) CHTransaction *transaction;
@property (nonatomic, strong) IBOutlet SingleInputTableViewCell *amountCell;
@property (nonatomic, strong) IBOutlet SingleInputTableViewCell *titleCell;

- (IBAction)saveButtonTapped:(id)sender;

@end
