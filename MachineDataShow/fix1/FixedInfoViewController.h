//
//  FixedInfoViewController.h
//  MachineDataShow
//
//  Created by tim on 15-8-15.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "BaseViewController.h"
//#import "UIViewController+TakeImage.h"

typedef void(^TakeImageBlock)(NSDictionary *info,UIImage *image);

///申请维修
@interface FixedInfoViewController : BaseViewController
<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,copy) TakeImageBlock block1;
@property (strong,nonatomic) UIViewController *withVC;

- (void)takePhotoFromAlbum:(BOOL)FromAlbum isPhoto:(BOOL)isPhoto withBlock:(TakeImageBlock)withBlock withVC:(UIViewController*)withVC;


@property(strong,nonatomic)DeviceObject *o;

@end
