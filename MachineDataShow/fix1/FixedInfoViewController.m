//
//  FixedInfoViewController.m
//  MachineDataShow
//
//  Created by tim on 15-8-15.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "FixedInfoViewController.h"

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
    
    self.MODEL.text = [NSString stringWithFormat:@"设备型号:%@",self.o.mode];
    self.SN.text = [NSString stringWithFormat:@"设备序号:%@",self.o.sn];
    
    self.name.text = [UserObject sharedInstance].username;
    self.phone.text = [UserObject sharedInstance].username;
    
    
    
}
- (IBAction)paiz:(id)sender {
}
- (IBAction)video:(id)sender {
}
- (IBAction)commitAct:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:1];
    sleep(2);
    [self.navigationController popViewControllerAnimated:1];
    
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
