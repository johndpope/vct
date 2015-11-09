//
//  ZTVideoItemTests.m
//  ZAZOTest
//
//  Created by vc on 11/2/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZTVideoItem.h"

@interface ZTVideoItemTests : XCTestCase

@end

@implementation ZTVideoItemTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testVidoItemCreation {

    NSUInteger index = 0;
    NSString *videoPath = @"some path";
    NSString *thumbnailPath = @"some path";

    ZTVideoItem *item = [ZTVideoItem itemWithIndex:index videoPath:videoPath thumbnailPath:thumbnailPath];

    XCTAssertEqual(item.index, index);
    XCTAssertTrue([item.videoPath isEqualToString:item.videoPath]);
    XCTAssertTrue([item.thumbnailPath isEqualToString:item.thumbnailPath]);
}


@end
