//
//  ZTVideoItemView.m
//  ZAZOTest
//
//  Created by Vitaly Cherevaty on 10/29/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import "ZTVideoItemView.h"
#import <AVFoundation/AVFoundation.h>

static const NSString *ItemStatusContext;
static NSString *const TracksKey = @"tracks";
static NSString *const StatusKeyPath = @"status";

@interface ZTVideoItemView()

@property (nonatomic) AVPlayerItem *playerItem;
@property (nonatomic) UIImageView *thumbnailImageView;
@property (nonatomic) BOOL isPlaying;

@end

@implementation ZTVideoItemView

-(void)awakeFromNib
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tapGestureRecognizer];
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self addGestureRecognizer:longPressGestureRecognizer];
    
    
    self.thumbnailImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.thumbnailImageView];
}


-(void)handleTap:(UIGestureRecognizer*)recognizer
{
   // NSLog(@"%s", __func__);
    
    if (self.isPlaying) {
        [self.eventHandler stopVideoAtIndex:self.index];
    } else {
        [self.eventHandler playVideoAtIndex:self.index];
    }
}

-(void)handleLongPress:(UIGestureRecognizer*)recognizer
{
    //NSLog(@"%s", __func__);
    
    if(recognizer.state == UIGestureRecognizerStateBegan){
        [self.eventHandler startVideoRecordingAtIndex:self.index];
    } else if(recognizer.state == UIGestureRecognizerStateEnded){
        [self.eventHandler stopVideoRecordingAtIndex:self.index];
    }
}

-(void)setup
{
    if (self.videoFileURL) {
        [self loadVideoFromURL:self.videoFileURL];
    }
    
    if (self.thumbnailImageFileURL) {
        self.thumbnailImageView.image = [UIImage imageWithContentsOfFile:[self.thumbnailImageFileURL path]];
    }
}

-(void)play
{
    self.thumbnailImageView.hidden = YES;
    [self.player play];
    self.isPlaying = YES;
}

-(void)stop
{
    self.thumbnailImageView.hidden = NO;
    [self.player pause];
    self.isPlaying = NO;

}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}


- (AVPlayer*)player {
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}



-(void)videoAssetLoaded:(AVURLAsset *)asset
{
    NSError *error;
    AVKeyValueStatus status = [asset statusOfValueForKey:TracksKey error:&error];
    
    if (status == AVKeyValueStatusLoaded) {
        
        //NSLog(@"Loaded!");
        
        if (self.playerItem) {
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:AVPlayerItemDidPlayToEndTimeNotification
                                                          object:self.playerItem];
            
            [self.playerItem removeObserver:self forKeyPath:StatusKeyPath context:&ItemStatusContext];
            self.playerItem = nil;
            
        }
        
        self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
        // ensure that this is done before the playerItem is associated with the player
        [self.playerItem addObserver:self forKeyPath:StatusKeyPath
                             options:NSKeyValueObservingOptionInitial context:&ItemStatusContext];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:self.playerItem];
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        self.isPlaying = NO;

    }
    else {

        NSLog(@"ERROR:%s: The asset's tracks were not loaded:\n%@", __func__, [error localizedDescription]);
    }
    
}


-(void)loadVideoFromURL:(NSURL*)fileURL
{
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
    
    __weak typeof(self) weakSelf = self;
    
    [asset loadValuesAsynchronouslyForKeys:@[TracksKey] completionHandler:
     ^{
         
         // Completion handler block.
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            [weakSelf videoAssetLoaded:asset];
                        });
     }];
}

-(void)playerItemDidReachEnd:(NSNotification*)notification
{
    [self.player seekToTime:kCMTimeZero];
    self.thumbnailImageView.hidden = NO;
    self.isPlaying = NO;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    
    if (context == &ItemStatusContext) {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           //[self syncUI];
                       });
        return;
    }
    [super observeValueForKeyPath:keyPath ofObject:object
                           change:change context:context];
    return;
}

@end
