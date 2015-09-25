//
//  InfoViewController.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "InfoViewController.h"
#import <UIButton+WebCache.h>
#import <MJRefresh/UIView+MJExtension.h>
#import "NetManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIActionSheet+Blocks/UIActionSheet+Blocks.h>

@interface InfoCell:UIView

@property (strong,nonatomic) UILabel *title;
@property (strong,nonatomic) UITextField *editDetail;
@property (strong,nonatomic) UILabel *showDetail;
@property (strong,nonatomic) UILabel *SEP;

@property (assign,nonatomic) BOOL isEditing;
@property (assign,nonatomic) CGFloat width;

-(CGFloat)fitSizeWithY:(CGFloat)y m:(CGFloat*)m;

@end
@implementation InfoCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 600, 30)];
        self.editDetail = [[UITextField alloc]initWithFrame:CGRectMake(60, 0, 600, 30)];
        self.showDetail = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 600, 30)];
        self.SEP = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 600, 0.5)];
        
        self.title.font = [UIFont systemFontOfSize:15];
        self.editDetail.font = [UIFont systemFontOfSize:15];
        self.showDetail.font = [UIFont systemFontOfSize:15];

        self.title.textAlignment = NSTextAlignmentCenter;;
//        self.editDetail.textAlignment = NSTextAlignmentCenter;;
//        self.showDetail.textAlignment = NSTextAlignmentCenter;;

        self.SEP.backgroundColor = [UIColor grayColor];
        self.editDetail.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        
        [self addSubview:self.title];
        [self addSubview:self.editDetail];
        [self addSubview:self.showDetail];
        [self addSubview:self.SEP];
        
        
    }
    return self;
}
-(void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;

    if (isEditing ==YES) {
        self.editDetail.hidden = 0;
        self.showDetail.hidden = 1;
        
    }else{
        self.editDetail.hidden = 1;
        self.showDetail.hidden = 0;
        
    }
    
}

+(InfoCell *)getView:(NSString *)title detail:(NSString*)detail width:(CGFloat)width
{
    InfoCell *CELL = [[InfoCell alloc]initWithFrame:CGRectMake(-1, 0, width+2, 40)];
    CELL.title.text = title;
    CELL.showDetail.text = detail;
    CELL.editDetail.text = detail;
    if (CELL.showDetail.text.length == 0) {
        CELL.showDetail.text = @"完善资料";
    }
    
    CELL.isEditing = NO;
    CELL.width = width;
    
    CELL.SEP.mj_w = width;
    
    return CELL;
}
-(CGFloat)fitSizeWithY:(CGFloat)y m:(CGFloat*)m
{
    self.mj_y = y   ;
    self.title.mj_x = 8;
    
    CGSize size1 = [self.title sizeThatFits:CGSizeMake(10, 30)];
    
    self.title.frame = CGRectMake(8, 0, size1.width, 30);
    if (size1.width < 60) {
        self.title.mj_w = 60;
    }
    
    
    
    
    
    CGSize SIZE = [self.showDetail sizeThatFits:CGSizeMake( _width - CGRectGetMaxX(self.title.frame)-8, 1000)];
    
    self.showDetail.frame = CGRectMake(CGRectGetMaxX(self.title.frame)+8, 0 , _width - CGRectGetMaxX(self.title.frame)-8, SIZE.height);
    
    if (self.showDetail.frame.size.height < 30) {
        self.showDetail.mj_h = 30;
    }
    
    
    
    if (_isEditing == NO    ) {
        
        
    }else{
        
    }
    
    self.editDetail.frame = self.showDetail.frame;
    
    
    self.mj_h = self.showDetail.mj_h;
    self.SEP.mj_y = self.showDetail.mj_h-0.5;
    
    return  y+ self.showDetail.mj_h;

    
    
    
    
    return 0;
}
@end

@interface InfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong,nonatomic ) NSMutableArray *cellArray;
@property (assign,nonatomic ) BOOL isEditing;
@property (strong,nonatomic ) UIImage  *image;

@end

@implementation InfoViewController
-(void)dealHeadView
{
    if ([UserObject hadLog]     )
    {
        self.loginView.hidden = 0;
        
        
        [self.icon sd_setImageWithURL:[NSURL URLWithString:[UserObject sharedInstance].head ]
                             forState:0
                     placeholderImage:[UIImage imageNamed:@"Avatar.jpg"]
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            }];
        
        self.phone.text = [UserObject sharedInstance].mobile ;
        
    }
    
}

