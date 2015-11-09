//
//  ZTVideosListWireframe.h
//  ZAZOTest
//
//  Created by vc on 10/29/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTVideosListWireframe : NSObject

- (void)presentVideosListControllerFromWindow:(UIWindow*)window;
- (void)presentVideosListControllerFromNavigationController:(UINavigationController*)nc;
- (void)dismissVideosListController;

@end
