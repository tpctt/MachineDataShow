//
//  FixedInfoViewController.m
//  MachineDataShow
//
//  Created by tim on 15-8-15.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "FixedInfoViewController.h"
#import "NetManager.h"
#import "AddMediaBaseView.h"
#import <UIActionSheet+Blocks/UIActionSheet+Blocks.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface FixedInfoViewController ()<NSURLConnectionDataDelegate,NSURLConnectionDelegate>


@property (weak, nonatomic) IBOutlet UIView *TOPvIEW;
@property (weak, nonatomic) IBOutlet UILabel *devname;
@property (weak, nonatomic) IBOutlet UILabel *MODEL;
@property (weak, nonatomic) IBOutlet UILabel *SN;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextView *remark;
@property (weak, nonatomic) IBOutlet UIButton *takeImage;
@property (weak, nonatomic) IBOutlet UIButton *takeVideo;

@property (weak, nonatomic) IBOutlet UIButton *commit;

@property (strong, nonatomic)  MBProgressHUD *hud;
@property (strong, nonatomic)  NSMutableURLRequest *req;
@property (strong, nonatomic)  NSURLConnection *connec;

@property (weak, nonatomic) IBOutlet AddMediaBaseView *addimageBaseView;

@end

@implementation FixedInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"申请维修";
    
    [self config1];
    
    [self.addimageBaseView setTagert:self];
    [self.addimageBaseView setAddSelecter:@selector(showActsheet)];
    
}
-(void)showActsheet
{
//    UIViewController *withvc = self;
//
//    [UIActionSheet showInView:self.view withTitle:@"选择图片来源" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"相机",@"相册"] tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
//        
//        if(buttonIndex == 0 ){
//            [self takePhotoFromAlbum:NO isPhoto:YES withBlock:^(NSDictionary *info, UIImage *image) {
//                
//                [self.addimageBaseView addNewResoure:image];
//                
//            } withVC:withvc];
//            
//        }else if(buttonIndex == 1 ){
//            [self takePhotoFromAlbum:YES isPhoto:YES withBlock:^(NSDictionary *info, UIImage *image) {
//                
//                [self.addimageBaseView addNewResoure:image];
//                
//            } withVC:withvc];
//            
//        }
//        
//    }];
//    
//    return;
    
    [UIActionSheet showInView:self.view withTitle:@"选择上传的资源" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"图片",@"录像"] tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
       
//        NSLog(@"%d-%@",buttonIndex,[actionSheet buttonTitleAtIndex:buttonIndex]);

        UIViewController *withvc = self;
        if(buttonIndex == 0 ){
            [UIActionSheet showInView:self.view withTitle:@"选择图片来源" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"相机",@"相册"] tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
            
                if(buttonIndex == 0 ){
                    [self takePhotoFromAlbum:NO isPhoto:YES withBlock:^(NSDictionary *info, UIImage *image) {
                      
                        [self.addimageBaseView addNewResoure:image];

                    } withVC:withvc];
                    
                }else if(buttonIndex == 1 ){
                    [self takePhotoFromAlbum:YES isPhoto:YES withBlock:^(NSDictionary *info, UIImage *image) {
                        
                        [self.addimageBaseView addNewResoure:image];

                    } withVC:withvc];
 
                }
                
            }];
        }else if (buttonIndex == 1){
            [UIActionSheet showInView:self.view withTitle:@"选择视频来源" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"相机",@"相册"] tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {

                if(buttonIndex == 0 ){
                    [self takePhotoFromAlbum:NO isPhoto:NO withBlock:^(NSDictionary *info, UIImage *image) {

                        [self.addimageBaseView addNewResoure:info];

                    } withVC:withvc];
                }else if(buttonIndex == 1 ){
                    [self takePhotoFromAlbum:YES isPhoto:NO withBlock:^(NSDictionary *info, UIImage *image) {
                       
                        [self.addimageBaseView addNewResoure:info];

                    } withVC:withvc];
                }
                 
            }];
        }else if (buttonIndex == 2){
            ///录音
            
        }
        
    }];
}
-(void)config1
{
    self.devname.text = [NSString stringWithFormat:@"设备名称:%@",self.o.name];

    self.MODEL.text = [NSString stringWithFormat:@"设备型号:%@",self.o.model];
    self.SN.text = [NSString stringWithFormat:@"设备序号:%@",self.o.serial];
    
    self.name.text = [UserObject sharedInstance].trueName;
    self.phone.text = [UserObject sharedInstance].mobile;
    
    
    
}
- (IBAction)paiz:(id)sender {
}
- (IBAction)video:(id)sender {
}
- (void)connection:(NSURLConnection *)connection
   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    self.hud.progress = totalBytesWritten/(CGFloat)totalBytesExpectedToWrite;
    NSLog(@"%9d = %9d = %9d " ,totalBytesExpectedToWrite,totalBytesWritten , bytesWritten );

    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self showMsg:nil error:error];

}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{

}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSData * data22 = data;
    NSString *responseString = [[NSString alloc] initWithData:data22 encoding:NSUTF8StringEncoding];
    responseString = [NetManager removiewHuhao:responseString];
    NSLog(@"respone = %@",responseString);
    
    
    [[GCDQueue mainQueue]queueBlock:^{
        [MBProgressHUD hideAllHUDsForView:self.view.window animated:1];
        
        if([responseString isEqualToString:@"1"]){
            
            
            [[GCDQueue mainQueue]queueBlock:^{
                [UIAlertView showWithTitle:@"" message:@"报修成功" cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    
                    [self.navigationController popViewControllerAnimated:1];
                    
                }];
                
            }];
            
            
        }else{
            [self showMsg:responseString error:nil];
        }
    }];

}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}



