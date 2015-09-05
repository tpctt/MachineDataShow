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
