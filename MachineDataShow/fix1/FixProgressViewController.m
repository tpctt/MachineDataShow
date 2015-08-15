//
//  FixProgressViewController.m
//  MachineDataShow
//
//  Created by tim on 15-8-13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "FixProgressViewController.h"
#import "NetManager.h"


@implementation FixedProgressInfo


@end
@interface FixProgressViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *mode;
@property (weak, nonatomic) IBOutlet UILabel *sn;


@property (weak, nonatomic) IBOutlet UIView *fixInfoView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *manName;
@property (weak, nonatomic) IBOutlet UILabel *manPhone;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic)   FixedProgressInfo *fixedProgressInfo;

@end

@implementation FixProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的设备维修进度";
    
    [self config1];
    [self config2];

    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NetManager getFixedProgressInfo:_o block:^(NSArray *array, NSError *error, NSString *msg) {
        _fixedProgressInfo = [array safeObjectAtIndex:0];
        
        [self config2];

        sleep(2);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:1 ];
        
    }];
    
}
-(void)config1
{
    
    self.mode.text = [NSString stringWithFormat:@"设备型号:%@",self.o.mode];
    self.sn.text = [NSString stringWithFormat:@"设备序号:%@",self.o.sn];
    
}
-(void)config2
{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_fixedProgressInfo.icon] placeholderImage:[UIImage imageNamed:@"Avatar.jpg"]];
    
    
    self.manName.text = [NSString stringWithFormat:@"联系人:%@",_fixedProgressInfo.name];
    self.manPhone.text = [NSString stringWithFormat:@"联系电话:%@",_fixedProgressInfo.phone];
    
    NSArray*ARRAY=    @[[UIImage imageNamed:@"Banner_1.jpg"],[UIImage imageNamed:@"Banner_2.jpg"],[UIImage imageNamed:@"Banner_3.jpg"]];
    self.image = [ARRAY safeObjectAtIndex:arc4random()%3];
    
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
