
//
//  FixViewController.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "FixViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface FixViewController ()

@end

@implementation FixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mtable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 320) style:UITableViewStylePlain];
    [self.view addSubview:self.mtable];
    [self.mtable alignToView:self.view];
    self.mtable.dataSource = self;
    self.mtable.delegate = self;
    
    self.mtable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    self.mtable.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
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
