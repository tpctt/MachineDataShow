//
//  AppDelegate.h
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarViewController.h"

//#define AppHostAddress @"http://182.92.159.22/"
#define AppHostAddress @"http://112.74.18.72/wgmSrv/Service1.svc/"
#define USENormalPush 0


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic,readonly) TabbarViewController2  *homeVC ;

@property (strong, nonatomic,readonly)  NavViewController *homeNav;

+(AppDelegate *)sharedInstance;

@end


