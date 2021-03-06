//
//  ServerViewController.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "ServerViewController.h"
#import "HelpViewController.h"
#import "SuggestViewController.h"

@interface ServerViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ServerViewController
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *url = nil;
    NSInteger row = indexPath.row;
    
    ///销售，售后，服务流程，联系我们
    NSArray *array = @[@"page/buy.html",@"page/service.html",@"page/contact.html"];
    
    if(row< 3){
        ///关于我们
        HelpViewController *web = [[HelpViewController alloc]initWithURLString:[NSString stringWithFormat:@"%@%@",TempAppHostAddress,array[row]]];
        
        [self.tabBarController.navigationController pushViewController:web animated:1];
        [tableView deselectRowAtIndexPath:indexPath animated:1];

        return;
    }else{
        ///意见
        SuggestViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"yjfkvc"];
        
        [self.tabBarController.navigationController pushViewController:vc animated:1];
        
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
    
    //设置tabBar图标及颜色
    self.tabBarController.tabBar.selectedItem.selectedImage = [UIImage imageNamed:@"nav_button_kf_pressed@2x.png"];
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1];
    self.tabBarController.tabBar.selectedImageTintColor =[UIColor colorWithRed:0.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1];
    
    self.title = @"客服";
    
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
