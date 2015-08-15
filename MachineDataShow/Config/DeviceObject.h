//
//  DeviceObject.h
//  MachineDataShow
//
//  Created by tim on 15-8-15.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "BaseObject.h"

@interface DeviceObject : BaseObject
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *mode;
@property(strong,nonatomic) NSString *sn;
@property(strong,nonatomic) NSString *date;
//@property(strong,nonatomic) NSString *buyDate;

@property(assign,nonatomic) BOOL isFixing;

@end
@interface DeviceObjectRequest : BaseListObjectRequest
@end


@interface DeviceObjectSceneModel : BaseSceneModel
@end