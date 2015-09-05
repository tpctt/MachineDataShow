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

@interface GCDetailViewController ()<HTHorizontalSelectionListDelegate,HTHorizontalSelectionListDataSource >

@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) PNBarChart * barChart;
@property (nonatomic, strong) PNPieChart * pieChart;
@property (nonatomic, strong) UIScrollView * scrollview;

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
    
    
    ///柱形
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selectionList.frame)+5, SCREEN_WIDTH, 200.0)];
    [barChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    [barChart setYValues:@[@1,  @10, @2, @6, @3]];
    [barChart strokeChart];
    
    
    
    ///饼状图
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNRed],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNBlue description:@"WWDC"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNGreen description:@"GOOL I/O"],
                       ];
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, CGRectGetMaxY(barChart.frame), 240.0, 240.0) items:items];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    [pieChart strokeChart];
    
    
    self.barChart = barChart;
    self.pieChart = pieChart;
    
    
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selectionList.frame)+5, SCREEN_WIDTH, 200.0)];
    [self.view addSubview:_scrollview];
 
    
    [self.scrollview addSubview:self.barChart];
    [self.scrollview addSubview:self.pieChart];
    
    self.scrollview.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(self.pieChart.frame));

    [self.scrollview alignLeading:@"0" trailing:@"0" toView:self.view];
    [self.scrollview alignBottomEdgeWithView:self.view predicate:@"0"];
    [self.scrollview alignTopEdgeWithView:self.selectionList predicate:@"0"];
    
    [self.view bringSubviewToFront:self.selectionList];
    
}


-(void)showDataFor:(int)index
{
    [self updatevules];
}
///
-(void)updatevules
{
    [self.barChart setXLabels:@[@"Jan 1",@"Jan 2",@"Jan 3",@"Jan 4",@"Jan 5",@"Jan 6",@"Jan 7"]];
    [self.barChart updateChartData:@[@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30)]];

    
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:40 color:PNRed],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNBlue description:@"WWDC"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNGreen description:@"GOOL I/O"],
                       ];
    [self.pieChart updateChartData:items];
}
#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.deviceArray.count + 3;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    SZGCObject *OBJ = [self.deviceArray safeObjectAtIndex:index];
    
    return OBJ.NAME;
    
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    // update the view for the corresponding index
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
