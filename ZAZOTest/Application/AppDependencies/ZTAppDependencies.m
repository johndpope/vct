//
//  ZTAppDependencies.m
//  ZAZOTest
//
//  Created by Vitaly Cherevaty on 10/29/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import "ZTAppDependencies.h"
#import "ZTRootWireframe.h"

@interface ZTAppDependencies ()

@property (nonatomic, strong) ZTRootWireframe* rootWireframe;

@end

@implementation ZTAppDependencies

- (void)installRootViewControllerIntoWindow:(UIWindow *)window
{
    [self.rootWireframe showStartViewControllerInWindow:window];
}

- (void)initialApplicationSetup:(UIApplication *)application launchOptions:(NSDictionary *)options
{
    
}

- (BOOL)handleOpenURL:(NSURL*)url inApplication:(NSString*)application
{
    return NO;
}

- (void)handleApplicationDidBecomeActive
{
    
}

- (void)handleApplicationWillTerminate
{
    
}

#pragma mark - Push

- (void)handleApplicationDidRegisterForPushWithToken:(NSData *)token
{
    
}

- (void)handleApplication:(UIApplication *)application didRecievePushNotification:(NSDictionary *)userInfo
{
    
}

- (void)handleApplication:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
}

#pragma mark - Private

- (ZTRootWireframe *)rootWireframe
{
    if (!_rootWireframe) {
        _rootWireframe = [ZTRootWireframe new];
    }
    return _rootWireframe;
}

@end
