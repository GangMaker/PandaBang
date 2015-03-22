//
//  AppDelegate.m
//  apns
//
//  Created by wany on 15/3/6.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
//    action.identifier = @"action";//按钮的标示
//    action.title=@"Accept";//按钮的标题
//    action.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
//    //    action.authenticationRequired = YES;
//    //    action.destructive = YES;
//    
//    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
//    action2.identifier = @"action2";
//    action2.title=@"Reject";
//    action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
//    action.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
//    action.destructive = YES;
//    
//    
//    UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
//    categorys.identifier = @"alert";//这组动作的唯一标示
//    [categorys setActions:@[action,action2] forContext:(UIUserNotificationActionContextMinimal)];
//    
//    
//    UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:[NSSet setWithObjects:categorys, nil]];
//    
//    
//    
//    [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
//    [[UIApplication sharedApplication] registerForRemoteNotifications];
//    if(IOS8)
//    {
//        //register remoteNotification types
//        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
//        action1.identifier = @"action1_identifier";
//        action1.title=@"Accept";
//        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
//        
//        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
//        action2.identifier = @"action2_identifier";
//        action2.title=@"Reject";
//        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
//        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
//        action2.destructive = YES;
//        
//        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
//        categorys.identifier = @"category1";//这组动作的唯一标示
//        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
//        
//        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
//                                                                                     categories:[NSSet setWithObject:categorys]];
//        [[UIApplication sharedApplication] registerRemoteNotificationAndUserNotificationSettings:userSettings];
//        
//    } else{
//        //register remoteNotification types
//        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
//         |UIRemoteNotificationTypeSound
//         |UIRemoteNotificationTypeAlert];
//    }
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
    
    return YES;
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    NSLog(@"My token is:%@", token);
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
