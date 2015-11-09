//
//  ZTVideosListInteractor.m
//  ZAZOTest
//
//  Created by vc on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import "ZTVideosListInteractor.h"
#import "ZTVideoItem.h"
#import "ZTVideosListModuleConstants.h"
#import "ZTVideosListDataManager.h"
#import "ZTFileHelpers.h"

@interface ZTVideosListInteractor()

//@property (nonatomic) NSMutableArray *videoItems;

@end

@implementation ZTVideosListInteractor

- (NSArray*)videoItems
{
    return [self.dataManager videoItems];
}

- (void)loadVideosList
{
    NSArray *items = [self.dataManager videoItems];
    if ([items count] == 0) {
        [self generateInitialItems];
        items = [self.dataManager videoItems];
    }

    [self.output videosListLoaded:items];
}

-(NSString *)createTestVideoFile
{
    NSString *testFileName = @"Ship.mp4";
    NSString *testFilePath = [[NSBundle mainBundle] pathForResource:testFileName ofType:nil];
    NSString *docsFilePath = [[ZTFileHelpers absolutePathURLForFileName:testFileName] path];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:docsFilePath]) {

        NSError *error = nil;
        [fileManager copyItemAtPath:testFilePath toPath:docsFilePath error:&error];
        if (error) {
            NSLog(@"ERROR:%s:%@", __func__, error);
        }
    }

    return testFileName;
}

-(void)generateInitialItems
{
    NSString *initialVideoPath = nil;

//TEST
//    initialVideoPath = [self createTestVideoFile];
//TEST

    for (NSUInteger i = 0; i < ZTVideoItemsCount; i++) {
        ZTVideoItem *item = [ZTVideoItem itemWithIndex:i videoPath:initialVideoPath thumbnailPath:nil];
        [self.dataManager addNewVideoItem:item];
    }
}

- (void)updateVideoItemVideoPath:(NSString*)videoPath thumbnailPath:(NSString*)thumbnailPath atIndex:(NSUInteger)index
{
    NSAssert((index >= 0 && index < ZTVideoItemsCount), @"Video index have to be in range");

    ZTVideoItem *item = self.videoItems[index];
    item.videoPath = videoPath;
    item.thumbnailPath = thumbnailPath;

    [self.dataManager updateVideoItem:item];

    [self.output videoUpdatedSuccessfully:item];
}


@end
