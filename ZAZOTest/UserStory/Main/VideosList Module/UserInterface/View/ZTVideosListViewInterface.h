//
//  ZTVideosListViewInterface.h
//  ZAZOTest
//
//  Created by vc on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZTVideoItem;

@protocol ZTVideosListViewInterface <NSObject>

- (void)updateAllVideoItems:(NSArray*)videoItems;
- (void)updateVideoItemAtIndex:(NSUInteger)index videoItem:(ZTVideoItem*)videoItem;

-(void)startRecordingToFileURL:(NSURL *)fileURL;
-(void)stopRecording;

- (void)playVideoAtIndex:(NSUInteger)index;
- (void)stopVideoAtIndex:(NSUInteger)index;

@end
