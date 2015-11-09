//
//  ZTVideosListModuleInterface.h
//  ZAZOTest
//
//  Created by Vitaly Cherevaty on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZTVideosListModuleInterface <NSObject>

- (void)updateView;

- (void)startVideoRecordingAtIndex:(NSUInteger)index;
- (void)stopVideoRecordingAtIndex:(NSUInteger)index;
- (void)playVideoAtIndex:(NSUInteger)index;
- (void)stopVideoAtIndex:(NSUInteger)index;

- (void)videoRecordingSuccededWithVideoFileURL:(NSURL*)videoFileURL;
- (void)videoRecordingFailedWithError:(NSError*)error;

@end
