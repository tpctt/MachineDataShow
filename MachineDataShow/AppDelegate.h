//
//  AppDelegate.h
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarViewController.h"

#define AppHostAddress @"www.taoqian123.com/api.php/Index/"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic,readonly) TabbarViewController2  *homeVC ;

@property (strong, nonatomic,readonly)  NavViewController *homeNav;

+(AppDelegate *)sharedInstance;

@end

