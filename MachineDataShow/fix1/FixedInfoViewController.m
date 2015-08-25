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

@interface FixedInfoViewController ()
@property (weak, nonatomic) IBOutlet UIView *TOPvIEW;
@property (weak, nonatomic) IBOutlet UILabel *MODEL;
@property (weak, nonatomic) IBOutlet UILabel *SN;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextView *remark;
@property (weak, nonatomic) IBOutlet UIButton *takeImage;
@property (weak, nonatomic) IBOutlet UIButton *takeVideo;

@property (weak, nonatomic) IBOutlet UIButton *commit;


@property (weak, nonatomic) IBOutlet AddMediaBaseView *addimageBaseView;

@end

@implementation FixedInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"申请维修";
    
    [self config1];
    
}
-(void)config1
{
    
    self.MODEL.text = [NSString stringWithFormat:@"设备型号:%@",self.o.model];
    self.SN.text = [NSString stringWithFormat:@"设备序号:%@",self.o.serial];
    
    self.name.text = [UserObject sharedInstance].trueName;
    self.phone.text = [UserObject sharedInstance].mobile;
    
    
    
}
- (IBAction)paiz:(id)sender {
}
- (IBAction)video:(id)sender {
}
- (IBAction)commitAct:(id)sender {
    if (NO == [self checkData]) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:1];

 
    [NetManager setEquipmentRepairID:self.o.id contact:self.name.text tele:self.phone.text detail:self.remark.text voiceId:nil imageId:nil videoId:nil block:^(NSArray *array, NSError *error, NSString *msg) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:1];
        
        if (array != nil) {
            
            
            [[GCDQueue mainQueue]queueBlock:^{
                [self.navigationController popViewControllerAnimated:1];
                
            }];
            

        }else{
            [self showMsg:msg error:error];
        }
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
