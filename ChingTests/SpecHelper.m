//
//  SpecHelper.m
//  Ching
//
//  Created by Nate Armstrong on 8/4/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "SpecHelper.h"

@implementation SpecHelper

- (CHInMemoryPersistenceController *)persistenceController
{
	if (!_persistenceController)
	{
		_persistenceController = [[CHInMemoryPersistenceController alloc] init];
	}
	return _persistenceController;
}

@end
