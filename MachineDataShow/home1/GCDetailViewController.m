//
//  GCDetailViewController.m
//  MachineDataShow
//
//  Created by tim on 15-9-5.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "GCDetailViewController.h"
#import <HTHorizontalSelectionList/HTHorizontalSelectionList.h>
#import "SZGCObject.h"
#import <PNChart/PNChart.h>
#import "Statuecell.h"

#import "CocoaAsyncSocket.h" // When not using frameworks, targeting iOS 7 or below

@interface StatueObject:NSObject
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *name1;
@property (strong,nonatomic) NSString *name2;
@property (strong,nonatomic) NSString *errorfrom;
@property (strong,nonatomic) NSString *deal;
@property (assign,nonatomic) int state;


@end
@implementation StatueObject



@end



@interface GCDetailViewController ()<HTHorizontalSelectionListDelegate,HTHorizontalSelectionListDataSource , UITableViewDataSource,UITableViewDelegate >

@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) PNBarChart * barChart;
@property (nonatomic, strong) PNPieChart * pieChart;
@property (nonatomic, strong) UIScrollView * scrollview;

@property (nonatomic, strong) UILabel * label1;
@property (nonatomic, strong) UILabel * label2;
@property (nonatomic, strong) UILabel * label3;


@property (nonatomic, strong) NSArray * statusArray;
@property (strong,nonatomic) RACDisposable *disposable;

@end

@implementation GCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设备实时详情";
    
    self.selectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    _selectionList.delegate = self;
    _selectionList.dataSource = self;
    
    [self.view addSubview:self.selectionList];
    [self.selectionList alignLeading:@"0" trailing:@"0" toView:self.view];
    [self.selectionList alignTopEdgeWithView:self.view predicate:@"0"];
    [self.selectionList constrainHeight:@"30"];
    
    
    self.mtable = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.mtable.delegate = self;
    self.mtable.dataSource = self;
    [self.view addSubview:self.mtable];
    
    
    [self.mtable registerNib:[UINib nibWithNibName:@"Statuecell" bundle:nil] forCellReuseIdentifier:@"Statuecell"];
    
    
    [self.mtable alignLeading:@"0" trailing:@"0" toView:self.view];
    [self.mtable alignBottomEdgeWithView:self.view predicate:@"0"];
    [self.mtable alignTopEdgeWithView:self.view predicate:@"30"];
    
    
    ///
    
    ///柱形
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 200.0)];
    [barChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    [barChart setYValues:@[@1,  @10, @2, @6, @3]];
    [barChart strokeChart];
    
    
    
    ///饼状图
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNRed],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNBlue description:@"WWDC"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNGreen description:@"GOOL I/O"],
                       ];
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 10, 240.0, 240.0) items:items];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    [pieChart strokeChart];
    
    
    
    self.barChart = barChart;
    self.pieChart = pieChart;
    
    
    
    
    [self.view bringSubviewToFront:self.selectionList];
    
    [RACObserve([CLJ_object sharedInstance], receviceIndex)subscribeNext:^(id x) {
        [self showDataFor:self.index];

    }];
    
    
    
    
}
#pragma mark tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section==1){
        return 1;
    }else
        return self.statusArray.count+3;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section= indexPath.section;
    if (section == 0) {
        return CGRectGetMaxY(self.barChart.frame);
    }else if (section==1){
        return CGRectGetMaxY(self.pieChart.frame)+16;
    }else
        return 44;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    static NSArray *titles ;
    if (titles==nil) {
        titles = @[@"产量",@"质量",@"状态"];
        
    }
    
    return [titles safeObjectAtIndex:section];
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section<2) {
        NSString *res = [NSString stringWithFormat:@"%d",indexPath.section ];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:res];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:res];
            
            
        }
        
        NSInteger section= indexPath.section;
        if (section == 0) {
            [cell addSubview:self.barChart];
            
        }else if (section==1){
            [cell addSubview:self.pieChart];
        }
        
        
        return cell;
    }
    
    NSString *res = @"Statuecell";
    Statuecell *cell = [tableView dequeueReusableCellWithIdentifier:res forIndexPath:indexPath];
    
    
    return cell;
    
}

#pragma mark 更新数据
-(void)showDataFor:(int)index
{
    [self updatevules];
}
///
-(void)updatevules
{
    SZGCObject *OBJ = [self.dataArray safeObjectAtIndex:self.index];
    CLJ_productObj *productObj = OBJ.PRODUCT_obj;
    NSArray *array = [productObj preson_productArray];
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *values = [NSMutableArray array];

    for (CLJ_person_productObj *P in array) {
        [titles addObject:P.Person];
        [values addObject:[NSNumber numberWithFloat:[P.Pro integerValue]/[P.Output integerValue]]];
    }
    
    [self.barChart setXLabels:titles ];
    [self.barChart updateChartData:values];
    [self.barChart strokeChart];

    
    NSArray *items = @[
                       [PNPieChartDataItem dataItemWithValue:[productObj.Checked integerValue]
                       color:PNBlue description:@"检查率"],
                       [PNPieChartDataItem dataItemWithValue:[productObj.OK integerValue] color:PNGreen description:@"合格率"],
                       [PNPieChartDataItem dataItemWithValue:[productObj.Output integerValue]-[productObj.Checked integerValue]  color:PNMauve description:@"其他"],
                       ];
    [self.pieChart updateChartData:items];
    [self.pieChart strokeChart];
    
}
#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.deviceArray.count  ;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    SZGCObject *OBJ = [self.deviceArray safeObjectAtIndex:index];
//    return [NSString stringWithFormat:@"设备%d ",index ];
    
    return OBJ.name?OBJ.name:[NSString stringWithFormat:@"设备%d ",index ];
    
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    // update the view for the corresponding index
    
    self.index = index;
    [self showDataFor:index];
    
    
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
