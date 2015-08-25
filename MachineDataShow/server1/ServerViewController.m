//
//  ServerViewController.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "ServerViewController.h"
#import "ContactUsViewController.h"
@interface ServerViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ServerViewController
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *TEL = nil;
    if (indexPath.row ==0) {
        TEL = @"10086";
    }else if(indexPath.row == 1){
        TEL = @"10000";
    }
    if (TEL) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",TEL]];
        if ( [[UIApplication sharedApplication] canOpenURL:url] ) {
             [[UIApplication sharedApplication] openURL:url];
        }else{
            [UIAlertView showWithTitle:TEL message:@"不支持电话拨打" cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
            }];
        }
       
    }
    if (indexPath.row ==  2) {
        
        TOWebViewController *vc = [[TOWebViewController alloc]initWithURLString:[AppHostAddress stringByAppendingString:@"page/Lianxi.html"]];
        vc.navigationButtonsHidden = YES;
        [self.tabBarController.navigationController pushViewController:vc animated:1];
        
//        ContactUsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LXWM"];
//        [self.tabBarController.navigationController pushViewController:vc animated:1];
//        
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    
}
#if USENormalPush
-(UINavigationController *)navigationController
{
    
    return self.tabBarController.navigationController;
}
#endif
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#if USENormalPush
    self.edgesForExtendedLayout = UIRectEdgeNone;
#endif
//    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.view.backgroundColor = RGB(236, 236, 236);
    self.title = @"服务";
    
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
