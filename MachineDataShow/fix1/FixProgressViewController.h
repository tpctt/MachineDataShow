//
//  FixProgressViewController.h
//  MachineDataShow
//
//  Created by tim on 15-8-13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "BaseViewController.h"
#import "MyFixingObject.h"
///我的设备维修进度,77乖乖的界面
@interface FixProgressViewController : BaseViewController
@property(strong,nonatomic)MyFixingObject *o;

@end
@interface FixedProgressInfo :BaseObject
@property (strong, nonatomic)   NSString *icon;
@property (strong, nonatomic)   NSString *name;
@property (strong, nonatomic)   NSString *phone;
@property (strong, nonatomic)   NSString *process;

@end