- (IBAction)commitAct:(id)sender {
    if (NO == [self checkData]) {
        return;
    }
//    [MBProgressHUD showHUDAddedTo:self.view.window animated:1];
    
    self.hud = [[MBProgressHUD alloc]initWithFrame:self.view.window.frame];
    [self.view.window addSubview:self.hud];
    [self.hud show:YES];
    
    NSMutableArray *images = [NSMutableArray array];
    NSMutableArray *videos = [NSMutableArray array];
    for (id resoure in self.addimageBaseView.resoureArray ) {
        if ([resoure isKindOfClass:[UIImage class]]) {
            [images addObject:resoure];
        }else{
            [videos addObject:resoure];
        }
    }
    
    if (  1   ) {
        
        self.hud.mode = MBProgressHUDModeDeterminate;

        
        _req =  [NetManager setEquipmentRepairID:self.o.id contact:self.name.text tele:self.phone.text detail:self.remark.text images:images videos:videos delegate:self block:^(NSArray *array, NSError *error, NSString *msg) {
        }];
        [_req setTimeoutInterval:300];
        
        [[GCDQueue globalQueue]queueBlock:^{
            
        }];
        NSOperationQueue *queue =  [ NSOperationQueue currentQueue];
        _connec = [[NSURLConnection alloc] initWithRequest:_req delegate:self startImmediately:NO];
        //    [_connec setDelegateQueue:queue];
        [_connec start];
        
        return;
        
    }
    
    
    
    [[GCDQueue globalQueue]queueBlock:^{
        [NetManager setEquipmentRepairID:self.o.id contact:self.name.text tele:self.phone.text detail:self.remark.text images:images videos:videos delegate:self block:^(NSArray *array, NSError *error, NSString *msg) {
            
            [[GCDQueue mainQueue]queueBlock:^{
                [MBProgressHUD hideAllHUDsForView:self.view.window animated:1];
                
                if (array != nil) {
                    
                    [[GCDQueue mainQueue]queueBlock:^{
                        [UIAlertView showWithTitle:@"" message:@"报修成功" cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {

                            [self.navigationController popViewControllerAnimated:1];
                            
                        }];
                        
                    }];
                    
                    
                }else{
                    [self showMsg:msg error:error];
                }
            }];
            
            
        }];

    }];
    
    
    
}
-(BOOL)checkData
{
    if (self.name.text.length == 0) {
        [self.name becomeFirstResponder];
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入联系人"];
        return NO;
    }
    if (self.phone.text.length == 0) {
        [self.phone becomeFirstResponder];
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入联系人电话"];
        return NO;
    }
    if (self.remark.text.length == 0) {
        [self.remark becomeFirstResponder];
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入保修详情"];
        return NO;
    }
    
    return 1;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
            
//            [self.withVC presentViewController:picker animated:YES completion:^{
//                //        NSLog(@" 显示 picker  的view");
//            }];
            
        }
    }
    
    else{
        
        
        
        
//        [self.withVC presentViewController:picker animated:YES completion:^{
//            //        NSLog(@" 显示 picker  的view");
//        }];
        
    }
    
    
    if (isPhoto) {
//        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    }else{
        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, (NSString *)kUTTypeVideo ,nil];
        picker.videoQuality = UIImagePickerControllerQualityType640x480;
//todo  baochun,yashuo
        picker.videoMaximumDuration = 20;
        
        
    }

    
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
    
    [self.withVC  presentViewController:picker animated:YES completion:^{
        //   NSLog(@" 显示 picker  的view");
        
        
    }];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image =  info[UIImagePickerControllerOriginalImage];;
    //    self.image.image = image;
    //    self.image.contentMode = UIViewContentModeScaleAspectFit;
    
    [[GCDQueue mainQueue]queueBlock:^{
        if(self.block1)
            self.block1(info,image);
        
    }];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    

    [self imagePickerControllerDidCancel:picker];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.withVC dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    UIAlertView *alert;
    
    if (error)
    {
        alert = [[UIAlertView alloc] initWithTitle:@"错误"
                                           message:@"保存失败"
                                          delegate:self cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil];
    }
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:@"成功"
                                           message:@"保存成功"
                                          delegate:self cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil];
    }
    [alert show];
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
