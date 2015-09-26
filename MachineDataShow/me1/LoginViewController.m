//
//  LoginViewController.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "LoginViewController.h"
#import "NetManager.h"
#import <GCDObjC/GCDObjC.h>
#import "BaseObject.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *regBtn;

@end

@implementation LoginViewController
- (IBAction)loginAct:(id)sender {
    if ([self check] == NO) {
        return;
    }
    
    [LoginObject sharedInstance].username = _name.text;
    [LoginObject sharedInstance].session_token = _name.text;
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:FLlogin object:nil];
//
//    [self.navigationController popViewControllerAnimated:YES];
//    
//    
//    return;
    
    ///apia31235    123456
    [[NSUserDefaults standardUserDefaults] setObject:self.name.text forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject:self.pwd.text forKey:@"pwd"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NetManager LogMobile:self.name.text password:self.pwd.text
                block:^(NSArray *array, NSError *error, NSString *msg) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                    NSString *object = [array firstObject];
                    if (object) {
                        [[NSNotificationCenter defaultCenter]postNotificationName:FLlogin object:nil];

                        [[GCDQueue mainQueue] queueBlock:^{
                            
                            [self.navigationController popViewControllerAnimated:YES];
                            
                        }];
                        
                    }else{
                        if(msg){
                            [UIAlertView showWithTitle:@"提示" message:msg cancelButtonTitle:@"确认" otherButtonTitles:nil tapBlock:nil];
                            
                        }else{
                            
                            [UIAlertView showWithTitle:@"提示" message:error.localizedDescription cancelButtonTitle:@"确认" otherButtonTitles:nil tapBlock:nil];
                            
                        }
                    }
                }];
    
   

}
- (IBAction)regAct:(id)sender {
    
}
-(BOOL)check
{
    if (self.name.text.length != 11  ) {
        [self.name becomeFirstResponder];
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入11位手机号"];
        return NO;
    }
    
    else if (self.pwd.text.length == 0)
    {
        [self.pwd becomeFirstResponder];
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入密码"];

        return NO;
    }
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"登陆";
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"button_bg_long_gray"] forState:UIControlStateDisabled];
    
    
    self.name.text =  [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    self.pwd.text =  [[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"];
    
    
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
