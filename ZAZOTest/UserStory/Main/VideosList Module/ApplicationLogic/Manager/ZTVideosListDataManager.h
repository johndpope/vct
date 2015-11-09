//
//  ZTVideosListDataManager.h
//  ZAZOTest
//
//  Created by Vitaly Cherevaty on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTVideoItem.h"
#import "ZTCoreDataStore.h"

@interface ZTVideosListDataManager : NSObject

-(NSArray*)videoItems;
-(void)updateVideoItem:(ZTVideoItem*)videoItem;
-(void)addNewVideoItem:(ZTVideoItem *)item;


@property (nonatomic, strong) ZTCoreDataStore *dataStore;

@end
