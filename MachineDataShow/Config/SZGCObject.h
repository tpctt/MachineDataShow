//
//  SZGCObject.h
//  MachineDataShow
//
//  Created by tim on 15-9-5.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "BaseObject.h"

@interface SZGCObject : BaseObject
@property (strong,nonatomic) NSString *NAME;
@property (strong,nonatomic) NSString *all;
@property (strong,nonatomic) NSString *check;
@property (strong,nonatomic) NSString *good;
@property (strong,nonatomic) NSString *checkrate;
@property (strong,nonatomic) NSString *goodrate;
@property (assign,nonatomic) int state;
+(SZGCObject*)random;

@end
@interface SZGCObjectRequest : BaseListObjectRequest

@end


@interface SZGCObjectSceneModel : BaseSceneModel
@end