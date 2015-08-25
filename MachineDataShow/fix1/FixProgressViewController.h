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

//@property (strong, nonatomic)   NSString *flag;
//@property (strong, nonatomic)   NSString *lastUpdateTime;
//@property (strong, nonatomic)   NSArray  *dataList;

@end

/// 工程师的信息
@interface GCSInfo :BaseObject
@property (strong, nonatomic)   NSString *completetime;
@property (strong, nonatomic)   NSString *head;
@property (strong, nonatomic)   NSString *name;
@property (strong, nonatomic)   NSString *no;
@property (strong, nonatomic)   NSString *tele;

@end