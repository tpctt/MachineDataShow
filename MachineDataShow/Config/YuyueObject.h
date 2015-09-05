//
//  YuyueObject.h
//  MachineDataShow
//
//  Created by tim on 15-9-5.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "BaseObject.h"

@interface YuyueObject : BaseObject

@property (strong,nonatomic) NSString *companyname;
@property (strong,nonatomic) NSString *desccription;
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *peopernum;
@property (strong,nonatomic) NSString *tele;
@property (strong,nonatomic) NSString *visittime;

@end
@interface YuyueObjectRequest : BaseListObjectRequest

@end


@interface YuyueObjectSceneModel : BaseSceneModel
@end