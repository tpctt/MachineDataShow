//
//  YuyueTableViewController.m
//  MachineDataShow
//
//  Created by tim on 15-9-4.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "YuyueTableViewController.h"
#import "YuyueObject.h"
#import "YuyueDetailViewController.h"
#import <EasyIOS/TimeTool.h>
@interface YuyueTableViewController ()<UITableViewDataSource,UITableViewDelegate,ActionDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (strong, nonatomic)   YuyueObjectSceneModel *vm;

@end

@implementation YuyueTableViewController

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
    self.title = @"我的预约";
    self.view.backgroundColor = RGB(236, 236, 236);
    self.mytable.backgroundColor = [UIColor clearColor];
    self.mytable.tableFooterView = [[UIView alloc]init];
    
    self.mytable.delegate = self;
    self.mytable.dataSource = self;
    
    
    self.vm = [YuyueObjectSceneModel SceneModel];
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
    
    if ([self.mytable respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.mytable setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.mytable respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.mytable setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
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
        CELL=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:S];
        CELL.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    YuyueObject *o = [self.vm.allDataArray safeObjectAtIndex:indexPath.row];
   CELL.textLabel.text = [NSString stringWithFormat:@"预约号:%@  ",o.id   ];
     //NSString *time = [TimeTool formatTime:[o.visittime doubleValue] formatWith:@"yyyy-MM-dd"];
    //NSLog(@"预约时间是：%@",o.visittime);
    NSString *time = o.visittime ;
    CELL.detailTextLabel.text = [NSString stringWithFormat:@"预约时间:%@",time ];

    /*UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [label setText:[NSString stringWithFormat:@"预约号:%@",o.id   ]];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [CELL.contentView addSubview:label];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 160, 100)];
    label1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [label1 setText:[NSString stringWithFormat:@"预约时间:%@",time ]];
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = [UIColor blackColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.backgroundColor = [UIColor clearColor];
    [CELL.contentView addSubview:label1];*/
   
    
    
//    CELL.textLabel.text = [NSString stringWithFormat:@"%@ %@",o.id,o.serial];
    //    [o.name stringByAppendingString:o.serial];
    return CELL;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YuyueObject *o = [self.vm.allDataArray safeObjectAtIndex:indexPath.row];
    YuyueDetailViewController *detailvc = [self.storyboard instantiateViewControllerWithIdentifier:@"yuyuedetail"];
    detailvc.OBJ= o  ;
    
    [self.navigationController pushViewController:detailvc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

@end
