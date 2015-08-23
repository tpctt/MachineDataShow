//
//  BaseViewController.h
//  Fanli
//
//  Created by zhiyun.com on 15/4/8.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import "Scene.h"
#import <FLKAutoLayout/UIView+FLKAutoLayout.h>
#import "UserObject.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <GCDObjC/GCDObjC.h>
#import <UIAlertView+Blocks/UIAlertView+Blocks.h>
#import <EasyIOS/Request.h>
#import <IQKeyboardManager/IQKeyboardReturnKeyHandler.h>

#import <UIKit/UIKit.h>

@interface BaseViewController : Scene<UITableViewDataSource,UITableViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource, UITextFieldDelegate,UITextViewDelegate >
@property (strong,nonatomic) UITableView *mtable ;
@property (strong,nonatomic) UICollectionView *gridView ;
@property (strong,nonatomic) UILabel * backLabel ;
@property (strong,nonatomic) NSString *backLabelText ;
@property (strong,nonatomic) NSString *defalutBackLabelText ;

@property (strong,nonatomic) NSMutableArray *dataArray ;
@property (strong,nonatomic) RACDisposable *scheduler;
@property (strong,nonatomic) IQKeyboardReturnKeyHandler *returnKeyHandler ;

///DEFAULT YES
@property (assign ) BOOL audioEnable;
@property (assign ) BOOL isNoData;
@property (strong,nonatomic) UIButton *toTopBtn;
//qiyongdonghua
@property (assign ) BOOL enableAnimation;

-(void) scrollViewDidScroll:(UIScrollView *)scrollView;

-(void)addToTopBtn;
-(void)hideToTop;

-(void)addLoginoutNoti;
-(void)removeLoginoutNoti;

-(void)logoutAct;
-(void)loginAct;

-(void)gotoLogin;
-(void)handleActionMsg:(Request *)msg;

-(id)getCellWithClass:(Class)class1;
+(id)getCellWithClass:(Class)class1;
-(void)showMsg:(NSString*)msg error:(NSError*)error;

-(void)setbackLabelString1:(NSString*)STRINg to:(UITableView *)tabble;

@end
