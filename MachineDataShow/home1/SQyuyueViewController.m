//
//  SQyuyueViewController.m
//  MachineDataShow
//
//  Created by tim on 15-9-5.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "SQyuyueViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <EasyIOS/TimeTool.h>
#import "NetManager.h"

@interface SQyuyueViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *basevview;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *num;
@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UITextField *job;

@property (weak, nonatomic) IBOutlet UITextField *time;

@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *otherinfo;

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *w1;
@property (strong, nonatomic)   UIDatePicker *datepicker;

@end

@implementation SQyuyueViewController
-(void)updateViewConstraints
{
    [super updateViewConstraints];
    self.w1.constant = self.view.width;
    
}
- (IBAction)commitBtnAct:(id)sender {
    if (self.name.text.length == 0 ) {
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入公司名称"];
        [self.name becomeFirstResponder];
        return;
        
    }
    
    if (self.num.text.length == 0 ) {
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入预约人数"];
        [self.num becomeFirstResponder];
        return;
        
    }
    
    if (self.job.text.length == 0 ) {
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入预约人职务"];
        [self.job becomeFirstResponder];
        return;
        
    }
    if (self.phone.text.length == 0 ) {
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入联系方式"];
        [self.phone becomeFirstResponder];
        return;
        
    }
    if (self.time.text.length == 0 ) {
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入预约时间"];
        [self.time becomeFirstResponder];
        return;
        
    }
    if (self.otherinfo.text.length == 0 ) {
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入预约描述"];
        [self.otherinfo becomeFirstResponder];
        return;
        
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NetManager yuyue:self.name.text peoplesum:self.num.text duty:self.job.text tele:self.phone.text time:self.time.text desc:self.otherinfo.text block:^(NSArray *array, NSError *error, NSString *msg) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (array) {
            
            [[GCDQueue mainQueue] queueBlock:^{
                [[DialogUtil sharedInstance]showDlg:self.view.window textOnly:msg];

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"预约参观";
    
    self.otherinfo.placeholder = @"备注信息";
    
    [IQKeyboardManager sharedManager].toolbarManageBehaviour = IQAutoToolbarByPosition ;
    
    self.datepicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, 240, 243)];
    self.datepicker.datePickerMode = UIDatePickerModeDate;
    self.datepicker.minimumDate = [NSDate date];
    
    self.time.inputView = self.datepicker;
    [[self.datepicker rac_newDateChannelWithNilValue:[NSDate date]]subscribeNext:^(id x) {
        self.time.text = [TimeTool formatDate:self.datepicker.date formatWith:@"yyyy-MM-dd"];
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
