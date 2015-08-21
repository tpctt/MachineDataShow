//
//  DemoViewController.m
//  MachineDataShow
//
//  Created by tim on 15-8-15.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "DemoViewController.h"
#import "DataShowViewController.h"

@interface DemoViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *model;
@property (weak, nonatomic) IBOutlet UILabel *sn;


@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *controlBtn;

@end

@implementation DemoViewController
- (IBAction)btnAct:(id)sender {
    [self performSegueWithIdentifier:@"kongzhi" sender:_o];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"kongzhi"]) {
        DataShowViewController *vc = segue.destinationViewController;
        vc.o = sender;
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ///
    self.title = @"申请控制";
    
    [self config1];
    
}
-(void)config1
{
    
    
    self.model.text = [NSString stringWithFormat:@"设备型号:%@",self.o.mode];
    self.sn.text = [NSString stringWithFormat:@"设备序号:%@",self.o.serial];
    
    
    self.image.image = [UIImage imageNamed:@"Banner_1.jpg"];
    
    
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
