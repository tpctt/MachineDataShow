//
//  MeViewController.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "MeViewController.h"
#import "UserObject.h"
#import <EasyIOS/Easy.h>
#import <UIActionSheet+Blocks/UIActionSheet+Blocks.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "LoginObject.h"
#import "InfoViewController.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;


@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet UIButton *editInfoBtn;
@property (weak, nonatomic) IBOutlet UIButton *p;

@property (weak, nonatomic) IBOutlet UILabel *phone;




@property (weak, nonatomic) IBOutlet UIView *notLoginView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@property (weak, nonatomic) IBOutlet UIView *logoutBase;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;



@property (weak, nonatomic) IBOutlet UITableViewCell *myInfoCell;

@end

@implementation MeViewController
-(void)dealView
{
    if ([UserObject hadLog]     ) {
        self.loginView.hidden = 0;
        self.notLoginView.hidden = 1;
        self.logoutBase.hidden = 0;
        
        self.myInfoCell.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
        
        
        [self.icon sd_setImageWithURL:[NSURL URLWithString:[UserObject sharedInstance].head ]
                    forState:0
                    placeholderImage:[UIImage imageNamed:@"Avatar.jpg"]
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
        
        self.phone.text = [UserObject sharedInstance].mobile ;
        
        
        
        
    }else{
        self.loginView.hidden = 1;
        self.notLoginView.hidden = 0;
        self.logoutBase.hidden = 1;
        
        self.myInfoCell.frame = CGRectMake(0, 0, self.view.frame.size.width, 0);
        
    }
    [self.tableView reloadData];
    
}
- (IBAction)btnAct:(id)sender {
}
- (IBAction)logout:(id)sender {
    [UserObject sharedInstance].uid = nil;
    
    
    [self dealView];
    
    
}
- (IBAction)login:(id)sender {
}
- (IBAction)headIconBtnAct:(id)sender {
    [UIActionSheet showInView:self.view withTitle:@"设置头像" cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@[@"相机"] tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
        if (buttonIndex==0) {
            [self takePhotoFromAlbum:1 isPhoto:1];
        }else if (buttonIndex==1) {
            [self takePhotoFromAlbum:0 isPhoto:1];
        }
    }];
   
}
///相册/相机 视频、照片
- (IBAction)takePhotoFromAlbum:(BOOL)FromAlbum isPhoto:(BOOL)isPhoto
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
            
            //        ALAuthorizationStatusNotDetermined = 0, // User has not yet made a choice with regards to this application
            //        ALAuthorizationStatusRestricted,        // This application is not authorized to access photo data.
            //        // The user cannot change this application’s status, possibly due to active restrictions
            //        //  such as parental controls being in place.
            //        ALAuthorizationStatusDenied,            // User has explicitly denied this application access to photos data.
            //        ALAuthorizationStatusAuthorized
            
            
            
            //            [self presentViewController:picker animated:YES completion:^{
            //                //        NSLog(@" 显示 picker  的view");
            //            }];
            
        }
    }
    
    else{
        
        
        
        
        //        [self.navigationController presentViewController:picker animated:YES completion:^{
        //            //        NSLog(@" 显示 picker  的view");
        //        }];
        
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
    
    [self.navigationController.tabBarController presentViewController:picker animated:YES completion:^{
        //   NSLog(@" 显示 picker  的view");
        
        
    }];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image =  info[UIImagePickerControllerOriginalImage];;
//    self.image.image = image;
//    self.image.contentMode = UIViewContentModeScaleAspectFit;

    [self.icon setImage:image forState:0];
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        if ([UserObject hadLog]     ) {
            [self performSegueWithIdentifier:@"InfoSeg" sender:nil];

        }else{
            [UIAlertView showWithTitle:@"" message:@"还未登陆，是否前往登陆?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex==1) {
                    
                    [self performSegueWithIdentifier:@"loginSeg" sender:nil];
                    
                }
            }];
        }
    }else if (indexPath.row == 3){
        [UIAlertView showWithTitle:@"" message:@"去掉此功能?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            
        }];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#if USENormalPush
    self.edgesForExtendedLayout = UIRectEdgeNone;
#endif
    
    _icon.layer.cornerRadius = _icon.width/2;
    _icon.clipsToBounds= 1;
    self.title = @"我的";

//    self.tableView.delegate = self;
//    self.mytableview.dataSource = self;
//
    self.view.backgroundColor = RGB(236, 236, 236);
    
    [self dealView];
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:FLlogin object:nil] subscribeNext:^(id x) {
        [self dealView];

    }];
    
}

#if USENormalPush
-(UINavigationController *)navigationController
{
    
    return self.tabBarController.navigationController;
}
#endif
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.identifier isEqualToString:@"InfoSeg"]) {
//        InfoViewController *vc = (InfoViewController *)segue.destinationViewController;
//        [self.navigationController pushViewController:vc animated:1];
//        
//    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
