//
//  UIViewController+TakeImage.h
//  MachineDataShow
//
//  Created by 中联信 on 15/8/25.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^TakeImageBlock)(NSDictionary *info,UIImage *image);

@interface UIViewController (TakeImage)<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,copy) TakeImageBlock block1;
@property (strong,nonatomic) UIViewController *withVC;

- (void)takePhotoFromAlbum:(BOOL)FromAlbum isPhoto:(BOOL)isPhoto withBlock:(TakeImageBlock)withBlock withVC:(UIViewController*)withVC;



@end
