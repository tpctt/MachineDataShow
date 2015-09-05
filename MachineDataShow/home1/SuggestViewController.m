//
//  SuggestViewController.m
//  MachineDataShow
//
//  Created by tim on 15-8-21.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "SuggestViewController.h"
#import "NetManager.h"

@interface SuggestViewController ()
@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *suggestText;
@property (weak, nonatomic) IBOutlet UITextField *contactText;

@end

@implementation SuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButton:NAV_RIGHT title:@"提交" fontColor:[UIColor whiteColor]];
    self.title = @"意见反馈";
    self.suggestText.placeholder = @"请输入意见建议";
    self.suggestText.placeholderColor =[UIColor grayColor];
    self.suggestText.text = @"";
    
    
}
-(void)rightButtonTouch
{
    if (self.contactText.text.length == 0 ) {
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入联系方式"];
        [self.contactText becomeFirstResponder];
        return;
        
    }
    
    if (self.suggestText.text.length == 0 ) {
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入反馈意见"];
        [self.suggestText becomeFirstResponder];
        return;
        
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NetManager faceback:self.suggestText.text tele:self.contactText.text block:^(NSArray *array, NSError *error, NSString *msg) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (array) {
            
            [[GCDQueue mainQueue] queueBlock:^{
              
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }];
            
        }
        else
        {
            if(msg.length){
                [UIAlertView showWithTitle:@"提示" message:msg cancelButtonTitle:@"确认" otherButtonTitles:nil tapBlock:nil];
                
            }else{
                
                [UIAlertView showWithTitle:@"提示" message:error.localizedDescription cancelButtonTitle:@"确认" otherButtonTitles:nil tapBlock:nil];
                
            }
        }
        
    

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
