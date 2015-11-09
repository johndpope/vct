//
//  ZTFileHelpers.m
//  ZAZOTest
//
//  Created by Vitaly Cherevaty on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import "ZTFileHelpers.h"

@implementation ZTFileHelpers

+(NSURL*)absolutePathURLForFileName:(NSString*)fileName
{
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *fileURL = [documentsURL URLByAppendingPathComponent:fileName];
    return fileURL;
}

+(NSString*)fileNameForVideoAtIndex:(NSUInteger)index
{
    NSString *fileName = [NSString stringWithFormat:@"rec_%ld.mp4", (long)index];
    return fileName;
}

+(NSString*)fileNameForThumbnailAtIndex:(NSUInteger)index
{
    NSString *fileName = [NSString stringWithFormat:@"thumb_%ld.png", (long)index];
    return fileName;
}


+(void)deleteFileIfAlreadyExist:(NSURL*)fileURL
{
    NSString *filePath = [fileURL path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

@end
