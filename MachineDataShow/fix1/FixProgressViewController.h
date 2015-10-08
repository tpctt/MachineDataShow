//
//  FixProgressViewController.h
//  MachineDataShow
//
//  Created by tim on 15-8-13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "BaseViewController.h"
#import "MyFixingObject.h"
#import "DeviceObject.h"

@class FixedProgressInfo;
///我的设备维修进度,77乖乖的界面
@interface FixProgressViewController : BaseViewController
@property(strong,nonatomic)MyFixingObject *deviceObject;
//@property(strong,nonatomic)FixedProgressInfo *fixedProgressInfo;

@end
@interface FixedProgressInfo :BaseObject 

@property (strong, nonatomic)   NSString *repairId;
@property (strong, nonatomic)   NSString *equipmentId;
@property (strong, nonatomic)   NSString *contact;
@property (strong, nonatomic)   NSString *name;

@property (strong, nonatomic)   NSString *head;
@property (strong, nonatomic)   NSString *time;
@property (strong, nonatomic)   NSString *tele;
@property (strong, nonatomic)   NSString  *completetime;
///0-客户报修、1-处理中、2- 已处理、3-已报价、4-已付 款、5、已派人、6-已结束
@property (assign, nonatomic)  int progress;

@end

