//
//  ZTVideosListInteractor.h
//  ZAZOTest
//
//  Created by Vitaly Cherevaty on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTVideosListInteractorIO.h"

@class ZTVideosListDataManager;

@interface ZTVideosListInteractor : NSObject<ZTVideosListInteractorInput>

@property (nonatomic, strong) ZTVideosListDataManager *dataManager;
@property (nonatomic, weak) id<ZTVideosListInteractorOutput> output;

@end
