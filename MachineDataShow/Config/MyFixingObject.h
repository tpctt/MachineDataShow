//
//  MyFixingObject.h
//  MachineDataShow
//
//  Created by 中联信 on 15/8/21.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "BaseObject.h"

@interface MyFixingObject : BaseObject
@property(strong,nonatomic) NSString *id;
@property(strong,nonatomic) NSString *serial;
@property(strong,nonatomic) NSString *time;
///0-客户报修、1-处理中、2- 已处理、3-已报价、4-已付 款、5、已派人、6-已结束
@property(assign,nonatomic) int progress;
@property(strong,nonatomic) NSString *equipmentName;


@end
@interface MyFixingObjectRequest : BaseListObjectRequest

@end


@interface MyFixingObjectSceneModel : BaseSceneModel
@property(strong,nonatomic) MyFixingObjectRequest *request;

@end