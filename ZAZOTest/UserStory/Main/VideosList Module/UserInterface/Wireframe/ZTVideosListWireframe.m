//
//  ZTVideosListWireframe.m
//  ZAZOTest
//
//  Created by Vitaly Cherevaty on 10/29/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import "ZTVideosListWireframe.h"
#import "ZTVideosListVC.h"
#import "ZTVideosListInteractor.h"
#import "ZTVideosListPresenter.h"
#import "ZTVideosListDataManager.h"
#import "ZTCoreDataStore.h"

@interface ZTVideosListWireframe()

@property (nonatomic, strong) ZTVideosListVC* videosListController;
@property (nonatomic, strong) UINavigationController* presentedController;
@property (nonatomic, strong) ZTVideosListPresenter* presenter;

@end

@implementation ZTVideosListWireframe

- (void)presentVideosListControllerFromWindow:(UIWindow*)window
{
    UINavigationController* nc = [UINavigationController new];
    window.rootViewController = nc;
    [self presentVideosListControllerFromNavigationController:nc];
}


- (void)presentVideosListControllerFromNavigationController:(UINavigationController*)nc
{
    ZTVideosListVC *videosListController = [ZTVideosListVC new];
    ZTVideosListInteractor *interactor = [ZTVideosListInteractor new];
    ZTVideosListPresenter *presenter = [ZTVideosListPresenter new];

    ZTCoreDataStore *coreDataStore = [[ZTCoreDataStore alloc] init];
    ZTVideosListDataManager *dataManager = [[ZTVideosListDataManager alloc] init];
    dataManager.dataStore = coreDataStore;
    
    interactor.dataManager = dataManager;
    interactor.output = presenter;

    videosListController.eventHandler = presenter;
    
    presenter.interactor = interactor;
    presenter.wireframe = self;
    [presenter configurePresenterWithUserInterface:videosListController];
    
    [nc pushViewController:videosListController animated:YES];
    
    self.presenter = presenter;
    self.presentedController = nc;
    self.videosListController = videosListController;
}

- (void)dismissVideosListController
{
    [self.presentedController popViewControllerAnimated:YES];
}


@end
