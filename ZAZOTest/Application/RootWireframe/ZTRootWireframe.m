//
//  ZTRootWireframe.m
//  ZAZOTest
//
//  Created by Vitaly Cherevaty on 10/29/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import "ZTRootWireframe.h"
#import "ZTVideosListWireframe.h"

@implementation ZTRootWireframe

- (void)showStartViewControllerInWindow:(UIWindow*)window
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    window.backgroundColor = [UIColor whiteColor];
    
    ZTVideosListWireframe* wireframe = [ZTVideosListWireframe new];
    [wireframe presentVideosListControllerFromWindow:window];
}

- (void)showRootController:(UIViewController*)vc inWindow:(UIWindow *)window
{
    UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:vc];
    window.rootViewController = nc;
}


@end
