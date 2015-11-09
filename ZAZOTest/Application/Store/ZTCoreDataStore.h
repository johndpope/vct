//
//  ZTCoreDataStore.h
//  ZAZOTest
//
//  Created by vc on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ZTManagedVideoItem;

@interface ZTCoreDataStore : NSObject

- (NSArray *)fetchAllEntries;
- (ZTManagedVideoItem *)fetchEntryWithIndex:(NSUInteger)index;

- (ZTManagedVideoItem *)newVideoItem;
- (void)save;

@end
