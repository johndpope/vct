//
//  ZTFileHelpers.h
//  ZAZOTest
//
//  Created by vc on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTFileHelpers : NSObject

+(NSURL*)absolutePathURLForFileName:(NSString*)fileName;
+(NSString*)fileNameForVideoAtIndex:(NSUInteger)index;
+(NSString*)fileNameForThumbnailAtIndex:(NSUInteger)index;
+(void)deleteFileIfAlreadyExist:(NSURL*)fileURL;

@end