-(void)AddInfoView
{
    NSArray *titles = @[@"公司名称",@"姓名",@"职务",@"邮件",@"传真",@"地址"];
    NSMutableArray *details = [NSMutableArray array ];
    [details addObject:[[UserObject sharedInstance] companyName]?[[UserObject sharedInstance] companyName]  :@""];
    [details addObject:[[UserObject sharedInstance] trueName]   ?[[UserObject sharedInstance] trueName]     :@""];
    [details addObject:[[UserObject sharedInstance] duty]       ?[[UserObject sharedInstance] duty]         :@""];
    
    [details addObject:[[UserObject sharedInstance] email]      ?[[UserObject sharedInstance] email]        :@""];
    [details addObject:[[UserObject sharedInstance] fax]        ?[[UserObject sharedInstance] fax]          :@""];
    [details addObject:[[UserObject sharedInstance] address]    ?[[UserObject sharedInstance] address]      :@""];
    
    
    CGFloat y =  self.bgView.frame.size.height;
    
    self.cellArray = [NSMutableArray array];
    for (int I =0 ; I<details.count; I++) {
        InfoCell *CELL = [InfoCell getView:titles[I] detail:details[I] width:[[UIScreen mainScreen] bounds].size.width];

        y = [CELL fitSizeWithY:y m:&y];
        
        [self.view addSubview:CELL ];
        
        [self.cellArray addObject:CELL];
        
    }
    
}
-(void)rightButtonTouch{
    self.isEditing = !self.isEditing;
    
    if (self.isEditing ) {
        [self showBarButton:NAV_RIGHT title:@"完成" fontColor:[UIColor whiteColor]];

        for (int I =0 ; I<self.cellArray.count; I++) {
            InfoCell *CELL = self.cellArray[I];
            CELL.isEditing = YES;
            
        }
        InfoCell *CELL = self.cellArray[0];
        [CELL.editDetail becomeFirstResponder];
        
        
    }else{
        [self showBarButton:NAV_RIGHT title:@"编辑" fontColor:[UIColor whiteColor]];
        
        NSMutableArray *INFOS = [NSMutableArray array];
        for (int I =0 ; I<self.cellArray.count; I++) {
            InfoCell *CELL = self.cellArray[I];

            [INFOS addObject:CELL.editDetail.text.length?CELL.editDetail.text:@""];
            
        }
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSArray *titles = @[@"公司名称",@"姓名",@"职务",@"邮件",@"传真",@"地址"];
        
        [NetManager wanshanziliao:INFOS[1] companyName:INFOS[0] duty:INFOS[2] email:INFOS[3] fax:INFOS[4] address:INFOS[5] isModify:YES block:^(NSArray *array, NSError *error, NSString *msg) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:1];
            
            if (array != nil) {
                
                [[GCDQueue mainQueue]queueBlock:^{
                    
                    NSString *STRING = [array firstObject];
                    if ([STRING isKindOfClass:[NSString class]] && STRING.length != 0   ) {
                        [[DialogUtil sharedInstance]showDlg:self.view.window textOnly:STRING];
                    }
                    UserObject *INFO = [[UserObject alloc] init];
                    INFO.trueName = INFOS[1] ;
                    INFO.companyName = INFOS[0] ;
                    INFO.duty = INFOS[2] ;
                    INFO.email = INFOS[3] ;
                    INFO.fax = INFOS[4] ;
                    INFO.address = INFOS[5] ;
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:UseriNFOChandedNoti object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:INFO,@"info", nil]];
                    
                    [self.navigationController popViewControllerAnimated:1];
                    
                }];
                
            }else{
                [self showMsg:msg error:error];
            }

        }];
        return;
        
        [NetManager setUserInfotrueName:INFOS[1] companyName:INFOS[0] duty:INFOS[2] email:INFOS[3] fax:INFOS[4] address:INFOS[5] sex:0 block:^(NSArray *array, NSError *error, NSString *msg) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:1];
            
            if (array != nil) {
                
                [[GCDQueue mainQueue]queueBlock:^{
                    
                    NSString *STRING = [array firstObject];
                    if ([STRING isKindOfClass:[NSString class]] && STRING.length != 0   ) {
                        [[DialogUtil sharedInstance]showDlg:self.view.window textOnly:STRING];
                    }
                    UserObject *INFO = [[UserObject alloc] init];
                    INFO.trueName = INFOS[1] ;
                    INFO.companyName = INFOS[0] ;
                    INFO.duty = INFOS[2] ;
                    INFO.email = INFOS[3] ;
                    INFO.fax = INFOS[4] ;
                    INFO.address = INFOS[5] ;
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:UseriNFOChandedNoti object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:INFO,@"info", nil]];

                    [self.navigationController popViewControllerAnimated:1];
                    
                }];
                
            }else{
                [self showMsg:msg error:error];
            }
            
        }];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#if USENormalPush
    self.edgesForExtendedLayout = UIRectEdgeNone;
#endif
    
    _icon.layer.cornerRadius = _icon.width/2;
    _icon.clipsToBounds= 1;
    
    self.editInfoBtn.hidden=1;
    self.p.hidden=1;
    
    self.title = @"我的资料";
    
    //    self.tableView.delegate = self;
    //    self.mytableview.dataSource = self;
    //
    self.view.backgroundColor = RGB(236, 236, 236);
    [self showBarButton:NAV_RIGHT title:@"编辑" fontColor:[UIColor whiteColor]];
    
    [self dealHeadView];
    [self AddInfoView];
    
    [self.icon addTarget:self action:@selector(iconAct:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)iconAct:(UIButton*)SENDER
{
    [UIActionSheet showInView:self.view withTitle:@"设置头像" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照",@"相册" ] tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
        if (buttonIndex ==  0) {
            [self takePhotoFromAlbum:0 isPhoto:1];
        }else if (buttonIndex ==  1){
            [self takePhotoFromAlbum:1 isPhoto:1];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.image = image;
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{

        [MBProgressHUD showHUDAddedTo:self.view animated:1];

        [NetManager uploadHead:image block:^(NSArray *array, NSError *error, NSString *msg) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:1];
            
            if (array != nil) {
                
                [[GCDQueue mainQueue]queueBlock:^{
                    
                    NSString *STRING = [array firstObject];
                    if ([STRING isKindOfClass:[NSString class]] && STRING.length != 0   ) {
                        [[DialogUtil sharedInstance]showDlg:self.view.window textOnly:STRING];
                    }
                    [UserObject sharedInstance].head = STRING;

                    [[NSNotificationCenter defaultCenter]postNotificationName:HeadImageChandedNoti object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:image,@"image", nil]];
                    
                     
                    
                }];
                
            }else{
                [self showMsg:msg error:error];
            }

        }];
        
        
    }];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
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
