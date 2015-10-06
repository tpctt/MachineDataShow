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
#import "NetManager.h"
#import "HelpViewController.h"

#import "LoginViewController.h"
#import "ApplyFixViewController.h"
#import "YuyueTableViewController.h"

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

static MeViewController* shareApp;

+(MeViewController *)sharedInstance
{
    return shareApp;
}
-(void)setImage:(UIImage *)image
{
    _image = image;
    [self.icon setImage:image forState:0];
    
}
-(void)dealView
{
    if ([UserObject hadLog]     ) {
        if ([UserObject sharedInstance].mobile==nil) {
            [MBProgressHUD showHUDAddedTo:self.bgView animated:YES];
            
            [NetManager getUserInfo:^(NSArray *array, NSError *error, NSString *msg) {
                [MBProgressHUD hideHUDForView:self.bgView animated:YES];
                
                [self dealView];
                
            }];
            
        }else{
            self.loginView.hidden = 0;
            self.notLoginView.hidden = 1;
            self.logoutBase.hidden = 0;
            
            self.myInfoCell.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
            
            if(_image   ){
                [self.icon setImage:_image forState:0];
            }else
                [self.icon sd_setImageWithURL:[NSURL URLWithString:[UserObject sharedInstance].head ]
                                     forState:0
                             placeholderImage:[UIImage imageNamed:@"Avatar.jpg"]
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                    }];
            
            self.phone.text = [UserObject sharedInstance].mobile ;
            

        }
        
        
        
    }else{
        self.loginView.hidden = 1;
        self.notLoginView.hidden = 0;
        self.logoutBase.hidden = 1;
        
        self.myInfoCell.frame = CGRectMake(0, 0, self.view.frame.size.width, 0);
        
    }
    [self.tableView reloadData];
    
}
- (IBAction)btnAct:(id)sender {
    if(sender == self.editInfoBtn   ){
        InfoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"xgzl"];
        
        [self.tabBarController.navigationController pushViewController:vc animated:1];
        
    }else if(sender == self.p   ){
        InfoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"xgmm"];
        
        [self.tabBarController.navigationController pushViewController:vc animated:1];
        
    }
}
- (IBAction)logout:(id)sender {
    [UIAlertView showWithTitle:@"是否退出？" message:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"确认" ] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1 ) {
            [UserObject sharedInstance].uid = nil;
            [UserObject clearCache];
            
            [self dealView];
        }
    }];
    
}
- (IBAction)login:(id)sender {
    LoginViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
    
    [self.tabBarController.navigationController pushViewController:vc animated:1];
    
}
- (IBAction)headIconBtnAct:(id)sender {
    [UIActionSheet showInView:self.view withTitle:@"设置头像" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照",@"相册"] tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
        
        [[GCDQueue mainQueue]queueBlock:^{
            if (buttonIndex ==  0) {
                [self takePhotoFromAlbum:0 isPhoto:1];
            }else if (buttonIndex ==  1){
                [self takePhotoFromAlbum:1 isPhoto:1];
            }
            
        }];
       
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
            
            [self presentViewController:picker animated:YES completion:^{
                //        NSLog(@" 显示 picker  的view");
            }];
            
        }
    }
    
    else{
        
        
        
        
        [self.navigationController presentViewController:picker animated:YES completion:^{
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
            return;
        }else if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum ]){
            
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            return;
        }else
        {
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
    
    [[[AppDelegate sharedInstance]homeVC] presentViewController:picker animated:NO completion:^{
        //   NSLog(@" 显示 picker  的view");
        
        
    }];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image =  info[UIImagePickerControllerOriginalImage];;
//    self.image.image = image;
//    self.image.contentMode = UIViewContentModeScaleAspectFit;

    [self.icon setImage:image forState:0];
    self.image = image;
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [MBProgressHUD showHUDAddedTo:self.view animated:1];
        
        [[GCDQueue globalQueue]queueBlock:^{
            [NetManager uploadHead:image block:^(NSArray *array, NSError *error, NSString *msg) {
                [[GCDQueue mainQueue]queueBlock:^{
                    [MBProgressHUD hideAllHUDsForView:self.view animated:1];
                    
                    if (array != nil) {
                        
                        [[GCDQueue mainQueue]queueBlock:^{
                            
                            NSString *STRING = [array firstObject];
                            if ([STRING isKindOfClass:[NSString class]] && STRING.length != 0   ) {
                                [[DialogUtil sharedInstance]showDlg:self.view.window textOnly:@"修改成功"];
                            }
                            
                            
                            //                    [self.navigationController popViewControllerAnimated:1];
                            
                            [UserObject sharedInstance].head = STRING;
                            [[NSNotificationCenter defaultCenter]postNotificationName:HeadImageChandedNoti object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:image,@"image", nil]];
                            
                        }];
                        
                    }else{
                        [self showMsg:msg error:error];
                    }
                    
                }];

                
            }];
        }];
        
      
    }];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    
    if( (row == 0 || row == 1 ) && ![UserObject hadLog] ){
        [UIAlertView showWithTitle:@"" message:@"还未登陆，是否前往登陆?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex==1) {
                
                //                    [self performSegueWithIdentifier:@"loginSeg" sender:nil];
                [self login:nil];
                
            }
        }];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

        return;
    }
    
    if (row == 0 ) {
        InfoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"xgzl"];
        
        [self.tabBarController.navigationController pushViewController:vc animated:1];
        
    }
    else if (row == 1){
        InfoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"xgmm"];
        
        [self.tabBarController.navigationController pushViewController:vc animated:1];
        
    }else
    
    if (row == 2 ) {
        ApplyFixViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WDBXJL"];
        
        [self.tabBarController.navigationController pushViewController:vc animated:1];
        
    }else if (row == 3){
        YuyueTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"yuyueSB"];
        
        [self.tabBarController.navigationController pushViewController:vc animated:1];
        
    }else if (row==4){
        ///关于我们
        HelpViewController *web = [[HelpViewController alloc]initWithURLString:[NSString stringWithFormat:@"%@%@",AppHostAddress,@"page/about.html"]];
        
        [self.tabBarController.navigationController pushViewController:web animated:1];

    }else if (row==5){
        ///帮助中心
        HelpViewController *web = [[HelpViewController alloc]initWithURLString:[NSString stringWithFormat:@"%@%@",AppHostAddress,@"page/help.html"]];
        
        [self.tabBarController.navigationController pushViewController:web animated:1];
        
    }
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#if USENormalPush
    self.edgesForExtendedLayout = UIRectEdgeNone;
