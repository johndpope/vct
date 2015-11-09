//
//  ZTAppDependencies.h
//  ZAZOTest
//
//  Created by Vitaly Cherevaty on 10/29/15.
//  Copyright © 2015 Codeminders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTAppDependencies : NSObject

- (void)initialApplicationSetup:(UIApplication *)application launchOptions:(NSDictionary*)options;

- (BOOL)handleOpenURL:(NSURL*)url inApplication:(NSString*)application;
- (void)handleApplicationDidBecomeActive;
- (void)handleApplicationWillTerminate;

- (void)handleApplicationDidRegisterForPushWithToken:(NSData*)token;
- (void)handleApplication:(UIApplication*)application didRecievePushNotification:(NSDictionary*)userInfo;

- (void)handleApplication:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings;

- (void)installRootViewControllerIntoWindow:(UIWindow *)window;

@end
