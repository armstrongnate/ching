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

	it(@"strips non numeric characters", ^{
		_textField.text = @"a";
		expect(_textField.text).to.equal(@"");
		_textField.text = @"abc123def.g h45ij";
		expect(_textField.text).to.equal(@"123.45");
	});
});

SpecEnd
