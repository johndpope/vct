//
//  ZTVideosListVC.m
//  ZAZOTest
//
//  Created by vc on 10/29/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import "ZTVideosListVC.h"
#import "ZTVideoItemView.h"
#import "ZTVideoPreviewView.h"
#import "ZTVideoItem.h"
#import "ZTVideosListModuleConstants.h"
#import "ZTVideoRecorder.h"
#import "ZTFileHelpers.h"

@interface ZTVideosListVC ()<ZTVideoRecorderDelegate>

@property (nonatomic, weak) IBOutlet ZTVideoItemView *videoItemView0;
@property (nonatomic, weak) IBOutlet ZTVideoItemView *videoItemView1;
@property (nonatomic, weak) IBOutlet ZTVideoItemView *videoItemView2;
@property (nonatomic, weak) IBOutlet ZTVideoItemView *videoItemView3;
@property (nonatomic, weak) IBOutlet ZTVideoItemView *videoItemView4;
@property (nonatomic, weak) IBOutlet ZTVideoItemView *videoItemView5;
@property (nonatomic, weak) IBOutlet ZTVideoItemView *videoItemView6;
@property (nonatomic, weak) IBOutlet ZTVideoItemView *videoItemView7;

@property (nonatomic, weak) IBOutlet ZTVideoPreviewView *videoPreviewView;
@property (nonatomic, weak) IBOutlet UILabel *videoPreviewRecordingLabel;

@property (nonatomic) NSArray *videoItemViews;
@property (nonatomic) ZTVideoRecorder *videoRecorder;

@end

@implementation ZTVideosListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"ZAZO Test";

    self.videoItemViews = @[self.videoItemView0,
                        self.videoItemView1,
                        self.videoItemView2,
                        self.videoItemView3,
                        self.videoItemView4,
                        self.videoItemView5,
                        self.videoItemView6,
                        self.videoItemView7];

    NSAssert(self.videoItemViews.count == ZTVideoItemsCount, @"Video views count have to be equal to ZTVideoItemsCount");

    NSUInteger i = 0;
    for (ZTVideoItemView *view in self.videoItemViews){
        view.index = i;
        view.eventHandler = self.eventHandler;
        [view setup];
        i++;
    }

    self.videoRecorder = [[ZTVideoRecorder alloc] init];
    self.videoRecorder.delegate = self;
    [self.videoRecorder setupCaptureSessionWithPreviewView:self.videoPreviewView];

    [self.eventHandler updateView];

    [self hideRecordingIndicator];
}

- (void)showRecordingIndicator
{
    self.videoPreviewRecordingLabel.hidden = NO;
}

- (void)hideRecordingIndicator
{
    self.videoPreviewRecordingLabel.hidden = YES;
}

- (void)updateVideoItemAtIndex:(NSUInteger)index videoItem:(ZTVideoItem*)videoItem
{
    ZTVideoItemView *itemView = self.videoItemViews[index];

    itemView.videoFileURL = [videoItem absoluteVideoPathURL];
    itemView.thumbnailImageFileURL = [videoItem absoluteThumbnailPathURL];
    [itemView setup];
}

- (void)updateAllVideoItems:(NSArray*)videoItems
{
    for (NSUInteger i = 0; i < videoItems.count; i++){
        [self updateVideoItemAtIndex:i videoItem:videoItems[i]];
    }
}

-(void)startRecordingToFileURL:(NSURL *)fileURL
{
    [self showRecordingIndicator];
    [self.videoRecorder startRecordingToFileURL:fileURL];
}

-(void)stopRecording
{
    [self hideRecordingIndicator];
    [self.videoRecorder stopRecording];
}

- (void)playVideoAtIndex:(NSUInteger)index
{
    ZTVideoItemView *itemView = self.videoItemViews[index];
    [itemView play];
}

- (void)stopVideoAtIndex:(NSUInteger)index
{
    ZTVideoItemView *itemView = self.videoItemViews[index];
    [itemView stop];
}

#pragma mark - ZTVideoRecorderDelegate

- (void)videoRecorder:(ZTVideoRecorder*)recorder didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL error:(NSError *)error
{
    if (!error) {
        [self.eventHandler videoRecordingSuccededWithVideoFileURL:outputFileURL];

    } else {
        [self.eventHandler videoRecordingFailedWithError:error];
    }

    [self hideRecordingIndicator];
}

@end
