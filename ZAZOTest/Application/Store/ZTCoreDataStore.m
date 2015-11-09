//
//  ZTCoreDataStore.m
//  ZAZOTest
//
//  Created by vc on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import "ZTCoreDataStore.h"
#import "ZTManagedVideoItem.h"

@interface ZTCoreDataStore ()

@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation ZTCoreDataStore

- (id)init
{
    if ((self = [super init])) {
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];

        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];

        NSError *error = nil;
        NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        NSURL *storeURL = [applicationDocumentsDirectory URLByAppendingPathComponent:@"DATA.sqlite"];

        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:storeURL
                                                        options:options error:&error];

        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
        _managedObjectContext.undoManager = nil;

    }

    return self;
}


- (NSArray*)fetchAllEntries
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"VideoItem"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];

    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if (error) {
        NSLog(@"ERROR:%s:%@", __func__, error);
    }

    return results;

}

- (ZTManagedVideoItem *)fetchEntryWithIndex:(NSUInteger)index
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"VideoItem"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"index = %ld", index];
    [fetchRequest setPredicate:predicate];

    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    ZTManagedVideoItem *item = nil;
    if (!error) {
        if ([results count] > 0) {
            item = results[0];
        }
    } else {
        NSLog(@"ERROR:%s:%@", __func__, error);
    }

    return item;

}

- (ZTManagedVideoItem*)newVideoItem
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"VideoItem"
                                                         inManagedObjectContext:self.managedObjectContext];
    ZTManagedVideoItem *newEntry = (ZTManagedVideoItem *)[[NSManagedObject alloc] initWithEntity:entityDescription
                                                                  insertIntoManagedObjectContext:self.managedObjectContext];

    return newEntry;
}

- (void)save
{
    [self.managedObjectContext save:NULL];
}

@end
