//
//  NetManager.h
//  Fanli
//
//  Created by zhiyun.com on 15-4-10.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmallObject.h"
#import <EasyIOS/NSArray+EasyExtend.h>
#import "UserObject.h"
#import "LoginObject.h" 
//#import "UMSocial.h"
#import "BandingObject.h"
#import "DeviceObject.h"
#import "HomeAD.h"

#define requestOK @"1"


///请求配置
typedef void(^DataDataBlock)(DakaObject *object,NSError *error,NSString *msg);
typedef void(^HotKeyBlock)(NSArray *array,NSError *error,NSString *msg);


typedef void(^TBurlWithKey)(NSString *search_url , NSString *type, NSError *error,NSString *msg);

typedef void(^GetUserDataBlock)(UserObject *object,NSError *error,NSString *msg);
typedef void(^LoinBlock)(UserObject *object,NSError *error,NSString *msg);
typedef void(^checkSessionExpiredBlock)(BOOL update_session,LoginObject *object,NSError *error,NSString *msg);

typedef void(^SendMailBlock)(NSString *email_goto_url,NSError *error,NSString *msg);
typedef void(^BandingAlipayBlock)(NSString *alipay_account,NSString*alipay_realname,NSError *error,NSString *msg);
typedef void(^GetSecurityInfoBlock)(BandingObject*object,  NSError *error,NSString *msg);


@interface NetManager:NSObject
+(AFHTTPRequestOperation*)getFixedProgressInfo:(NSString*)objid block:(HotKeyBlock)block;
+(AFHTTPRequestOperation*)getHomeAdsblock:(HotKeyBlock)block;
+(AFHTTPRequestOperation*)getUserInfoblock:(HotKeyBlock)block;
///￼性别(0-保密、1-男、2-女)
+(AFHTTPRequestOperation*)setUserInfotrueName:(NSString*)trueName
                                  companyName:(NSString*)companyName
                                         duty:(NSString*)duty
                                        email:(NSString*)email
                                          fax:(NSString*)fax
                                      address:(NSString*)address
                                          sex:(int)sex

                                        block:(HotKeyBlock)block;
+(AFHTTPRequestOperation*)uploadHead:(UIImage *)image
                                block:(HotKeyBlock)block;

+(AFHTTPRequestOperation*)setEquipmentRepairID:(NSString*)equipmentId
                                       contact:(NSString*)contact
                                          tele:(NSString*)tele
                                        detail:(NSString*)detail

                                        images:(NSArray*)images
                                        videos:(NSArray*)videos

                                         block:(HotKeyBlock)block;
+(AFHTTPRequestOperation*)setpassword:(NSString*)oldpwd
                                  password:(NSString*)password

                                        block:(HotKeyBlock)block;



+(AFHTTPRequestOperation*)getDakaData:(DataDataBlock)block;
+(AFHTTPRequestOperation*)daka:(DataDataBlock)block;
+(AFHTTPRequestOperation*)getHotSearch:(NSInteger)num block:(HotKeyBlock)block;
+(AFHTTPRequestOperation*)getTBurl:(NSString*)key block:(TBurlWithKey)block;
+(AFHTTPRequestOperation*)getTBurlByNUM:(NSString*)NUMID tc:(NSString*)tc block:(TBurlWithKey)block;

+(AFHTTPRequestOperation*)getUserData:(GetUserDataBlock)block;

///性别(0-保密、1-男、2-女)
//+(AFHTTPRequestOperation*)emailReg:(NSString*)email  name:(NSString *)name pwd:(NSString*)pwd block:(LoinBlock)block;
+(AFHTTPRequestOperation*)RegMobile:(NSString*)mobile
                          password:(NSString *)password
                          trueName:(NSString*)trueName
                       companyName:(NSString*)companyName
                              duty:(NSString*)duty
                             email:(NSString*)email
                               fax:(NSString*)fax
                           address:(NSString*)address
 
                             block:(LoinBlock)block;

+(AFHTTPRequestOperation*)login:(NSString*)name pwd:(NSString*)pwd aps:(NSString *)aps block:(LoinBlock)block;
+(AFHTTPRequestOperation*)thirdLogin:(NSString*)client_id type:(NSString*)type code:(NSString*)code aps:(NSString *)aps block:(LoinBlock)block;
+(AFHTTPRequestOperation*)thirdLoginAddressType:(NSString*)type block:(LoinBlock)block;

////发送邮箱验证码,
+(AFHTTPRequestOperation*)sendEmailCode:(NSString*)mail isBanding:(BOOL) isBanding block:(SendMailBlock)block;

////找回密码：邮箱，提交验证码
+(AFHTTPRequestOperation*)checkEmail:(NSString*)mail Code:(NSString*)mailCode  block:(SendMailBlock)block;

////设置新密码
+(AFHTTPRequestOperation*)modifyPassword:(NSString*)account isMail:(BOOL)isMall password:(NSString*)password code:(NSString*)code re_password:(NSString*)re_password client_id:(NSString*)client_id block:(LoinBlock)block;

////发送手机验证码
+(AFHTTPRequestOperation*)sendMobileCode:(NSString*)mobile isBanding:(BOOL)isBanding  block:(SendMailBlock)block;

////找回密码：手机，提交验证码
+(AFHTTPRequestOperation*)checkMobileCode:(NSString*)mobile code:(NSString*)code  block:(SendMailBlock)block;

////手机绑定
+(AFHTTPRequestOperation*)bindMobile:(NSString*)mobile code:(NSString*)code  block:(SendMailBlock)block;

////支付宝绑定
+(AFHTTPRequestOperation*)bindAlipay:(NSString*)alipay_account alipay_realname:(NSString*)alipay_realname code:(NSString*)code  block:(BandingAlipayBlock)block;


///支付宝绑定中获取手机验证码
+(AFHTTPRequestOperation*)sendMobileAuthCode:(SendMailBlock)block;

////个人中心->账户设置信息获取
+(AFHTTPRequestOperation*)getSecurityInfo:(GetSecurityInfoBlock)block;

////邮箱绑定
+(AFHTTPRequestOperation*)bindEmail:(NSString*)mail code:(NSString*)code  block:(SendMailBlock)block;


////返利提现申请
+(AFHTTPRequestOperation*)subWithdrawRebate:(NSString*)money   block:(SendMailBlock)block;

////集分宝提现申请
+(AFHTTPRequestOperation*)subWithdrawJifenbao:(NSString*)jifenbao   block:(SendMailBlock)block;

////设置->关闭推送通知
+(AFHTTPRequestOperation*)filterOrderNotify:(BOOL)enable   block:(SendMailBlock)block;

////检查session有效期（每次进入个人中心都执行）
+(AFHTTPRequestOperation*)checkSessionExpired:(BOOL)enable   block:(checkSessionExpiredBlock)block;

///问题反馈：提交
+(AFHTTPRequestOperation*)advise:(NSString *)content  connect:(NSString *)connect   block:(SendMailBlock)block;

@end
