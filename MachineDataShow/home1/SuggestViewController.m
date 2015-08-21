//
//  SuggestViewController.m
//  MachineDataShow
//
//  Created by tim on 15-8-21.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "SuggestViewController.h"

@interface SuggestViewController ()
@property (weak, nonatomic) IBOutlet UITextView *suggestText;
@property (weak, nonatomic) IBOutlet UITextField *contactText;

@end

@implementation SuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButton:NAV_RIGHT title:@"提交" fontColor:[UIColor whiteColor]];
    self.title = @"意见反馈";
    
    
}
-(void)rightButtonTouch
{
    
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
