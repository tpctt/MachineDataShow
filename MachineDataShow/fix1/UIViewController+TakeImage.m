//
//  UIViewController+TakeImage.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/25.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "UIViewController+TakeImage.h"
#import <AssetsLibrary/AssetsLibrary.h>
 

@implementation UIViewController (TakeImage)

- (void)takePhotoFromAlbum:(BOOL)FromAlbum isPhoto:(BOOL)isPhoto withBlock:(TakeImageBlock)withBlock withVC:(UIViewController*)withVC{
    self.block1 = withBlock;
    self.withVC = withVC;
    
     [self takePhotoFromAlbum:FromAlbum isPhoto:isPhoto  ];
    
}


///相册/相机 视频、照片
- (void)takePhotoFromAlbum:(BOOL)FromAlbum isPhoto:(BOOL)isPhoto
{
    //    [self takePhotoAndVideoWithIndex: 2 ];
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = 1 ;
    picker.mediaTypes = [NSArray arrayWithObjects:@"public.image", nil];
    
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        
        if ( author == ALAuthorizationStatusDenied)
        {
            //        NSLog(@"设备不支持 相册");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"软件没有使用相册的权限,请在设置->隐私->相册中开启权限" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil ];
            [alert show];
            return;
            
        } else{
            
            [self presentViewController:picker animated:YES completion:^{
                //        NSLog(@" 显示 picker  的view");
            }];
            
        }
    }
    
    else{
        
        
        
        
        [self presentViewController:picker animated:YES completion:^{
            //        NSLog(@" 显示 picker  的view");
        }];
        
    }
    
    
    //    if (isPhoto) {
    //        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    //    }else{
    //        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    //        picker.videoQuality = UIImagePickerControllerQualityTypeLow;
    //
    //    }
    
    
    if (FromAlbum) {
        if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }else if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum ]){
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"软件没有使用相册的权限,请在设置->隐私->相册中开启权限" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil ];
            [alert show];
            return;
        }
    }else{
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera ]){
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"软件没有使用相机的权限,请在设置->隐私->相机中开启权限" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil ];
            [alert show];
            return;
        }
    }
    
    [self  presentViewController:picker animated:YES completion:^{
        //   NSLog(@" 显示 picker  的view");
        
        
    }];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image =  info[UIImagePickerControllerOriginalImage];;
    //    self.image.image = image;
    //    self.image.contentMode = UIViewContentModeScaleAspectFit;
    if(self.block1)
        self.block1(info,image);
    
    
    [self imagePickerControllerDidCancel:picker];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
@end
