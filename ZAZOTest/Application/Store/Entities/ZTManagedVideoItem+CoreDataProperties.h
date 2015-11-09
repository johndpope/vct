//
//  ZTManagedVideoItem+CoreDataProperties.h
//  ZAZOTest
//
//  Created by Vitaly Cherevaty on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ZTManagedVideoItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZTManagedVideoItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *index;
@property (nullable, nonatomic, retain) NSString *videoPath;
@property (nullable, nonatomic, retain) NSString *thumbnailPath;

@end

NS_ASSUME_NONNULL_END
