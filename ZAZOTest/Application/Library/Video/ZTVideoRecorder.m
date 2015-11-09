//
//  ZTVideoRecorder.m
//  ZAZOTest
//
//  Created by vc on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import "ZTVideoRecorder.h"
#import "ZTFileHelpers.h"

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ZTVideoRecorder()<AVCaptureFileOutputRecordingDelegate>

@property (nonatomic) AVCaptureSession *videoCaptureSession;
@property (nonatomic) AVCaptureMovieFileOutput *movieFileOutput;

@end

@implementation ZTVideoRecorder

-(instancetype)init
{
    self = [super init];
    if (self) {
//TEST
//        [self printAvailableDevices];
//TEST
    }

    return self;
}


-(void)printAvailableDevices
{

    NSLog(@"Available capture devices:");

    NSArray *devices = [AVCaptureDevice devices];

    for (AVCaptureDevice *device in devices) {

        NSLog(@"Device name: %@", [device localizedName]);

        if ([device hasMediaType:AVMediaTypeVideo]) {

            if ([device position] == AVCaptureDevicePositionBack) {
                NSLog(@"Device position : back");
            }
            else {
                NSLog(@"Device position : front");
            }
        }
    }
}

-(AVCaptureDevice*)findFrontCameraCaptureDevice
{
    AVCaptureDevice *ret = nil;
    NSArray *devices = [AVCaptureDevice devices];

    for (AVCaptureDevice *device in devices) {
        if ([device hasMediaType:AVMediaTypeVideo] && [device position] == AVCaptureDevicePositionFront) {
            ret = device;
        }
    }

    return ret;
}

+(UIImage *)getThumbnailFromVideoFileURL:(NSURL*)fileURL
{
    UIImage *thumbnailImage = nil;
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
    if ([[asset tracksWithMediaType:AVMediaTypeVideo] count] > 0) {
        AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
        imageGenerator.appliesPreferredTrackTransform = TRUE;

        CMTime thumbnailTime = CMTimeMakeWithSeconds(0.0, 600);
        NSError *error;
        CMTime actualTime;

        CGImageRef image = [imageGenerator copyCGImageAtTime:thumbnailTime actualTime:&actualTime error:&error];

        if (image != NULL) {

            //NSString *actualTimeString = (NSString *)CFBridgingRelease(CMTimeCopyDescription(NULL, actualTime));
            //NSString *requestedTimeString = (NSString *)CFBridgingRelease(CMTimeCopyDescription(NULL, midpoint));
            //NSLog(@"Got halfWayImage: Asked for %@, got %@", requestedTimeString, actualTimeString);

            thumbnailImage = [[UIImage alloc] initWithCGImage:image];
            CGImageRelease(image);
        }
    }

    return thumbnailImage;
}


+(BOOL)saveThumbnailWithFileURL:(NSURL*)fileURL fromVideoURL:(NSURL*)videoURL
{
    [ZTFileHelpers deleteFileIfAlreadyExist:fileURL];

    BOOL ret = NO;
    UIImage *image = [self getThumbnailFromVideoFileURL:videoURL];
    if (image) {
        NSData *data = UIImagePNGRepresentation(image);
        NSError *error = nil;
        BOOL res = [data writeToURL:fileURL options:0 error:&error];
        if (res) {
            ret = YES;
        } else {
            NSLog(@"ERROR:%s: Error saving file - %@", __func__, error);
        }
    }

    return ret;
}


-(void)setupCaptureSessionWithPreviewView:(UIView*)previewView
{
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord
                                           error:&error];

    if(!error) {
        [[AVAudioSession sharedInstance] setActive:YES error:&error];
        if(error) NSLog(@"ERROR:%s: Error while activating AudioSession : %@", __func__, error);
    } else {
        NSLog(@"ERROR:%s: Error while setting category of AudioSession : %@", __func__, error);
    }


    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    session.sessionPreset = AVCaptureSessionPresetMedium;
    self.videoCaptureSession = session;


    //video input
    AVCaptureDevice *videoDevice = [self findFrontCameraCaptureDevice];

    if (!videoDevice) {
        videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }

    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    if (!videoInput) {
        NSLog(@"ERROR:%s: %@", __func__, error);
        return;
    }


    //audio input
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:&error];
    if (!audioInput) {
        NSLog(@"ERROR:%s: %@", __func__, error);
        return;
    }

    CALayer *viewLayer = [previewView layer];
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    captureVideoPreviewLayer.frame = previewView.bounds;
    [viewLayer addSublayer:captureVideoPreviewLayer];


    AVCaptureMovieFileOutput *movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];

    Float64 totalSeconds = 60;			//Total seconds
    int32_t preferredTimeScale = 30;	//Frames per second
    CMTime maxDuration = CMTimeMakeWithSeconds(totalSeconds, preferredTimeScale);
    movieFileOutput.maxRecordedDuration = maxDuration;
    movieFileOutput.minFreeDiskSpaceLimit = 1024 * 1024;


    AVCaptureConnection *captureConnection = [movieFileOutput connectionWithMediaType:AVMediaTypeVideo];

    if ([captureConnection isVideoOrientationSupported]) {
        AVCaptureVideoOrientation orientation = AVCaptureVideoOrientationPortrait;
        [captureConnection setVideoOrientation:orientation];
    }

    self.movieFileOutput = movieFileOutput;

    [self.videoCaptureSession beginConfiguration];
    [self.videoCaptureSession addInput:videoInput];
    [self.videoCaptureSession addInput:audioInput];
    [self.videoCaptureSession addOutput:movieFileOutput];
    [self.videoCaptureSession commitConfiguration];

    [session startRunning];
}

-(void)startRecordingToFileURL:(NSURL *)fileURL
{
    [ZTFileHelpers deleteFileIfAlreadyExist:fileURL];
    [self.movieFileOutput startRecordingToOutputFileURL:fileURL recordingDelegate:self];
}

-(void)stopRecording
{
    [self.movieFileOutput stopRecording];
}

#pragma mark - AVCaptureFileOutputRecordingDelegate

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections
{

}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    BOOL recordedSuccessfully = YES;
    if ([error code] != noErr) {
        // A problem occurred: Find out if the recording was successful.
        id value = [[error userInfo] objectForKey:AVErrorRecordingSuccessfullyFinishedKey];
        if (value) {
            recordedSuccessfully = [value boolValue];
        }

        NSLog(@"ERROR: %s: %@", __func__, error);

    } else {

        //NSLog(@"Recorded sucessfully!");
        recordedSuccessfully = YES;
    }

    if (recordedSuccessfully) {
        [self.delegate videoRecorder:self didFinishRecordingToOutputFileAtURL:outputFileURL error:nil];
    } else {
        [self.delegate videoRecorder:self didFinishRecordingToOutputFileAtURL:outputFileURL error:error];
    }
}

@end
