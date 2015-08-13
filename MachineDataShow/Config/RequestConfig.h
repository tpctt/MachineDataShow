//
//  RequestConfig.h
//  Fanli
//
//  Created by zhiyun.com on 15-4-10.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import <Foundation/Foundation.h>

///接口 配置
@interface RequestConfig : NSObject
AS_SINGLETON(RequestConfig)

//登录
@property (strong,nonatomic) NSString *login;
@property (strong,nonatomic) NSString *thirdloginCallBack;
@property (strong,nonatomic) NSString *thirdlogin;
//邮箱注册
@property (strong,nonatomic) NSString *emailReg;
//首页
@property (strong,nonatomic) NSString *home;
//检查版本更新
@property (strong,nonatomic) NSString *checkUp;
//首页->商城返利
@property (strong,nonatomic) NSString *mallFanli;
//打卡赚钱的显示数据
@property (strong,nonatomic) NSString *dakashuju;
//提交打卡赚钱
@property (strong,nonatomic) NSString *dakaZHUANQIAN;
//个人中心（我的返利）的用户数据
@property (strong,nonatomic) NSString *userInfo;	
//我的返利列表
@property (strong,nonatomic) NSString *fanliList;
@property (strong,nonatomic) NSString *jifenbaoList;
@property (strong,nonatomic) NSString *myOrder;
@property (strong,nonatomic) NSString *tixianRecord;
@property (strong,nonatomic) NSString *duihuanRecord;

//商品分类
@property (strong,nonatomic) NSString *productCatgs;
//检索页面：热门关键字
//@property (strong,nonatomic) NSString *hotSearchKey;
//检索页面：检索
@property (strong,nonatomic) NSString *search;

//@property (strong,nonatomic) NSString *searchByType;
@property (strong,nonatomic) NSString *searchTBByKEY;
@property (strong,nonatomic) NSString *PRODuCTdetail;
//左侧滑动菜单中的检索
@property (strong,nonatomic) NSString *leftSearch;
//问题反馈：历史记录
@property (strong,nonatomic) NSString *feedbackHistory;
//问题反馈：提交
@property (strong,nonatomic) NSString *feedbackCommit;
//专题list
@property (strong,nonatomic) NSString *zhuanti;
//@property (strong,nonatomic) NSString *JINRISHANGXIN;
@property (strong,nonatomic) NSString *XIAQIYUGAO;
//@property (strong,nonatomic) NSString *CHAOJIFANLI;

//发送邮箱验证码
@property (strong,nonatomic) NSString *sendEmailCode;
//找回密码：邮箱，提交验证码
@property (strong,nonatomic) NSString *checkEmailCode;
//设置新密码
@property (strong,nonatomic) NSString *modifyPassword;
//发送手机验证码
@property (strong,nonatomic) NSString *sendMobileCode;
//找回密码：手机，提交验证码
@property (strong,nonatomic) NSString *checkMobileCode;
//手机绑定
@property (strong,nonatomic) NSString *bindMobile;
//支付宝绑定
@property (strong,nonatomic) NSString *bindAlipay;
//支付宝绑定中获取手机验证码
@property (strong,nonatomic) NSString *sendMobileAuthCode;
//个人中心->账户设置信息获取
@property (strong,nonatomic) NSString *getSecurityInfo;
//邮箱绑定
@property (strong,nonatomic) NSString *bindEmail;

//返利提现申请
@property (strong,nonatomic) NSString *subWithdrawRebate;
//集分宝提现申请
@property (strong,nonatomic) NSString *subWithdrawJifenbao;
//设置->关闭推送通知
@property (strong,nonatomic) NSString *filterOrderNotify;
//检查session有效期（每次进入个人中心都执行）
@property (strong,nonatomic) NSString *checkSessionExpired;
///问题反馈：历史记录
@property (strong,nonatomic) NSString *adviseList;
///问题反馈：提交
@property (strong,nonatomic) NSString *advise;

@end
