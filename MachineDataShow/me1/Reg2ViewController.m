//
//  Reg2ViewController.m
//  MachineDataShow
//
//  Created by tim on 15-9-19.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "Reg2ViewController.h"
#import "NetManager.h"


@interface Reg2ViewController ()
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *w1;

@end

@implementation Reg2ViewController



-(BOOL)checkData
{
//    BOOL phoneV = self.phone.text.length == 11;
//    if (phoneV==NO) {
//        [DialogUtil showDlgAlert:@"请输入正确的手机号,15个字符"];
//        return NO;
//    }
//    BOOL pwd1Valie = self.pwd1.text.length>=6&&self.pwd2.text.length<=20;
//    if (pwd1Valie==NO) {
//        [DialogUtil showDlgAlert:@"请输入正确的密码,6-20个字符"];
//        return NO;
//    }
//    if ([self.pwd1.text isEqualToString:self.pwd2.text  ]==NO) {
//        [DialogUtil showDlgAlert:@"2次输入的密码不一样"];
//        return NO;
//    }
    
    if (self.company.text.length == 0) {
        [DialogUtil showDlgAlert:@"请输入公司名称"];
        return NO;
    }
    
    if (self.username.text.length == 0) {
        [DialogUtil showDlgAlert:@"请输入姓名"];
        return NO;
    }
    if (self.job.text.length == 0) {
        [DialogUtil showDlgAlert:@"请输入职务"];
        return NO;
    }
    
    BOOL emailValie = [self isValidateEmail:self.email.text ];
    if (emailValie==NO) {
        [DialogUtil showDlgAlert:@"请输入正确的邮箱地址!"];
        return NO;
    }
    
    //    if (self.email.text.length == 0) {
    //        [DialogUtil showDlgAlert:@"请输入邮箱"];
    //        return NO;
    //    }
    if (self.fax.text.length == 0) {
        [DialogUtil showDlgAlert:@"请输入传真"];
        return NO;
    }
    
    if (self.addresss.text.length == 0) {
        [DialogUtil showDlgAlert:@"请输入地址"];
        return NO;
    }
    
    
    return 1;
    
}
- (IBAction)regBtnAct:(id)sender {
    if([self checkData]==NO)
        return;
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NetManager wanshanziliao:self.username.text
                  companyName:self.company.text
                         duty:self.job.text
                        email:self.email.text
                          fax:self.fax.text
                      address:self.addresss.text
                     isModify:NO
                        block:^(NSArray *array, NSError *error, NSString *msg) {
                            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                            
                            UserObject *OBJ = [array firstObject];
                            
                            if (OBJ) {
                                [[NSNotificationCenter defaultCenter]postNotificationName:FLlogin object:nil];

                                [[GCDQueue mainQueue] queueBlock:^{
                                    
                                     [self.navigationController popToRootViewControllerAnimated:YES];
                                    
                                }];
                            }
                            else
                            {
                                if(msg.length){
                                    [UIAlertView showWithTitle:@"提示" message:msg cancelButtonTitle:@"确认" otherButtonTitles:nil tapBlock:nil];
                                    
                                }else{
                                    
                                    [UIAlertView showWithTitle:@"提示" message:error.localizedDescription cancelButtonTitle:@"确认" otherButtonTitles:nil tapBlock:nil];
                                    
                                }
                            }
                            
                        }];
 
    
}
//利用正则表达式验证

-(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}
//-(BOOL)checkPwd
//{
//    BOOL value = [_pwd1.text isEqualToString:_pwd2.text];
//    return value;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    
    
    [self.regBtn setBackgroundImage:[UIImage imageNamed:@"button_bg_long_gray"] forState:UIControlStateDisabled];
    
    
    self.title = @"完善资料";
    [self showBarButton:NAV_RIGHT title:@"跳过" fontColor:[UIColor blackColor]];
}
-(void)rightButtonTouch
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)leftButtonTouch
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
