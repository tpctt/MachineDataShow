//
//  HomeViewController.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "HomeViewController.h"
#import "ScrollADView.h"
#import "AppDelegate.h"
#import "NetManager.h"
#import "LoginViewController.h"

#import "DemoViewController.h"
#import "SuggestViewController.h"
#import "HelpViewController.h"
#import "SQyuyueViewController.h"
#import <TMCache/TMCache.h>

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet ScrollADView *scrollAdView;
@property (strong, nonatomic) HomeCell *v1;

@property (weak, nonatomic) IBOutlet UIButton *b1;
@property (weak, nonatomic) IBOutlet UIButton *b2;
@property (weak, nonatomic) IBOutlet UIButton *b3;
@property (weak, nonatomic) IBOutlet UIButton *b4;
@property (strong, nonatomic)   NSArray *adArray;

@end

@implementation HomeViewController
- (IBAction)login:(id)sender {
    LoginViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
    
    [self.tabBarController.navigationController pushViewController:vc animated:1];
    
}
- (IBAction)btnAct:(id)sender {
    if ((sender == _b2 || sender == _b4 ) && [UserObject hadLog]==NO) {
        [UIAlertView showWithTitle:@"" message:@"还未登陆，是否前往登陆?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex==1) {
                
                //                    [self performSegueWithIdentifier:@"loginSeg" sender:nil];
                [self login:nil];
                
            }
        }];
        return;
    }
    
    if (sender == _b2) {
//        [[AppDelegate sharedInstance].homeVC.tabBar setSelectedItem:[[AppDelegate sharedInstance].homeVC.tabBar.items objectAtIndex:1]];
        
//        [[AppDelegate sharedInstance].homeVC
//                     tabBarController:[AppDelegate sharedInstance].homeVC
//                     didSelectViewController:[[AppDelegate sharedInstance].homeVC.viewControllers objectAtIndex:1] ];
        
        
        FixViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"wdsb"];
        
        [self.tabBarController.navigationController pushViewController:vc animated:1];
        
        
    }else if (sender ==_b1){
        DemoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"sqkzvc"];
        [self.tabBarController.navigationController pushViewController:vc animated:1];
        
        
//        [self performSegueWithIdentifier:@"SQKZ" sender:nil];
        
    }else if (sender ==_b4){
        
        SQyuyueViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"sqyuyue"];
        [self.tabBarController.navigationController pushViewController:vc animated:1];
        
//        [self performSegueWithIdentifier:@"Suggest" sender:nil];
        
    }
    else{
        
        HelpViewController *web = [[HelpViewController alloc]initWithURLString:[NSString stringWithFormat:@"%@%@",AppHostAddress,@"page/new.html"]];
        
        [self.tabBarController.navigationController pushViewController:web animated:1];
        
    }
}
#if USENormalPush
-(UINavigationController *)navigationController
{
    
    return self.tabBarController.navigationController;
}
#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    _v1 = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeCell"];
    _v1 = [self getCellWithClass:[HomeCell class]];
    UIButton *bnt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    bnt.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitleView:_v1];
    
    [self.scrollAdView setImages:@[[UIImage imageNamed:@"Banner_1.jpg"],[UIImage imageNamed:@"Banner_2.jpg"],[UIImage imageNamed:@"Banner_3.jpg"]]  withTitles:nil];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (nil == _adArray) {
       
#pragma mark ad-cache

        NSArray*ARRAY1 = [[TMCache sharedCache]objectForKey:@"adArrayKeyvaules"];
        NSArray *array22 = [HomeAD objectArrayWithKeyValuesArray:ARRAY1 error:nil];
        if (array22) {
            _adArray = array22;
            
            NSArray *array2 = [array22 valueForKey:@"image"];
            [self.scrollAdView setImages:array2 withTitles:nil];
            self.scrollAdView.adBlock = ^(ScrollADView *adView,NSUInteger adIndex ){
                HomeAD *ad = [_adArray safeObjectAtIndex:adIndex];
                TOWebViewController *web = [[TOWebViewController alloc]initWithURLString:ad.url];
                [self.tabBarController.navigationController pushViewController:web animated:1];
                
            }  ;
        }else{
            //                [self showMsg:msg error:error];
            
        }
        
        
#pragma mark ad-network
        [NetManager getHomeAdsblock:^(NSArray *array, NSError *error, NSString *msg) {
            if (array) {
                _adArray = array;
                
                NSArray *array2 = [array valueForKey:@"image"];
                [self.scrollAdView setImages:array2 withTitles:nil];
                self.scrollAdView.adBlock = ^(ScrollADView *adView,NSUInteger adIndex ){
                    HomeAD *ad = [_adArray safeObjectAtIndex:adIndex];
                    TOWebViewController *web = [[TOWebViewController alloc]initWithURLString:ad.url];
                    [self.tabBarController.navigationController pushViewController:web animated:1];
                    
                }  ;
            }else{
//                [self showMsg:msg error:error];
                
            }
        }];
    }
 

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
