//
//  ZTVideosListVC.h
//  ZAZOTest
//
//  Created by vc on 10/29/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTVideosListViewInterface.h"
#import "ZTVideosListModuleInterface.h"

@interface ZTVideosListVC : UIViewController<ZTVideosListViewInterface>

@property (nonatomic, weak) id<ZTVideosListModuleInterface> eventHandler;

@end

