//
//  ZTVideosListPresenter.h
//  ZAZOTest
//
//  Created by vc on 10/30/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTVideosListInteractorIO.h"
#import "ZTVideosListWireframe.h"
#import "ZTVideosListViewInterface.h"
#import "ZTVideosListModuleInterface.h"


@interface ZTVideosListPresenter : NSObject<ZTVideosListInteractorOutput, ZTVideosListModuleInterface>

@property (nonatomic, strong) id<ZTVideosListInteractorInput> interactor;
@property (nonatomic, strong) ZTVideosListWireframe* wireframe;
@property (nonatomic, weak) UIViewController<ZTVideosListViewInterface>* userInterface;

- (void)configurePresenterWithUserInterface:(UIViewController<ZTVideosListViewInterface>*)userInterface;

@end
