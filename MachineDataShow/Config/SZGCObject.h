//
//  SZGCObject.h
//  MachineDataShow
//
//  Created by tim on 15-9-5.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "BaseObject.h"
@class CLJ_presonObj;
@interface CLJ_object : NSObject<NSURLConnectionDataDelegate>
@property (strong,nonatomic) NSString *url;
@property (strong,nonatomic) NSMutableArray *stateArray;
@property (strong,nonatomic) NSMutableArray *productArray;

@property (strong,nonatomic) NSNumber *receviceIndex;
@property(nonatomic,strong)NSMutableData *responseData;
@property(nonatomic,strong) CLJ_presonObj* presonObj;

AS_SINGLETON(CLJ_object)
-(void)start;
-(void)stop;

@end
@interface CLJ_deviceObj : BaseObject

@property (strong,nonatomic) NSString *MachineID;
@property (strong,nonatomic) NSString *State;


@end
@interface CLJ_productObj : BaseObject

@property (strong,nonatomic) NSString *MachineID;
@property (strong,nonatomic) NSString *Task;
///产量
@property (strong,nonatomic) NSString *Output;
@property (strong,nonatomic) NSString *Checked;
@property (strong,nonatomic) NSString *OK;
@property (strong,nonatomic) NSString *checkrate;
@property (strong,nonatomic) NSString *goodrate;

@property (strong,nonatomic) NSMutableArray *preson_productArray;


@end
@interface CLJ_person_productObj : BaseObject

@property (strong,nonatomic) NSString *Person;
@property (strong,nonatomic) NSString *Pro;
@property (strong,nonatomic) NSString *Output;




@end



@interface CLJ_presonObj : BaseObject

@property (strong,nonatomic) NSString *GM;
@property (strong,nonatomic) NSString *GMQTY;
@property (strong,nonatomic) NSString *GMQTYOnline;

@property (strong,nonatomic) NSString *QC;
@property (strong,nonatomic) NSString *QCQTY;
@property (strong,nonatomic) NSString *QCQTYOnline;


@property (strong,nonatomic) NSString *QP;
@property (strong,nonatomic) NSString *QPQTY;
@property (strong,nonatomic) NSString *QPQTYOnline;



@end





@interface SZGCObject : BaseObject
//@property (strong,nonatomic) NSString *NAME;
//@property (strong,nonatomic) NSString *all;
//@property (strong,nonatomic) NSString *check;
//@property (strong,nonatomic) NSString *good;
//@property (strong,nonatomic) NSString *checkrate;
//@property (strong,nonatomic) NSString *goodrate;
//@property (assign,nonatomic) int state;

@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *model;
@property (strong,nonatomic) NSString *serial;
@property (strong,nonatomic) NSString *status;

@property (strong,nonatomic) CLJ_deviceObj *status_obj;
@property (strong,nonatomic) CLJ_productObj *PRODUCT_obj;



@end
@interface SZGCObjectRequest : BaseListObjectRequest

@end


@interface SZGCObjectSceneModel : BaseSceneModel
@end