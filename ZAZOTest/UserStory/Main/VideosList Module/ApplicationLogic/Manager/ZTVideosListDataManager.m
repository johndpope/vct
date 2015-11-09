//
//  ZTVideosListDataManager.m
//  ZAZOTest
//
//  Created by vc on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import "ZTVideosListDataManager.h"
#import "ZTManagedVideoItem.h"

@interface ZTVideosListDataManager()

@end

@implementation ZTVideosListDataManager

-(NSArray*)videoItems
{
    NSArray *managedItems = [self.dataStore fetchAllEntries];

    if (!managedItems) {
        return @[];
    }

    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (ZTManagedVideoItem *managedItem in managedItems) {

        ZTVideoItem *item = [ZTVideoItem itemWithIndex:[managedItem.index unsignedIntegerValue]
                                          videoPath:managedItem.videoPath
                                 thumbnailPath:managedItem.thumbnailPath];
        [items addObject:item];
    }

    return items;
}

-(void)updateVideoItem:(ZTVideoItem*)videoItem
{
    ZTManagedVideoItem *managedVideoItem = [self.dataStore fetchEntryWithIndex:videoItem.index];
    if (!managedVideoItem) {
        managedVideoItem = [self.dataStore newVideoItem];
        managedVideoItem.index = [NSNumber numberWithUnsignedInteger:videoItem.index];

    }
    managedVideoItem.videoPath = videoItem.videoPath;
    managedVideoItem.thumbnailPath = videoItem.thumbnailPath;
    [self.dataStore save];
}

- (void)addNewVideoItem:(ZTVideoItem *)item
{
    ZTManagedVideoItem *newEntry = [self.dataStore newVideoItem];
    newEntry.index = [NSNumber numberWithUnsignedInteger:item.index];
    newEntry.videoPath = item.videoPath;
    newEntry.thumbnailPath = item.thumbnailPath;
    [self.dataStore save];
}


@end
