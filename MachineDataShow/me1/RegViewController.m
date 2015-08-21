//
//  RegViewController.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "RegViewController.h"
#import <EasyIOS/DialogUtil.h>
#import "NetManager.h"
#import "BaseObject.h"

@interface RegViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *w1;

@end

@implementation RegViewController
-(void)updateViewConstraints
{
    [super updateViewConstraints];
    self.w1.constant = self.view.width;
    
}
- (IBAction)regAct:(id)sender {
    if ([self checkPwd]==NO) {
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"2次输入的密码不匹配"];;
    }
    
    
}
- (IBAction)verfiyAct:(id)sender {
    if ([self checkPwd]==NO) {
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"2次输入的密码不匹配"];;
    }
    if ( _timeIN<=1) {
        [self.timer dispose];
        self.timer = nil;
        
        [self.verfiyBtn setTitle:@"获取验证码" forState:0];
        self.verfiyBtn.titleLabel.text = @"获取验证码";
        self.verfiyBtn.enabled = 1;
        
        _timeIN = 120;

    }else{
        
        self.timer = [[RACScheduler scheduler] after:[NSDate date] repeatingEvery:1 withLeeway:0.1 schedule:^{
            [[GCDQueue mainQueue]queueBlock:^{
                _timeIN--;
                if (_timeIN >1 ) {
                    NSString *STR = [NSString stringWithFormat:@"%.0f 秒",_timeIN ];
                    
                    [self.verfiyBtn setTitle:STR forState:UIControlStateDisabled];
                    [self.verfiyBtn setTitle:STR forState:0];
                    self.verfiyBtn.titleLabel.text = STR;
                    self.verfiyBtn.enabled = 0;
                    
                    
                }
            }];
        }];
    }
    
    
    
}

- (IBAction)checkBtnAct:(id)sender {
    
//    XieyiViewController *vc = [[XieyiViewController alloc]init];
//    
//    [self.navigationController pushViewController:vc animated:1];
    
    
}
- (IBAction)checkBtnAct2:(id)sender forEvent:(UIEvent *)event {
    UITouch *touches = [event.allTouches anyObject];
    CGPoint loc = [touches locationInView:self.checkBtn];
    if(loc.x < 60 ){
        self.checkBtn.selected = !self.checkBtn.selected;
        
    }else {
        [self checkBtnAct:nil];
    }
}
-(BOOL)checkData
{
//    BOOL emailValie = [self isValidateEmail:self.email.text ];
//    if (emailValie==NO) {
//        [DialogUtil showDlgAlert:@"请输入正确的邮箱地址!"];
//        return NO;
//    }
    BOOL phoneV = self.phone.text.length == 11;
    if (phoneV==NO) {
        [DialogUtil showDlgAlert:@"请输入正确的手机号,15个字符"];
        return NO;
    }
    BOOL pwd1Valie = self.pwd1.text.length>=6&&self.pwd2.text.length<=20;
    if (pwd1Valie==NO) {
        [DialogUtil showDlgAlert:@"请输入正确的密码,6-20个字符"];
        return NO;
    }
    if ([self.pwd1.text isEqualToString:self.pwd2.text  ]==NO) {
        [DialogUtil showDlgAlert:@"2次输入的密码不一样"];
        return NO;
    }
    
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
    if (self.email.text.length == 0) {
        [DialogUtil showDlgAlert:@"请输入邮箱"];
        return NO;
    }
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
    [NetManager RegMobile:self.phone.text
                 password:self.pwd1.text
                 trueName:self.username.text
              companyName:self.company.text
                     duty:self.job.text
                    email:self.email.text
                      fax:self.fax.text
                  address:self.addresss.text
                    block:^(LoginObject *object, NSError *error, NSString *msg) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (object) {
            
            [[GCDQueue mainQueue] queueBlock:^{
                [LoginObject sharedInstance].userid = object.userid;
                [LoginObject sharedInstance].session_token = object.session_token;
                [LoginObject sharedInstance].username = object.username;
                [LoginObject sharedInstance].avatar = object.avatar;
                
                [BaseObjectRequest sharedInstance].userid = object.userid;
                [BaseObjectRequest sharedInstance].session_token = object.session_token;
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
            
        }
        //        else
        {
            if(msg){
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
-(BOOL)checkPwd
{
    BOOL value = [_pwd1.text isEqualToString:_pwd2.text];
    return value;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RAC(self.verfiyBtn,enabled) = [RACSignal
                                  combineLatest:@[self.phone.rac_textSignal,
                                                  self.pwd1.rac_textSignal,self.pwd2.rac_textSignal
                                                  ]
                                  reduce:^(NSString *name, NSString *p1 , NSString *p2){
                                      return @(name.length > 0 && p1.length > 0  && p2.length> 0  );
                                  }];
    
    
    RAC(self.regBtn,enabled) = [RACSignal
                                   combineLatest:@[self.phone.rac_textSignal,
                                                   self.pwd1.rac_textSignal,self.pwd2.rac_textSignal,self.verifyText.rac_textSignal
                                                   ]
                                   reduce:^(NSString *name, NSString *p1 , NSString *p2,NSString *verifyText ){
                                       return @(name.length > 0 && p1.length > 0  && p2.length> 0&& verifyText.length> 0  );
                                   }];
    
    [[[self.phone.rac_textSignal
       map:^id(NSString*text){
           return @(text.length);
       }]
      filter:^BOOL(NSNumber*length){
          return[length integerValue] > 8;
      }]
     subscribeNext:^(id x){
         if (self.phone.text.length==11) {
             self.phone.textColor = [UIColor blackColor];
             
         }else{
             self.phone.textColor = [UIColor redColor];
             
         }
     }];
    
    [RACObserve(self.phone, rac_textSignal)
     subscribeNext:^(id x) {
         
        
     }];
    
    [self.verfiyBtn setTitle:@"获取验证码" forState:0];
    [self.verfiyBtn setTitle:@"获取验证码" forState:UIControlStateDisabled];
    
    [self.verfiyBtn setBackgroundImage:[UIImage imageNamed:@"button_bg_long_gray"] forState:UIControlStateDisabled];
    [self.regBtn setBackgroundImage:[UIImage imageNamed:@"button_bg_long_gray"] forState:UIControlStateDisabled];
    
    
    NSMutableAttributedString *str = [self.checkBtn.titleLabel.attributedText mutableCopy];
    NSRange strRange = [self.checkBtn.titleLabel.text rangeOfString:@"注册协议"];
    
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:strRange];
    
    [self.checkBtn setAttributedTitle:str forState:UIControlStateNormal];
    
    self.title = @"注册";

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
