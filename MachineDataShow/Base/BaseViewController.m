//
//  BaseViewController.m
//  Fanli
//
//  Created by zhiyun.com on 15/4/8.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import "BaseViewController.h"
//#import "LoginViewController.h"

#import "AppDelegate.h"
#import <EasyIOS/DialogUtil.h>
#import <EasyIOS/NSObject+EasyTypeConversion.h>
#import <MJRefresh/MJRefresh.h>

@interface BaseViewController ()

@end

@implementation BaseViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.audioEnable = YES;
        
    }
    return self;
}
-(void)dealloc
{
    _returnKeyHandler.delegate = nil;
    _returnKeyHandler =nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.enableAnimation = YES;
    
    self.view.backgroundColor = RGB(236, 236, 236);
    self.mtable.backgroundColor = [UIColor clearColor];
    
    
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [[Config sharedInstance]viewBackgroudColor];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:FLlogin object:nil] subscribeNext:^(NSNotification *notification) {
        [self loginAct];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:FLlogout object:nil] subscribeNext:^(NSNotification *notification) {
        [self logoutAct];
    }];
    
}

-(void)hideToTop
{
    if (!self.toTopBtn) {
        return;
    }
    if (self.toTopBtn.hidden == YES) {
        return;
    }
    self.toTopBtn.alpha = 0.8;
    [UIView animateWithDuration:1 animations:^{
        self.toTopBtn.alpha = 0;
        
    } completion:^(BOOL finished) {
        self.toTopBtn.hidden = YES;
        
    }];
}

-(void)addToTopBtn
{
    if (self.toTopBtn == nil) {
        self.toTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 45 )];
        [self.toTopBtn setBackgroundImage:[UIImage imageNamed:@"to_top"] forState:UIControlStateNormal];
        self.toTopBtn.alpha =0.8;
        [self.toTopBtn addTarget:self action:@selector(toTopBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.toTopBtn];
        [self.toTopBtn constrainWidth:[NSString stringWithFormat:@"%g",self.toTopBtn.width]
                               height:[NSString stringWithFormat:@"%g",self.toTopBtn.height] ];
        
        [self.toTopBtn alignBottom:@"-20" trailing:@"-20" toView:self.view];
        self.toTopBtn.hidden = YES;

    }
    if (self.toTopBtn.hidden == NO) {
        return;
    }
    self.toTopBtn.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        self.toTopBtn.alpha = 0.8;
        
    } completion:^(BOOL finished) {
        self.toTopBtn.hidden = NO;

    }];
    
}

-(void)toTopBtnAct:(UIButton*)sender
{
    
    [self.gridView scrollsToTop];
    [self.gridView scrollRectToVisible:self.gridView.frame animated:YES];
    [self hideToTop];
}

-(void)leftButtonTouch
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)gotoLogin
{
//    [[[AppDelegate sharedInstance] homeNav] pushViewController:[[LoginViewController alloc] init] animated:self.enableAnimation];
    
    
}
-(void)logoutAct{}

-(void)loginAct{
//    [LoginObject save];
    
    [[GCDQueue mainQueue] queueBlock:^{
//        [self.navigationController popToViewController:self animated:YES];
    }];
}

-(void)handleActionMsg:(Request *)msg
{
        if(msg.sending){
            NSLog(@"sending:%@",msg.url);
            [[GCDQueue mainQueue] queueBlock:^{
              [[DialogUtil sharedInstance]showDlg:self.view usingBlocks:@"正在努力加载..."];
               // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            }];
            
        }else if(msg.succeed){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (self.audioEnable) {
                [[Config sharedInstance]playerAudio:@"pull_newData" type:@"wav"];

            }
            
        }else if(msg.failed){
            NSLog(@"failed:%@",msg.error);
            
            if ([msg.message isEqualToString: @"没有数据了！"]) {
                self.isNoData = YES;
            }
            
            [[DialogUtil sharedInstance]showDlg:self.view textOnly:msg.message];
            [self.gridView.header endRefreshing];
            [self.gridView.footer endRefreshing];
        }
}

static CGPoint prePoint;

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.gridView || scrollView == self.mtable) {
        if(prePoint.y > scrollView.contentOffset.y) {
            prePoint = scrollView.contentOffset;
            return;
        } else {
            prePoint = scrollView.contentOffset;
        }
        if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height - 560) {
            [scrollView.footer beginRefreshing];
        }
        
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(id)getCellWithClass:(Class)class1
{
    return [self.class getCellWithClass:class1];
    
}
+(id)getCellWithClass:(Class)class1
{
//    UITableViewCell *cell1 = [[  class1  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(class1)];
//    return cell1;
    
    id cell = nil;
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(class1) owner:Nil options:Nil];
    for (id oneObject in nib) {
        if ([oneObject isKindOfClass:class1]) {
            cell = oneObject;
            break;
        }
    }
    return cell;
    
}
-(void)showMsg:(NSString*)msg error:(NSError*)error{
    if(msg){
        [UIAlertView showWithTitle:@"提示" message:msg cancelButtonTitle:@"确认" otherButtonTitles:nil tapBlock:nil];
        
    }else{
        
        [UIAlertView showWithTitle:@"提示" message:error.localizedDescription cancelButtonTitle:@"确认" otherButtonTitles:nil tapBlock:nil];
        
    }
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
