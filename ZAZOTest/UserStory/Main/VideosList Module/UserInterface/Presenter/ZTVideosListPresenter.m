//
//  ZTVideosListPresenter.m
//  ZAZOTest
//
//  Created by vc on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import "ZTVideosListPresenter.h"
#import "ZTVideoItem.h"
#import "ZTFileHelpers.h"
#import "ZTVideoRecorder.h"

@interface ZTVideosListPresenter()

@property (nonatomic) BOOL isRecording;
@property (nonatomic) NSUInteger recordingItemIndex;

@end

@implementation ZTVideosListPresenter


- (void)configurePresenterWithUserInterface:(UIViewController<ZTVideosListViewInterface>*)userInterface
{
    self.userInterface = userInterface;
    [self.interactor loadVideosList];
}

- (void)updateView
{
    NSArray *videoItems = [self.interactor videoItems];
    [self.userInterface updateAllVideoItems:videoItems];
}

- (void)videosListLoaded:(NSArray*)videoItems
{
    [self.userInterface updateAllVideoItems:videoItems];
}

- (void)videoUpdatedSuccessfully:(ZTVideoItem*)item
{
    [self.userInterface updateVideoItemAtIndex:item.index videoItem:item];
}

- (void)startVideoRecordingAtIndex:(NSUInteger)index
{
    NSURL *fileURL = [ZTFileHelpers absolutePathURLForFileName:[ZTFileHelpers fileNameForVideoAtIndex:index]];

    [self.userInterface startRecordingToFileURL:fileURL];
    self.isRecording = YES;
    self.recordingItemIndex = index;
}

- (void)stopVideoRecordingAtIndex:(NSUInteger)index
{
    [self.userInterface stopRecording];
}

- (void)playVideoAtIndex:(NSUInteger)index
{
    [self.userInterface playVideoAtIndex:index];
}

- (void)stopVideoAtIndex:(NSUInteger)index
{
    [self.userInterface stopVideoAtIndex:index];
}

- (void)videoRecordingSuccededWithVideoFileURL:(NSURL*)videoFileURL
{
    NSString *thumbnailPath = [ZTFileHelpers fileNameForThumbnailAtIndex:self.recordingItemIndex];
    NSURL *thumbnailURL = [ZTFileHelpers absolutePathURLForFileName:thumbnailPath];

    [ZTVideoRecorder saveThumbnailWithFileURL:thumbnailURL fromVideoURL:videoFileURL];

    NSString *videoPath = [ZTFileHelpers fileNameForVideoAtIndex:self.recordingItemIndex];

    [self.interactor updateVideoItemVideoPath:videoPath thumbnailPath:thumbnailPath atIndex:self.recordingItemIndex];
    self.isRecording = NO;
}

- (void)videoRecordingFailedWithError:(NSError*)error
{
    self.isRecording = NO;
}

@end
