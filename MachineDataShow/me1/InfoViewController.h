//
//  InfoViewController.h
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "BaseViewController.h"
#define HeadImageChandedNoti @"HeadImageChandedNoti"
#define UseriNFOChandedNoti @"UseriNFOChandedNoti"


@interface InfoViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;


@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet UIButton *editInfoBtn;
@property (weak, nonatomic) IBOutlet UIButton *p;

@property (weak, nonatomic) IBOutlet UILabel *phone;


@end
