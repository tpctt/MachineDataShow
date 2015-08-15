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
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *p1;
@property (weak, nonatomic) IBOutlet UITextField *p2;
@property (weak, nonatomic) IBOutlet UITextField *verifyText;
@property (weak, nonatomic) IBOutlet UIButton *verfiyBtn;

@property (weak, nonatomic) IBOutlet UIButton *regBtn;
@property (weak, nonatomic) IBOutlet UIButton * checkBtn;

@property (strong, nonatomic)   RACDisposable *timer;
@property (assign, nonatomic)   NSTimeInterval timeIN;

@end

@implementation RegViewController
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
        
        self.timer = [[RACScheduler scheduler] after:[NSDate date] repeatingEvery:1 withLeeway:1 schedule:^{
            [[GCDQueue mainQueue]queueBlock:^{
                _timeIN--;
                if (_timeIN >1 ) {
                    NSString *STR = [NSString stringWithFormat:@"%.0f S",_timeIN ];
                    [self.verfiyBtn setTitle:STR forState:UIControlStateDisabled];
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
    BOOL nameValie = self.name.text.length>=3&&self.name.text.length<=15;
    if (nameValie==NO) {
        [DialogUtil showDlgAlert:@"请输入正确的用户名,3-15个字符"];
        return NO;
    }
    BOOL pwd1Valie = self.p1.text.length>=6&&self.p2.text.length<=20;
    if (pwd1Valie==NO) {
        [DialogUtil showDlgAlert:@"请输入正确的密码,6-20个字符"];
        return NO;
    }
    if ([self.p1.text isEqualToString:self.p2.text  ]==NO) {
        [DialogUtil showDlgAlert:@"2次输入的密码不一样"];
        return NO;
    }
    return 1;
    
}
- (IBAction)regBtnAct:(id)sender {
    if([self checkData]==NO)
        return;
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [NetManager emailReg:self.name.text name:self.name.text pwd:self.p1.text block:^(LoginObject *object, NSError *error, NSString *msg) {
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
    BOOL value = [_p1.text isEqualToString:_p2.text];
    return value;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RAC(self.verfiyBtn,enabled) = [RACSignal
                                  combineLatest:@[self.name.rac_textSignal,
                                                  self.p1.rac_textSignal,self.p2.rac_textSignal
                                                  ]
                                  reduce:^(NSString *name, NSString *p1 , NSString *p2){
                                      return @(name.length > 0 && p1.length > 0  && p2.length> 0  );
                                  }];
    
    
    RAC(self.regBtn,enabled) = [RACSignal
                                   combineLatest:@[self.name.rac_textSignal,
                                                   self.p1.rac_textSignal,self.p2.rac_textSignal,self.verifyText.rac_textSignal
                                                   ]
                                   reduce:^(NSString *name, NSString *p1 , NSString *p2,NSString *verifyText ){
                                       return @(name.length > 0 && p1.length > 0  && p2.length> 0&& verifyText.length> 0  );
                                   }];
    
    [RACObserve(self.name, rac_textSignal)
     subscribeNext:^(id x) {
         
         if (self.name.text.length>=3&&self.name.text.length<=16 ) {
             self.name.textColor = [UIColor blackColor];
             
         }else{
             self.name.textColor = [UIColor redColor];
             
         }
     }];
    
    [self.verfiyBtn setTitle:@"获取验证码" forState:0];
    [self.verfiyBtn setTitle:@"获取验证码" forState:UIControlStateDisabled];
    
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
