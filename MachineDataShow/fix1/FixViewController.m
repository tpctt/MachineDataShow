
//
//  FixViewController.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/13.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "FixViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "ApplyFixViewController.h"
#import "FixProgressViewController.h"
#import "FixedInfoViewController.h"

#import "DeviceObject.h"

@interface DeviceCell:UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *deviceMode;
@property (weak, nonatomic) IBOutlet UILabel *n;
@property (weak, nonatomic) IBOutlet UILabel *d;
@property (weak, nonatomic) IBOutlet UIButton *b;
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UILabel *line;
@property (strong, nonatomic)  DeviceObject  *oo;



-(void)config:(id)o;

@end

@interface FixViewController ()<ActionDelegate, UISearchBarDelegate >
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (strong, nonatomic)   DeviceObjectSceneModel *vm;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableTopConstaint;

@property (strong, nonatomic)  UISearchBar  *searchBar;

@end
@implementation DeviceCell
-(void)config:(id)o
{
    _oo = o;
    
    self.name.text = @"设备名称:" ;
    self.name.text = [self.name.text stringByAppendingString:_oo.name];
    
    self.deviceMode.text = @"设备型号:" ;
    self.deviceMode.text = [self.deviceMode.text stringByAppendingString:_oo.model];
    
    self.n.text = @"设备序号:" ;
    self.n.text = [self.n.text stringByAppendingString:_oo.serial];
    
    self.d .text = @"购买时间:" ;
    self.d .text = [self.d .text stringByAppendingString:_oo.buydate];
     
}

-(void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.baseView.layer.borderColor = [[UIColor grayColor]CGColor];
    self.baseView.layer.borderWidth =0.5;
    
    
}
@end


@implementation FixViewController
- (IBAction)gotoBaoxiu:(id)sender {
    FixProgressViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WDBXJL"];
    [self.tabBarController.navigationController pushViewController:vc animated:1];
    
}

-(void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    if (msg.state ==    SuccessState   ||
        msg.state ==   FailState   ) {
        
        [self.mytable.footer endRefreshing];
        [self.mytable.header endRefreshing];
        
    }
}
#if USENormalPush
-(UINavigationController *)navigationController
{
    
    return self.tabBarController.navigationController;
}
#endif

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
  
        
    if (self.searchBar.text.length ) {
        
        FixViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"wdsb"];
        vc.keyword = self.searchBar.text;
        
        [self.navigationController pushViewController:vc animated:1];
        
    }
        
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.mtable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 320) style:UITableViewStylePlain];
//    [self.view addSubview:self.mtable];
//    [self.mtable alignToView:self.view];
//    self.mtable.dataSource = self;
//    self.mtable.delegate = self;

#if USENormalPush
    self.edgesForExtendedLayout = UIRectEdgeNone;
#endif
    
    self.title = @"我的设备";
    self.view.backgroundColor = RGB(236, 236, 236);
    self.mytable.backgroundColor = [UIColor clearColor];
    
    
    
    
    
    
    self.vm = [DeviceObjectSceneModel SceneModel];
    self.vm.action.aDelegaete = self;

    
    ///不是search的列表
    if (self.keyword.length == 0  ) {
        self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 220, 44)];
        self.mytable.tableHeaderView = self.searchBar;
        
        self.searchBar.placeholder = @"输入搜索关键字";
        self.searchBar.delegate = self;
        
        self.title = @"设备搜索结果";

//        [[self.searchBar  rac_signalForSelector:@selector(searchBarSearchButtonClicked:) ]subscribeNext:^(id x) {
//            
//            if (self.searchBar.text.length ) {
//                
//                FixViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"wdsb"];
//                
//                [self.navigationController pushViewController:vc animated:1];
//             
//            }
//            
//        }];
        
        
    }else{
        DeviceObjectRequest*REQ =  (DeviceObjectRequest*)self.vm.request;
        [REQ setKeyword:self.keyword];
        
    }
    
    
    
    self.vm.request.requestNeedActive = YES;
   
//    [self setbackLabelString1:@"暂无设备" to:self.mtable];

    self.mytable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.vm loadFirstPage ];
    }];
    self.mytable.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.vm loadNextPage];
    }];
    
    @weakify(self);
    [[RACObserve(self.vm, currestList)
      filter:^BOOL(NSArray *value) {
          return  value!=nil;
      }]
     subscribeNext:^(NSArray *value) {
         @strongify(self);
         
         [[GCDQueue mainQueue]queueBlock:^{
             [self.mytable reloadData];
             [self.mytable.header endRefreshing ];
             [self.mytable.footer endRefreshing ];
             
             if (self.vm.hadNextPage == NO) {
                 [self.mytable.footer noticeNoMoreData];
             }else{
                 [self.mytable.footer resetNoMoreData];
             }
             
         }];
         
         
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
    DeviceCell *cell = (DeviceCell *)[tableView dequeueReusableCellWithIdentifier:@"DeviceCell"];
    DeviceObject *o = [self.vm.allDataArray safeObjectAtIndex:indexPath.row];
    [cell config:o];
    
    
    [[cell.b rac_signalForControlEvents:UIControlEventTouchUpInside]
      
     subscribeNext:^(id x) {
         cell.b.enabled=0;
         FixedInfoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"XBBXVC"];
         vc.o = o;
         
         [self.tabBarController.navigationController pushViewController:vc animated:1];
         cell.b.enabled=1;
         
     }];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeviceObject *o = [self.vm.allDataArray safeObjectAtIndex:indexPath.row];
//    [self performSegueWithIdentifier:@"weixiujindu" sender:o];

    FixProgressViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"weixiujinduvc"];
    vc.o = o;
    [self.tabBarController.navigationController pushViewController:vc animated:1];
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"baoxiu"]) {
        FixedInfoViewController *VC = segue.destinationViewController;
        VC.o = sender;
        
    }else if ([segue.identifier isEqualToString:@"weixiujindu"]) {
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
