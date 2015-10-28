//
//  ShowMeViewController.m
//  Fanli
//
//  Created by zhiyun.com on 15/4/17.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import "ShowMeViewController.h"
#import "ScrollADView.h"

@interface ShowMeViewController ()
@property (strong,nonatomic) ScrollADView *scrollView;
@property (strong,nonatomic) UIButton *button;

@end

@implementation ShowMeViewController
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    
}
 
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
//    self.title = @"新手入门";
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 110, 60)];
    [self.button addTarget:self action:@selector(exitShowMe:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    self.scrollView = [[ScrollADView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.scrollView];
    [self.scrollView alignToView:self.view];
//    self.scrollView.verticalScroll = YES;
    
    self.scrollView.timeInterval = 0;
    self.scrollView.circle = NO;
    self.scrollView.adPageControl.hidden = YES;
    
    self.scrollView.adScrollview.bounces = YES;
    
    
   
    
    
    
    
    NSString *imageBase = @"showme";
    NSInteger count = 1;
//    if ( [[UIScreen mainScreen] bounds].size.height == 480 ) {
//        imageBase = @"guide_";
//        count = 4;
//    }else{
//        
//    }
    NSMutableArray *imagesArray = [NSMutableArray array ];
    for (int i = 1; i<= count; i++ ) {
        NSString *string = [NSString stringWithFormat:@"%@%d",imageBase, i ];
        NSLog(@"开机图像:%@",string);
        UIImage *image = [UIImage imageNamed:string];
        if (image) {
            [imagesArray addObject:image];
            
        }
        
    }
    
    self.scrollView.contentMode = UIViewContentModeScaleToFill;
    [self.scrollView setImages:imagesArray withTitles:nil];
    
    
    
    [[RACObserve(self.scrollView.adScrollview, contentOffset)
     filter:^BOOL(id value) {
         return YES;
    } ] subscribeNext:^(id x) {
        NSInteger maxX = self.scrollView.adScrollview.frame.size.width * (self.scrollView.adPageControl.numberOfPages-1)+10 ;
        NSInteger maxY = self.scrollView.adScrollview.frame.size.height * (self.scrollView.adPageControl.numberOfPages-1)+10;
        
        if (self.scrollView.adScrollview.contentOffset.x > maxX   ||
            self.scrollView.adScrollview.contentOffset.y > maxY
            ) {
            
            [self exitShowMe:nil];
            
        }
    }];
    
    self.scrollView.adBlock = ^(ScrollADView *adView,NSUInteger adIndex){
        if (adIndex == count-1) {
            [self exitShowMe:nil];
        }
    };
    
    
    if ( [[UIScreen mainScreen] bounds].size.height==480 ) {
        self.button .frame = CGRectMake(80, 360, 320-160, 60);
        
    }else{
        self.button .frame = CGRectMake(70, 420, 320-140, 60);
        CGFloat rateX = [[UIScreen mainScreen] bounds].size.width/320.0;
        CGFloat rateY = [[UIScreen mainScreen] bounds].size.height/568.0;
        
        self.button.frame = CGRectMake(self.button.frame.origin.x * rateX, self.button.frame.origin.y * rateY, self.button.width*rateX, self.button.height*rateY);
        
        
    }
    [self.view addSubview:self.button];
    self.button.backgroundColor = [UIColor clearColor];

//    [Config addLayerTo:self.button color:[UIColor greenColor]];
    
    
}

-(void)exitShowMe:(UIButton*)SENDER
{
    if(SENDER){
        if (self.scrollView.adPageControl.numberOfPages != self.scrollView.adPageControl.currentPage+1 ) {
            return;
        }
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation( - self.view.frame.size.width, 0);
        
    } completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:NO];

    }];

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
