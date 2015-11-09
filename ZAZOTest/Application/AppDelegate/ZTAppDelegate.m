//
//  ZTAppDelegate.m
//  ZAZOTest
//
//  Created by vc on 10/29/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import "ZTAppDelegate.h"
#import "ZTAppDependencies.h"

@interface ZTAppDelegate ()

@property (nonatomic, strong) ZTAppDependencies* appDependencies;

@end

@implementation ZTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.appDependencies initialApplicationSetup:application launchOptions:launchOptions];
    [self.appDependencies installRootViewControllerIntoWindow:self.window];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication*)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)newDeviceToken
{
    [self.appDependencies handleApplicationDidRegisterForPushWithToken:newDeviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [self.appDependencies handleApplication:application didRecievePushNotification:userInfo];
}

- (BOOL)application:(UIApplication*)application
            openURL:(NSURL*)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [self.appDependencies handleOpenURL:url inApplication:sourceApplication];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self.appDependencies handleApplicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self.appDependencies handleApplicationWillTerminate];
}


#pragma mark - Private

- (ZTAppDependencies *)appDependencies
{
    if (!_appDependencies){
        _appDependencies = [ZTAppDependencies new];
    }
    return _appDependencies;
}

@end
