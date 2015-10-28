//
//  YuyueDetailViewController.m
//  MachineDataShow
//
//  Created by tim on 15-9-5.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "YuyueDetailViewController.h"
#import "NetManager.h"
@interface YuyueDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic)   NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIView *v1;
@property (weak, nonatomic) IBOutlet UIImageView *V2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YuyueDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ///getAppointmentInfo.php
    
    self.title = @"预约详情";
    self. label.text = [NSString stringWithFormat:@"预约号：%@",self.OBJ.id ];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.tableHeaderView = self.v1;
    self.tableView.tableFooterView = self.V2;
    
    self.dataArray = [NSMutableArray array ];
    [self.dataArray addObject:[YuyueObject obj:@"公司名称" v2:self. OBJ .companyname]];
    [self.dataArray addObject:[YuyueObject obj:@"参观人数" v2:self. OBJ .mount]];
    [self.dataArray addObject:[YuyueObject obj:@"参观时间" v2:self. OBJ .visittime]];

    [self.dataArray addObject:[YuyueObject obj:@"联系电话" v2:self. OBJ .telephone]];
    
    
    /*
     @property (strong,nonatomic) NSString *uid;
     @property (strong,nonatomic) NSString *companyname;
     //参观人数
     @property (strong,nonatomic) NSString *mount;
     @property (strong,nonatomic) NSString *duty;
     @property (strong,nonatomic) NSString *telephone;
     @property (strong,nonatomic) NSString *visittime;
     //留言
     @property (strong,nonatomic) NSString *remakrs;
     @property (strong,nonatomic) NSString *id;
     @property (strong,nonatomic) NSString *visitno;
     @property (strong,nonatomic) NSString *time;
     @property (assign,nonatomic) int status ;
     */
    return;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [NetManager yuyueDetail:self.OBJ.id block:^(NSArray *array, NSError *error, NSString *msg) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (array) {
            
            [[GCDQueue mainQueue] queueBlock:^{
                [[DialogUtil sharedInstance]showDlg:self.view.window textOnly:msg];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }];
            
        }
        else
        {
            if(msg.length){
                [UIAlertView showWithTitle:@"提示" message:msg cancelButtonTitle:@"确认" otherButtonTitles:nil tapBlock:nil];
                
            }else{
                
                [UIAlertView showWithTitle:@"提示" message:error.localizedDescription cancelButtonTitle:@"确认" otherButtonTitles:nil tapBlock:nil];
                
            }
        }
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString*S =@"#$%^&DFV";
    UITableViewCell *CELL = [tableView dequeueReusableCellWithIdentifier:S];
    if (!CELL){
        CELL=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:S];
        CELL.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    YuyueObject *o = [self.dataArray safeObjectAtIndex:indexPath.row];
    CELL.textLabel.text =  o.id    ;
    CELL.detailTextLabel.text =  o.time  ;
    
    return CELL;
    
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