#endif
    
    self.loginBtn.layer.borderWidth = 1;
    self.loginBtn.layer.borderColor = [[UIColor orangeColor]CGColor];
    self.loginBtn.layer.cornerRadius = 5;
    
    self.loginBtn.backgroundColor = [UIColor whiteColor];
    
    
    
    _icon.layer.cornerRadius = _icon.width/2;
    _icon.clipsToBounds= 1;
    self.title = @"我的";

//    self.tableView.delegate = self;
//    self.mytableview.dataSource = self;
//
    self.view.backgroundColor = RGB(236, 236, 236);
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self dealView];
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:FLlogin object:nil] subscribeNext:^(id x) {
        [self dealView];

    }];
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:HeadImageChandedNoti object:nil] subscribeNext:^(id x) {
        NSNotification *noti = x;
        NSDictionary *info = noti.userInfo;
        UIImage *image = info[@"image"];
        _image = image;
        
        [self dealView];
        
    }];
    
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:UseriNFOChandedNoti object:nil] subscribeNext:^(id x) {
        NSNotification *noti = x;
        NSDictionary *info = noti.userInfo;
        
        UserObject *OBJ = info[@"info"];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:1];
        [NetManager getUserInfo:^(NSArray *array, NSError *error, NSString *msg) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:1];
            
            if (array != nil) {
                UserObject *OBJ1 = [array firstObject];
                if (OBJ1) {
                    [UserObject setDataFrom:OBJ1];
                }
                
                [[GCDQueue mainQueue]queueBlock:^{
                    
                    NSString *STRING = [array firstObject];
                    if ([STRING isKindOfClass:[NSString class]] && STRING.length != 0   ) {
                        [[DialogUtil sharedInstance]showDlg:self.view.window textOnly:STRING];
                    }
                    
                    
                }];
                
            }else{
                [self showMsg:msg error:error];
                
                
            }
        }];
        
        
    }];
}
-(void)showMsg:(NSString*)msg error:(NSError*)error{
    if(msg){
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:msg];;
//        [UIAlertView showWithTitle:@"提示" message:msg cancelButtonTitle:@"确认" otherButtonTitles:nil tapBlock:nil];
        
    }else{
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:   error.localizedDescription];;

     
//        [UIAlertView showWithTitle:@"提示" message:error.localizedDescription cancelButtonTitle:@"确认" otherButtonTitles:nil tapBlock:nil];
        
    }
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
