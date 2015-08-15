//
//  ContactUsViewController.m
//  MachineDataShow
//
//  Created by tim on 15-8-15.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"联系我们";
    NSString *path = nil;
    //    path = [[NSBundle mainBundle]pathForResource:@"gywm" ofType:@"html" inDirectory:@"guanyu"];
    path = [[NSBundle mainBundle]pathForResource:@"联系我们" ofType:@"html" inDirectory:nil];
    
    self.url =  [NSURL fileURLWithPath:path];
    self.navigationButtonsHidden = YES;

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
