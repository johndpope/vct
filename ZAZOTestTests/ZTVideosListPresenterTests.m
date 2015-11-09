//
//  ZTVideosListPresenterTests.m
//  ZAZOTest
//
//  Created by vc on 11/2/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ZTVideosListPresenter.h"
#import "ZTVideoRecorder.h"

#import <OCMock/OCMock.h>

@interface ZTVideosListPresenterTests : XCTestCase

@property (nonatomic, strong) ZTVideosListPresenter *presenter;
@property (nonatomic, strong) id ui;
@property (nonatomic, strong) id wireframe;
@property (nonatomic, strong) id interactor;

@end

@implementation ZTVideosListPresenterTests

- (void)setUp {
    [super setUp];

    self.presenter = [ZTVideosListPresenter new];

    self.ui = [OCMockObject mockForProtocol:@protocol(ZTVideosListViewInterface)];
    self.wireframe = [OCMockObject mockForClass:[ZTVideosListWireframe class]];
    self.interactor = [OCMockObject mockForProtocol:@protocol(ZTVideosListInteractorInput)];


    self.presenter.userInterface = self.ui;
    self.presenter.wireframe = self.wireframe;
    self.presenter.interactor = self.interactor;
}

- (void)tearDown {

    [self.ui verify];
    [self.wireframe verify];
    [self.interactor verify];

    [super tearDown];
}

- (void)testStartVideoRecording {
    [[self.ui expect] startRecordingToFileURL:OCMOCK_ANY];
    [self.presenter startVideoRecordingAtIndex:0];
}

- (void)testStopVideoRecording {
    [[self.ui expect] stopRecording];
    [self.presenter stopVideoRecordingAtIndex:0];
}

- (void)testVideoRecordingSucceded {

    NSUInteger recordingItemIndex = 0;

    [[self.interactor expect] updateVideoItemVideoPath:OCMOCK_ANY thumbnailPath:OCMOCK_ANY atIndex:recordingItemIndex];
    [self.presenter setValue:[NSNumber numberWithUnsignedInteger:recordingItemIndex] forKey:@"recordingItemIndex"];

    id classMock = OCMClassMock([ZTVideoRecorder class]);
    OCMStub([classMock saveThumbnailWithFileURL:OCMOCK_ANY fromVideoURL:OCMOCK_ANY]).andReturn(YES);

    [self.presenter videoRecordingSuccededWithVideoFileURL:OCMOCK_ANY];
}

- (void)testVideoRecordingFailed {

}


@end
