//
//  AppDelegate.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "RequestConfig.h"
#import <EasyIOS/NSObject+EasyTypeConversion.h>
//#import "AccountSettingViewController.h"
#import "ShowMeViewController.h"
#import "Config.h"
//#import "TabbarViewController.h"
#import <RDVTabBarController/RDVTabBarItem.h>
#import <EasyIOS/Action.h>
#import "UserObject.h"
#import "ShowMeViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate
static AppDelegate* shareApp;

+(AppDelegate *)sharedInstance
{
    return shareApp;
}
-(void)initAppView
{
    
    [[UINavigationBar appearance] setBackgroundImage:
     [self imageFromColor:[UIColor whiteColor]]
                                       forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName , [UIFont systemFontOfSize:22],NSFontAttributeName, nil]];
    
    
    
    
}
- (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    shareApp = self;
    [self initAppView];
    
//    [self customizeTabBarForController:_homeVC];
//    [self.homeVC setSelectedIndex:0];

    _homeNav = (NavViewController*)self.window.rootViewController;
    _homeVC = _homeNav.viewControllers[0];
    
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
 
    if ([Config isFirstTimeLauchThisVersion]) {
        ShowMeViewController *VC = [[ShowMeViewController alloc] init ];
        [self.homeVC.navigationController pushViewController:VC animated:NO];
        
    }
    
    [Action actionConfigHost:[AppHostAddress stringByReplacingOccurrencesOfString:@"http://" withString:@""] client:@"APP" codeKey:@"result" rightCode:1 msgKey:@"response/errorText"];
    [UserObject logWithCache];
    
    
    
    return YES;
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
