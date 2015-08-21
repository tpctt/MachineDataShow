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
    
    //    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top_banner"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"64"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName , [UIFont systemFontOfSize:18],NSFontAttributeName, nil]];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
    
    
//    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
//    [NSURLCache setSharedURLCache:URLCache];
    
    
}
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    //    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    //    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    //    NSArray *tabBarItemImages = @[@"first", @"second", @"third",@"four"];
    //
    
    NSArray *imageArray = @[@"tab1",@"tab2",@"tab3"];
    //    NSArray *titleArray = @[@"首页",@"彩妆产品",@"我"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_click", imageArray[index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[index]]];
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        //        [item setTitle:titleArray[index]];
        
        NSDictionary *textAttributes  = @{
                                          NSFontAttributeName: [UIFont boldSystemFontOfSize:13],
                                          NSForegroundColorAttributeName: RGB(252, 68, 151   )
                                          
                                          };
        NSDictionary *textAttributes2  = @{
                                           NSFontAttributeName: [UIFont boldSystemFontOfSize:13],
                                           NSForegroundColorAttributeName: [UIColor grayColor]
                                           
                                           };
        
        [item setSelectedTitleAttributes:textAttributes];
        [item setUnselectedTitleAttributes:textAttributes2];
        
        //        [item setBackgroundColor:[UIColor clearColor]];
        
        
        index++;
    }
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
        [self.homeVC.navigationController pushViewController:[[ShowMeViewController alloc] init]  animated:NO];
        
    }
    
    [Action actionConfigHost:[AppHostAddress stringByReplacingOccurrencesOfString:@"http://" withString:@""] client:@"APP" codeKey:@"result" rightCode:1 msgKey:@"response/errorText"];
    
    
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
