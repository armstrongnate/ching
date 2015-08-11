//
//  CHNumberTextFieldDelegate.m
//  Ching
//
//  Created by Nate Armstrong on 8/4/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import Specta;
@import Expecta;
@import ChingKit;

#import "OCMock.h"

SpecBegin(CHNumberTextFieldDelegateSpec)

describe(@"CHNumberTextFieldDelegate", ^{
	__block UITextField *_textField;
	__block CHNumberTextFieldDelegate *_delegate;
	beforeAll(^{
		_textField = [[UITextField alloc] init];
		_delegate = [[CHNumberTextFieldDelegate alloc] init];
		[_textField addObserver:_delegate forKeyPath:@"text" options:0 context:nil];
	});

	it(@"observes programmatic text changes", ^{
		id delegateMock = [OCMockObject partialMockForObject:_delegate];
		[[delegateMock expect] observeValueForKeyPath:@"text" ofObject:[OCMArg any] change:[OCMArg any] context:nil];
		_textField.text = @"1";
		[delegateMock verify];
	});

	it(@"makes sure text is a number", ^{
		_textField.text = @"abc123";
		expect(_textField.text).to.equal(@"");

		_textField.text = @"192.168.1.1";
		expect(_textField.text).to.equal(@"192.168");

		_textField.text = @"192.168.";
		expect(_textField.text).to.equal(@"192.168");

		_textField.text = @"100abc.123";
		expect(_textField.text).to.equal(@"100.123");

		_textField.text = @"100.01abc.123";
		expect(_textField.text).to.equal(@"100.01");

		_textField.text = @"100.";
		expect(_textField.text).to.equal(@"100.");

		_textField.text = @"100.0";
		expect(_textField.text).to.equal(@"100.0");

		_textField.text = @"100.010";
		expect(_textField.text).to.equal(@"100.01");

		_textField.text = @"100.000";
		expect(_textField.text).to.equal(@"100.0");
	});
});

SpecEnd
