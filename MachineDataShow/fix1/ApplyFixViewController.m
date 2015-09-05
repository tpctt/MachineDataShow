//
//  ApplyFixViewController.m
//  MachineDataShow
//
//  Created by tim on 15-8-13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "ApplyFixViewController.h"
#import "FixProgressViewController.h"
#import "MyFixingObject.h"

@interface ApplyFixViewController ()<UITableViewDataSource,UITableViewDelegate,ActionDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (strong, nonatomic)   MyFixingObjectSceneModel *vm;

@end

@implementation ApplyFixViewController
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
    self.title = @"我的报修列表";
    self.view.backgroundColor = RGB(236, 236, 236);
    self.mytable.backgroundColor = [UIColor clearColor];
    self.mytable.tableFooterView = [[UIView alloc]init];
   
    
    
    self.vm = [MyFixingObjectSceneModel SceneModel];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vm.allDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString*S =@"#$%^&DFV";
    UITableViewCell *CELL = [tableView dequeueReusableCellWithIdentifier:S];
    if (!CELL){
        CELL=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:S];
        CELL.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    MyFixingObject *o = [self.vm.allDataArray safeObjectAtIndex:indexPath.row];

    CELL.textLabel.text = [NSString stringWithFormat:@"%@ %@",o.equipmentName,o.serial];
//    [o.name stringByAppendingString:o.serial];
    return CELL;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyFixingObject *o = [self.vm.allDataArray safeObjectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"Weixiujintu" sender:o];
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.identifier isEqualToString:@"baoxiu"]) {
//        FixedInfoViewController *VC = segue.destinationViewController;
//        VC.o = sender;
//        
//    }else
        if ([segue.identifier isEqualToString:@"Weixiujintu"]) {
            FixProgressViewController *VC = segue.destinationViewController;
            VC.o = sender;
        
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
