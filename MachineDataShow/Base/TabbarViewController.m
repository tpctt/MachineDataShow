//
//  TabbarViewController.m
//  Taoqianbao2
//
//  Created by 中联信 on 15-1-23.
//  Copyright (c) 2015年 中联信. All rights reserved.
//

#import "TabbarViewController.h"
#import "UserObject.h"
#import "LoginViewController.h"


@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
    [self setTabBarHidden:NO animated:1];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    [self setTabBarHidden:1 animated:1];

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


@interface TabbarViewController2 ()

@end

@implementation TabbarViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *array = @[@"home_blue",@"contact_blue",@"vip_blue"];
    for (int i = 0 ; i<3; i++) {
        UITabBarItem *ti1 = [self.tabBar.items objectAtIndex:i];
//        ti1.title = @"梦见";
//        ti1.image = [[UIImage imageNamed:@"qr_tabbar_mine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        ti1.selectedImage = [[UIImage imageNamed:array[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [ti1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(32, 165, 236),NSForegroundColorAttributeName , [UIFont systemFontOfSize:18],NSFontAttributeName, nil] forState:UIControlStateSelected];
        
//        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName , [UIFont systemFontOfSize:18],NSFontAttributeName, nil]];

    }
    
    self.delegate = self;
//    self.tabBar.delegate = self;

}
//-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
//{
//    if (![UserObject hadLog]) {
//        if ([tabBar.items indexOfObject:item] == 1 ) {
//            
//            UIStoryboard*  sb = self.storyboard;
//            LoginViewController* controller = [sb instantiateViewControllerWithIdentifier:@"loginVC" ];
//            
//            if (controller) {
//                [self.navigationController pushViewController:controller animated:YES];
//            }
//            
//        }
//    }
//}
//-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    if (![UserObject hadLog]) {
//        if ([tabBarController.viewControllers indexOfObject:viewController] == 1 ) {
//            
//            UIStoryboard*  sb = self.storyboard;
//            LoginViewController* controller = [sb instantiateViewControllerWithIdentifier:@"loginVC" ];
//            
//            if (controller) {
//                [self.navigationController pushViewController:controller animated:YES];
//            }
//            
//        }
//    }
//}
//-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
//{
//    if (![UserObject hadLog]) {
//        if ([tabBarController.viewControllers indexOfObject:viewController] == 1 ) {
//            return 0;
//        }
//    }
//
//    return 1;
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
//    [self setTabBarHidden:NO animated:1];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
//    [self setTabBarHidden:1 animated:1];
    
}
@end
