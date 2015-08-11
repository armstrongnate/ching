//
//  CHTransaction.h
//  Ching
//
//  Created by Nate Armstrong on 8/10/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import CoreData;

#import "CHBaseEntity.h"

@class CHEnvelope;

@interface CHTransaction : CHBaseEntity

@property (nonatomic, retain) NSDecimalNumber *amount;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) CHEnvelope *envelope;

@end
