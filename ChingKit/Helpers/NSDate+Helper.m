//
//  NSDate+Helpers.m
//  Ching
//
//  Created by Nate Armstrong on 8/10/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "NSDate+Helper.h"

static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);


@implementation NSDate (Helper)

- (NSDate *)dateAtBeginningOfMonth
{
	NSDateComponents *comps = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
	[comps setDay:1];
	return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

- (NSDate *)dateAtBeginningOfNextMonth
{
	NSDateComponents *oneMonth = [[NSDateComponents alloc] init];
	[oneMonth setMonth:1];
	return [[NSCalendar currentCalendar] dateByAddingComponents:oneMonth toDate:[self dateAtBeginningOfMonth] options:0];
}

@end
