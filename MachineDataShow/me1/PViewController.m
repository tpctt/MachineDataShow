//
//  PViewController.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "PViewController.h"
#import "NetManager.h"
@interface PViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sure;
@property (weak, nonatomic) IBOutlet UITextField *p1;
@property (weak, nonatomic) IBOutlet UITextField *p2;

@end

@implementation PViewController
- (IBAction)btnAct:(id)sender {
//    if ([self checkPwd]==NO) {
//        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"2次输入的密码不匹配"];;
//        return;
//    }

    if (self.p1.text.length == 0) {
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入输入旧密码"];;
        return;
    }
    if (self.p2.text.length == 0) {
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入输入新密码"];;
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:1];
    
    [NetManager setpassword:self.p1.text  password:self.p2.text block:^(NSArray *array, NSError *error, NSString *msg) {

        [MBProgressHUD hideAllHUDsForView:self.view animated:1];
        
        if (array != nil) {
            
            [[GCDQueue mainQueue]queueBlock:^{
                NSString *STRING = [array firstObject];
                if ([STRING isKindOfClass:[NSString class]] && STRING.length != 0   ) {
                    
                    [[NSUserDefaults standardUserDefaults]setObject:self.p1.text forKey:@"pwd"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    [UIAlertView showWithTitle:@"" message:@"修改密码成功" cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                       
                        [self.navigationController popViewControllerAnimated:1];
                        
                    }];
                    
//                    [[DialogUtil sharedInstance]showDlg:self.view.window textOnly:STRING];
                }
                
            }];
            
        }else{
            [self showMsg:msg error:error];
        }
        
    }];
    

}
-(BOOL)checkPwd
{
    BOOL value = [_p1.text isEqualToString:_p2.text];
    return value;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    
    RAC(self.sure,enabled) = [RACSignal
                                  combineLatest:@[self.p1.rac_textSignal,
                                                  self.p2.rac_textSignal
                                                  ]
                                  reduce:^(NSString *name, NSString *pwd ){
                                      return @(name.length > 0 && pwd.length > 0  );
                                  }];
    [self.sure setBackgroundImage:[UIImage imageNamed:@"button_bg_long_gray"] forState:UIControlStateDisabled];
    self.p1.secureTextEntry = 1;
    self.p2.secureTextEntry = 1;
    self.p1.clearsOnBeginEditing=1;
    self.p2.clearsOnBeginEditing=1;
    self.p1.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.p2.clearButtonMode=UITextFieldViewModeWhileEditing;
    
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
