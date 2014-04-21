//
//  ISO8601DateFormatterValueTransformerTests.m
//  RestKit
//
//  Created by Blake Watters on 9/11/13.
//  Copyright (c) 2013 RestKit. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <XCTest/XCTest.h>
#define EXP_SHORTHAND
#import "Expecta.h"
#import "ISO8601DateFormatterValueTransformer.h"

@interface RKValueTransformers_ISO8601DateFormatterTests : XCTestCase
@end

@implementation RKValueTransformers_ISO8601DateFormatterTests

- (void)testValidationFromStringToDate
{
    ISO8601DateFormatter *valueTransformer = [ISO8601DateFormatter new];
    BOOL success = [valueTransformer validateTransformationFromClass:[NSString class] toClass:[NSDate class]];
    expect(success).to.beTruthy();
}

- (void)testValidationFromDateToString
{
    ISO8601DateFormatter *valueTransformer = [ISO8601DateFormatter new];
    BOOL success = [valueTransformer validateTransformationFromClass:[NSDate class] toClass:[NSString class]];
    expect(success).to.beTruthy();
}

- (void)testValidationFailure
{
    ISO8601DateFormatter *valueTransformer = [ISO8601DateFormatter new];
    BOOL success = [valueTransformer validateTransformationFromClass:[NSURL class] toClass:[NSString class]];
    expect(success).to.beFalsy();
}

- (void)testTransformationFromDateToString
{
    ISO8601DateFormatter *valueTransformer = [ISO8601DateFormatter new];
    valueTransformer.defaultTimeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    valueTransformer.includeTime = YES;
    id value = nil;
    NSError *error = nil;
    BOOL success = [valueTransformer transformValue:[NSDate dateWithTimeIntervalSince1970:0] toValue:&value ofClass:[NSString class] error:&error];
    expect(success).to.beTruthy();
    expect(value).to.beKindOf([NSString class]);
    expect(value).to.equal(@"1970-01-01T00:00:00Z");
}

- (void)testTransformationFromStringToDAte
{
    ISO8601DateFormatter *valueTransformer = [ISO8601DateFormatter new];
    valueTransformer.defaultTimeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    valueTransformer.includeTime = YES;
    id value = nil;
    NSError *error = nil;
    BOOL success = [valueTransformer transformValue:@"1970-01-01T00:00:00Z" toValue:&value ofClass:[NSDate class] error:&error];
    expect(success).to.beTruthy();
    expect(value).to.beKindOf([NSDate class]);
    expect([value description]).to.equal(@"1970-01-01 00:00:00 +0000");
}

- (void)testTransformationFailureWithUntransformableInputValue
{
    ISO8601DateFormatter *valueTransformer = [ISO8601DateFormatter new];
    id value = nil;
    NSError *error = nil;
    BOOL success = [valueTransformer transformValue:@[] toValue:&value ofClass:[NSString class] error:&error];
    expect(success).to.beFalsy();
    expect(value).to.beNil();
    expect(error).notTo.beNil();
    expect(error.domain).to.equal(RKValueTransformersErrorDomain);
    expect(error.code).to.equal(RKValueTransformationErrorUntransformableInputValue);
}

- (void)testTransformationFailureFailureWithInvalidInputValue
{
    ISO8601DateFormatter *valueTransformer = [ISO8601DateFormatter new];
    id value = nil;
    NSError *error = nil;
    BOOL success = [valueTransformer transformValue:@":*7vxck#sf#adsa" toValue:&value ofClass:[NSDate class] error:&error];
    expect(success).to.beFalsy();
    expect(value).to.beNil();
    expect(error).notTo.beNil();
    expect(error.domain).to.equal(RKValueTransformersErrorDomain);
    expect(error.code).to.equal(RKValueTransformationErrorTransformationFailed);
}

- (void)testTransformationFailureWithInvalidDestinationClass
{
    ISO8601DateFormatter *valueTransformer = [ISO8601DateFormatter new];
    id value = nil;
    NSError *error = nil;
    BOOL success = [valueTransformer transformValue:@"http://restkit.org" toValue:&value ofClass:[NSData class] error:&error];
    expect(success).to.beFalsy();
    expect(value).to.beNil();
    expect(error).notTo.beNil();
    expect(error.domain).to.equal(RKValueTransformersErrorDomain);
    expect(error.code).to.equal(RKValueTransformationErrorUnsupportedOutputClass);
}

@end
