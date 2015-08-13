//
//  ProductDetailViewController.m
//  Fanli
//
//  Created by zhiyun.com on 15/4/17.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()
@property(strong,nonatomic) NSURL *lastJump;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIBarButtonItem *leftbtn = [uibua]
 
//    UIButton *button = [[UIButton alloc] initNavigationButton:[UIImage imageNamed:@"nav_back"]];
//    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc]initWithCustomView:button];
//    [button addTarget:self action:@selector(backAct) forControlEvents:UIControlEventTouchUpInside];
    
//    self.buttonTintColor = [[Config sharedInstance]appMainColor];

}
-(void)backAct
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL FLAG = [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
//    NSDictionary *dict = [request.URL params];
//    NSString *key1 = @"client_id";
//    NSString *key2 = @"a";
//    NSString *key3 = @"type";
//    NSString *key4 = @"code";
    
    
    NSString *string1 = @"http://detail.m.tmall.com";
    NSString *string2 = @"http://h5.m.taobao.com";
    NSString *string3 = @"mm_34177456";
    
    if (([[request.URL absoluteString] hasPrefix:string1] || [[request.URL absoluteString] hasPrefix:string2])
        &&  [[request.URL absoluteString] rangeOfString:string3].location != NSNotFound)

    {
        NSURL *newUrl = [NSURL URLWithString:[[[request.URL absoluteString] stringByReplacingOccurrencesOfString:@"http://" withString:@"taobao://"]
                         stringByAppendingString:@"&sche=com.zhiyun.Fanli"]];
        
        if ([[UIApplication sharedApplication] canOpenURL:newUrl]) {
            [[UIApplication sharedApplication] openURL:newUrl];
//            return NO;
            [self.navigationController popViewControllerAnimated:NO];
            return NO;
        }
    }
    self.lastJump = request.URL;
    
    
    return FLAG;
    
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
