//
//  GCSBViewController.m
//  MachineDataShow
//
//  Created by tim on 15-9-5.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "GCSBViewController.h"

///工厂设备cell
@interface GCSBCell :UITableViewCell

///设备名称
@property (weak, nonatomic) IBOutlet UILabel *deviceName;
///状态
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
///产量
@property (weak, nonatomic) IBOutlet UILabel *product_num;

@property (weak, nonatomic) IBOutlet UILabel *check_num;

@property (weak, nonatomic) IBOutlet UILabel *hg_num;

@property (weak, nonatomic) IBOutlet UILabel *check_rate;

@property (weak, nonatomic) IBOutlet UILabel *hg_rate;

@end

///人员状态
@interface PeopleCell :UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *all;
@property (weak, nonatomic) IBOutlet UILabel *oneline;

@end




@interface GCSBViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mytable;

@end

@implementation GCSBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
