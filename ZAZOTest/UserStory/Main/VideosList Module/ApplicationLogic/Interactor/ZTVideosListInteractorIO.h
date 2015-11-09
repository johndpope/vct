//
//  ZTVideosListInteractorIO.h
//  ZAZOTest
//
//  Created by vc on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

@class ZTVideoItem;

@protocol ZTVideosListInteractorInput <NSObject>

- (NSArray*)videoItems;
- (void)loadVideosList;
- (void)updateVideoItemVideoPath:(NSString*)videoPath thumbnailPath:(NSString*)thumbnailPath atIndex:(NSUInteger)index;

@end


@protocol ZTVideosListInteractorOutput <NSObject>

- (void)videosListLoaded:(NSArray*)videos;
- (void)videoUpdatedSuccessfully:(ZTVideoItem*)item;

@end