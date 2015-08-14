//
//  NavViewController.m
//  Fanli
//
//  Created by zhiyun.com on 15/4/8.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController

-(void)popself

{
    
    [self popViewControllerAnimated:YES];
    
}

-(UIBarButtonItem*) createBackButton

{
    UIButton *btn = [[UIButton alloc]initNavigationButton:[UIImage imageNamed:@"back"]];
    
    [btn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];

    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    return [[UIBarButtonItem alloc]
            
            initWithTitle:@"返回"
            
            style:UIBarButtonItemStyleBordered
            
            target:self
            
            action:@selector(popself)];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated

{

    [super pushViewController:viewController animated:animated];

    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
        
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
        
    }
}
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
