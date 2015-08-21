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
@property(assign,nonatomic) int progress;
@property(strong,nonatomic) NSString *name;


@end
@interface MyFixingObjectRequest : BaseListObjectRequest

@end


@interface MyFixingObjectSceneModel : BaseSceneModel
@end