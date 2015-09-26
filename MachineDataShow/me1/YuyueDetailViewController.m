//
//  YuyueDetailViewController.m
//  MachineDataShow
//
//  Created by tim on 15-9-5.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "YuyueDetailViewController.h"
#import "NetManager.h"
@interface YuyueDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation YuyueDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ///getAppointmentInfo.php
    
    self.title = @"预约详情";
    self. label.text = [NSString stringWithFormat:@"预约号：%@",self.OBJ.id ];
    
    
    return;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [NetManager yuyueDetail:self.OBJ.id block:^(NSArray *array, NSError *error, NSString *msg) {
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
