//
//  MeViewController.h
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "BaseViewController.h"

@interface MeViewController : UITableViewController
@property (strong,nonatomic ) UIImage  *image;
+(MeViewController *)sharedInstance;

@end
