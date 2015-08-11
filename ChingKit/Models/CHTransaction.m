//
//  CHTransaction.m
//  Ching
//
//  Created by Nate Armstrong on 8/10/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "CHTransaction.h"
#import "CHEnvelope.h"


@implementation CHTransaction

@dynamic amount;
@dynamic title;
@dynamic envelope;

+ (NSString *)entityName
{
	return @"CHTransaction";
}

@end
