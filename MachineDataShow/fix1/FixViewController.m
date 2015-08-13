
//
//  FixViewController.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "FixViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface DeviceCell:UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *deviceMode;
@property (weak, nonatomic) IBOutlet UILabel *n;
@property (weak, nonatomic) IBOutlet UILabel *d;
@property (weak, nonatomic) IBOutlet UIButton *b;

@end

@interface FixViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mytable;

@end
@implementation DeviceCell

@end


@implementation FixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.mtable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 320) style:UITableViewStylePlain];
//    [self.view addSubview:self.mtable];
//    [self.mtable alignToView:self.view];
//    self.mtable.dataSource = self;
//    self.mtable.delegate = self;
    
    self.mytable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    self.mytable.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeviceCell *cell = (DeviceCell *)[tableView dequeueReusableCellWithIdentifier:@"DeviceCell"];
    
    [[cell.b rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         
     }];
    
    return cell;
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
