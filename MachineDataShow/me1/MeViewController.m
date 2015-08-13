//
//  MeViewController.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "MeViewController.h"
#import "UserObject.h"

@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;


@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet UIButton *editInfoBtn;
@property (weak, nonatomic) IBOutlet UIButton *p;

@property (weak, nonatomic) IBOutlet UILabel *phone;




@property (weak, nonatomic) IBOutlet UIView *notLoginView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@property (weak, nonatomic) IBOutlet UIView *logoutBase;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;



@property (weak, nonatomic) IBOutlet UITableViewCell *myInfoCell;

@end

@implementation MeViewController
-(void)dealView
{
    if ([UserObject hadLog]    ) {
        self.loginView.hidden = 0;
        self.notLoginView.hidden = 1;
        self.logoutBase.hidden = 0;
        
        self.myInfoCell.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
        
    }else{
        self.loginView.hidden = 1;
        self.notLoginView.hidden = 0;
        self.logoutBase.hidden = 1;
        
        self.myInfoCell.frame = CGRectMake(0, 0, self.view.frame.size.width, 0);
        
    }
    [self.tableView reloadData];
    
}
- (IBAction)btnAct:(id)sender {
}
- (IBAction)logout:(id)sender {
}
- (IBAction)login:(id)sender {
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _icon.layer.cornerRadius = _icon.width/2;
    _icon.clipsToBounds= 1;
    
//    self.tableView.delegate = self;
//    self.mytableview.dataSource = self;
//
    self.view.backgroundColor = RGB(236, 236, 236);
    
    [self dealView];
    
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
