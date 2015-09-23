//
//  DeviceObject.h
//  MachineDataShow
//
//  Created by tim on 15-8-15.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "BaseObject.h"

@interface DeviceObject : BaseObject
@property(strong,nonatomic) NSString *id;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *model;
@property(strong,nonatomic) NSString *serial;
@property(strong,nonatomic) NSString *buydate;
@property(strong,nonatomic) NSString *image;

//@property(strong,nonatomic) NSString *buyDate;

@property(assign,nonatomic) BOOL isFixing;

@end
@interface DeviceObjectRequest : BaseListObjectRequest
@property(strong,nonatomic) NSString *keyword;

@end


@interface DeviceObjectSceneModel : BaseSceneModel
@property(strong,nonatomic) DeviceObjectRequest *request;

@end