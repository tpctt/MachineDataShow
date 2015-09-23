//
//  YuyueObject.h
//  MachineDataShow
//
//  Created by tim on 15-9-5.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "BaseObject.h"
/*
 
 */
@interface YuyueObject : BaseObject

@property (strong,nonatomic) NSString *uid;
@property (strong,nonatomic) NSString *companyname;
//参观人数
@property (strong,nonatomic) NSString *mount;
@property (strong,nonatomic) NSString *duty;
@property (strong,nonatomic) NSString *telephone;
@property (strong,nonatomic) NSString *visittime;
//留言
@property (strong,nonatomic) NSString *remakrs;
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *visitno;
@property (strong,nonatomic) NSString *time;
@property (assign,nonatomic) int status ;

@end
@interface YuyueObjectRequest : BaseListObjectRequest

@end


@interface YuyueObjectSceneModel : BaseSceneModel

@end