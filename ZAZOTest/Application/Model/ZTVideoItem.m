//
//  ZTVideoItem.m
//  ZAZOTest
//
//  Created by Vitaly Cherevaty on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import "ZTVideoItem.h"
#import "ZTFileHelpers.h"

@implementation ZTVideoItem

+(ZTVideoItem*)itemWithIndex:(NSUInteger)index videoPath:(NSString*)videoPath thumbnailPath:(NSString*)thumbnailPath
{
    ZTVideoItem *item  = [[ZTVideoItem alloc] init];
    item.index = index;
    item.videoPath = videoPath;
    item.thumbnailPath = thumbnailPath;
    
    return item;
}


-(NSURL*)absoluteVideoPathURL
{
    NSURL* url = nil;
    if (self.videoPath) {
        url = [ZTFileHelpers absolutePathURLForFileName:self.videoPath];
    }
    
    return url;
}


-(NSURL*)absoluteThumbnailPathURL
{
    NSURL* url = nil;
    if (self.thumbnailPath) {
        url = [ZTFileHelpers absolutePathURLForFileName:self.thumbnailPath];
    }
    
    return url;
}


@end
