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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:FLlogin object:nil];

    [self.navigationController popViewControllerAnimated:YES];
    
    
    return;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [NetManager login:self.name.text pwd:self.pwd.text aps:[[Config sharedInstance] aps_token] block:^(LoginObject *object, NSError *error, NSString *msg) {
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
    if (self.name.text.length == 0  ) {
        [self.name becomeFirstResponder];
        return NO;
    }else if (self.pwd.text.length == 0)
    {
        [self.pwd becomeFirstResponder];
        return NO;
    }
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RAC(self.loginBtn,enabled) = [RACSignal
                                   combineLatest:@[self.name.rac_textSignal,
                                                   self.pwd.rac_textSignal
                                                   ]
                                   reduce:^(NSString *name, NSString *pwd ){
                                       return @(name.length > 0 && pwd.length > 0  );
                                   }];
    self.title = @"登陆";
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"button_bg_long_gray"] forState:UIControlStateDisabled];
    
    [[[self.name.rac_textSignal
       map:^id(NSString*text){
           return @(text.length);
       }]
      filter:^BOOL(NSNumber*length){
          return[length integerValue] > 8;
      }]
     subscribeNext:^(id x){
         if (self.name.text.length==11) {
             self.name.textColor = [UIColor blackColor];
             
         }else{
             self.name.textColor = [UIColor redColor];
             
         }
     }];
    
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
