//
//  ZTVideosListInteractorTests.m
//  ZAZOTest
//
//  Created by vc on 11/2/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZTVideosListInteractor.h"
#import "ZTVideosListDataManager.h"
#import "ZTVideosListPresenter.h"
#import "ZTVideosListInteractorIO.h"

#import <OCMock/OCMock.h>

@interface ZTVideosListInteractorTests : XCTestCase

@property (nonatomic, strong) ZTVideosListInteractor *interactor;
@property (nonatomic, strong) id dataManager;
@property (nonatomic, strong) id output;

@end

@implementation ZTVideosListInteractorTests

- (void)setUp {
    [super setUp];

    self.dataManager = [OCMockObject mockForClass:[ZTVideosListDataManager class]];
    self.output = [OCMockObject mockForProtocol:@protocol(ZTVideosListInteractorOutput)];

    self.interactor = [ZTVideosListInteractor new];
    self.interactor.dataManager = self.dataManager;
    self.interactor.output = self.output;
}

- (void)tearDown {

    [self.dataManager verify];
    [self.output verify];

    [super tearDown];
}

- (void)testGetVideoItems {

    [[self.dataManager expect] videoItems];
    [self.interactor videoItems];
}

- (void)testUpdateVideoItem {

    [[self.output expect] videoUpdatedSuccessfully:OCMOCK_ANY];
    [[self.dataManager expect] updateVideoItem:OCMOCK_ANY];
    [[self.dataManager expect] videoItems];

    [self.interactor updateVideoItemVideoPath:@"test" thumbnailPath:@"test" atIndex:0];
}

@end
