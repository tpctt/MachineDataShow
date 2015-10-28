//
//  FixViewController.h
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "BaseViewController.h"

@interface FixViewController : BaseViewController
@property(strong,nonatomic) NSString* keyword;
@property (strong, nonatomic)   DeviceObjectSceneModel *vm;
@property (strong, nonatomic)   NSArray *dataArray;


@end
