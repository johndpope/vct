//
//  ZTVideoRecorder.h
//  ZAZOTest
//
//  Created by vc on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZTVideoRecorder;

@protocol ZTVideoRecorderDelegate <NSObject>

- (void)videoRecorder:(ZTVideoRecorder*)recorder didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL error:(NSError *)error;

@end

@interface ZTVideoRecorder : NSObject

@property (nonatomic, weak) id<ZTVideoRecorderDelegate> delegate;

-(void)setupCaptureSessionWithPreviewView:(UIView*)previewView;
-(void)startRecordingToFileURL:(NSURL *)fileURL;
-(void)stopRecording;

+(BOOL)saveThumbnailWithFileURL:(NSURL*)fileURL fromVideoURL:(NSURL*)videoURL;

@end
