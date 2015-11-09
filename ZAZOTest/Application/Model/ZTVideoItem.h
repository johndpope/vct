//
//  ZTVideoItem.h
//  ZAZOTest
//
//  Created by vc on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTVideoItem : NSObject

@property NSUInteger index;
@property NSString *videoPath;
@property NSString *thumbnailPath;

-(NSURL*)absoluteVideoPathURL;
-(NSURL*)absoluteThumbnailPathURL;

+(ZTVideoItem*)itemWithIndex:(NSUInteger)index videoPath:(NSString*)videoPath thumbnailPath:(NSString*)thumbnailPath;

@end
