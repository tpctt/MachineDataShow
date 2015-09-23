//
//  Reg2ViewController.h
//  MachineDataShow
//
//  Created by tim on 15-9-19.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "BaseViewController.h"

@interface Reg2ViewController : BaseViewController
///手机号、公司名称、姓名、职务、邮件、传真、地址、密码、验证码

@property (weak, nonatomic) IBOutlet UITextField *company;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *job;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *fax;
@property (weak, nonatomic) IBOutlet UITextField *addresss;

//@property (weak, nonatomic) IBOutlet UITextField *pwd1;
//@property (weak, nonatomic) IBOutlet UITextField *pwd2;
//
//
//@property (weak, nonatomic) IBOutlet UITextField *verifyText;
//@property (weak, nonatomic) IBOutlet UIButton *verfiyBtn;

@property (weak, nonatomic) IBOutlet UIButton *regBtn;
//@property (weak, nonatomic) IBOutlet UIButton * checkBtn;

@end
