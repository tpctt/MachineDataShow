//
//  GCSBViewController.m
//  MachineDataShow
//
//  Created by tim on 15-9-5.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "GCSBViewController.h"
#import "GCYSSB_Object.h"
#import "GCDetailViewController.h"

///工厂设备cell
@interface GCSBCell :UITableViewCell

///设备名称
@property (weak, nonatomic) IBOutlet UILabel *deviceName;
///状态
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
///产量
@property (weak, nonatomic) IBOutlet UILabel *product_num;

@property (weak, nonatomic) IBOutlet UILabel *check_num;

@property (weak, nonatomic) IBOutlet UILabel *hg_num;

@property (weak, nonatomic) IBOutlet UILabel *check_rate;

@property (weak, nonatomic) IBOutlet UILabel *hg_rate;

-(void)setName:(NSString*)name state:(NSString*)state all:(NSString*)all check:(NSString*)check good:(NSString*)good checkrate:(NSString*)checkrate goodrate:(NSString*)goodrate;

@end

@implementation GCSBCell

-(void)setName:(NSString*)name state:(NSString*)state all:(NSString*)all check:(NSString*)check good:(NSString*)good checkrate:(NSString*)checkrate goodrate:(NSString*)goodrate
{
    if([state hasSuffix:@"\r\n"])
    {
        state  = [state substringToIndex:state.length - 2];
    }
    
    if ([[state lowercaseString] isEqualToString:@"connected"]) {
        self.stateBtn.backgroundColor = [UIColor greenColor];

    }else{
        self.stateBtn.backgroundColor = [UIColor redColor];
        
    }
    
    
    [self.stateBtn setTitleColor:[UIColor whiteColor] forState:0];
    if(state.length <2){
        [self.stateBtn setTitle:@"正在获取" forState:0];
        self.stateBtn.backgroundColor = [UIColor grayColor];

    }else
        [self.stateBtn setTitle:state forState:0];

    self.deviceName.text = name?name:@"设备名称不详";
    self.product_num.text  = [NSString stringWithFormat:@"产量:%@",all?all:@"正在获取"];
    
    self.check_num.text  = [NSString stringWithFormat:@"已检验:%@",check?check:@"不详"];
    self.hg_num.text  = [NSString stringWithFormat:@"合格数:%@",good?good:@"不详"];

    self.check_rate.text  = [NSString stringWithFormat:@"抽检率:%@",checkrate?checkrate:@"不详"];
    self.hg_rate.text  = [NSString stringWithFormat:@"合格率:%@",goodrate?goodrate:@"不详"];

    
}

@end

#pragma <#arguments#>
///人员状态
@interface PeopleCell :UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *all;
@property (weak, nonatomic) IBOutlet UILabel *oneline;

-(void)setName:(NSString*)name all:(NSString*)all online:(NSString*)online;

@end

@implementation PeopleCell

-(void)setName:(NSString*)name all:(NSString*)all online:(NSString*)online
{
    self.name.text = name?name:@"正在获取";
    self.all.text = [NSString stringWithFormat:@"在编:%@",all];
    self.oneline.text = [NSString stringWithFormat:@"在线:%@",online];
    
}
@end
#pragma <#arguments#>


@interface GCSBViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (strong, nonatomic)   SZGCObjectSceneModel *vm;

@end

@implementation GCSBViewController

-(void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    if (msg.state ==    SuccessState   ||
        msg.state ==   FailState   ) {
        
        [self.mytable.footer endRefreshing];
        [self.mytable.header endRefreshing];
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"工厂设备";
    
    self.view.backgroundColor = RGB(236, 236, 236);
    self.mytable.backgroundColor = [UIColor clearColor];
    self.mytable.tableFooterView = [[UIView alloc]init];
    
    self.mytable.delegate = self;
    self.mytable.dataSource = self;
    
    
    [[CLJ_object sharedInstance]start];

    [RACObserve([CLJ_object sharedInstance], receviceIndex)subscribeNext:^(id x) {
        
        for(GCYSSB_Object *obj in self.vm.allDataArray){
            
            NSString *MachineID =   [NSString stringWithFormat:@"%@%@",obj.model,obj.serial];
             for (CLJ_deviceObj *stateObj in [[CLJ_object sharedInstance]stateArray]) {
                if ([[stateObj.MachineID lowercaseString] isEqualToString:[MachineID lowercaseString]]) {
                    obj.status_obj = stateObj;
                    
                }
            }
  
             for (CLJ_productObj *productObj in [[CLJ_object sharedInstance]productArray]) {
                if ([[productObj.MachineID lowercaseString] isEqualToString:[MachineID lowercaseString]]) {
                    obj.PRODUCT_obj = productObj;
                    
                }
            }
            
            
        }
        
        
        
        
        [[GCDQueue mainQueue]queueBlock:^{
            
            [self.mytable reloadData];
            
        }];
        
        
    }];
    
    self.vm = [SZGCObjectSceneModel SceneModel];
    [self.vm .action useCache];

    self.vm.action.aDelegaete = self;
    self.vm.request.requestNeedActive = YES;
    
    
    self.mytable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.vm loadFirstPage ];
    }];
    self.mytable.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.vm loadNextPage];
    }];
    
    @weakify(self);
    [[RACObserve(self.vm, currestList)
      filter:^BOOL(NSArray *value) {
          return value!=nil;
      }]
     subscribeNext:^(NSArray *value) {
         @strongify(self);
         
         [self.mytable reloadData];
         [self.mytable.header endRefreshing ];
         [self.mytable.footer endRefreshing ];
         
         if (self.vm.hadNextPage == NO) {
             [self.mytable.footer noticeNoMoreData];
         }else{
             [self.mytable.footer resetNoMoreData];
             
         }
         
     } ];
    
    
    
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    static NSArray *titles ;
    if (titles==nil) {
        titles = @[@"设备站点",@"人员状态"];

    }
    
    return [titles safeObjectAtIndex:section];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100;
    }else
        return 44;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return self.vm.allDataArray.count;
    return 3;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        GCSBCell *CELL = [tableView dequeueReusableCellWithIdentifier:@"GCSBCell" ];
        GCYSSB_Object *OBJ = [self.vm.allDataArray safeObjectAtIndex:indexPath.row];
        if (OBJ==nil) {
//            OBJ=[SZGCObject random];
        }else
            [CELL setName:OBJ.name state:OBJ.status_obj.State?OBJ.status_obj.State:OBJ.status all:OBJ.PRODUCT_obj.Output check:OBJ.PRODUCT_obj.Checked good:OBJ.PRODUCT_obj.OK checkrate:OBJ.PRODUCT_obj.checkrate goodrate:OBJ.PRODUCT_obj.goodrate];
        
        
        return CELL;
    }else{
        PeopleCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"PeopleCell" ];
        CLJ_presonObj *obj = [CLJ_object sharedInstance].presonObj;
        if(indexPath.row == 0){
            [cell setName:obj.GM all:obj.GMQTY online:obj.GMQTYOnline];
        }else if(indexPath.row == 1){
            [cell setName:obj.QC all:obj.QCQTY online:obj.QCQTYOnline];
        }else if(indexPath.row == 2){
            [cell setName:obj.QP all:obj.QPQTY online:obj.QPQTYOnline];
        }
        
        return cell;
    }
    
  
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        GCDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"gcdetail"];
        vc.index = indexPath.row;
        vc.deviceArray = self.vm.allDataArray;
        
        [self.navigationController pushViewController:vc animated:1];
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    
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
