//
//  SingleInputTableViewCell.h
//  Ching
//
//  Created by Nate Armstrong on 8/3/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import UIKit;

@interface SingleInputTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic) IBInspectable double dx;
@property (nonatomic, strong) IBInspectable NSString *placeholder;

@end
