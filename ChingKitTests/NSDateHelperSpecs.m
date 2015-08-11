//
//  NSDateHelperSpecs.m
//  Ching
//
//  Created by Nate Armstrong on 8/10/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import Specta;
@import Expecta;
@import ChingKit;

SpecBegin(NSDateHelperSpec)

describe(@"NSDateHelper", ^{
	__block NSDateFormatter *_formatter;
	beforeAll(^{
		_formatter = [[NSDateFormatter alloc] init];
		_formatter.dateFormat = @"yyyy-MM-dd";
	});

	it(@"determines first of the month", ^{
		NSDate *date = [_formatter dateFromString:@"2015-08-10"];
		NSDate *expected = [_formatter dateFromString:@"2015-08-01"];
		expect([date dateAtBeginningOfMonth]).to.equal(expected);
	});

	it(@"determines first of the next month", ^{
		NSDate *date = [_formatter dateFromString:@"2015-08-10"];
		NSDate *expected = [_formatter dateFromString:@"2015-09-01"];
		expect([date dateAtBeginningOfNextMonth]).to.equal(expected);
	});
});

SpecEnd
