//
//  RequestConfig.m
//  Fanli
//
//  Created by zhiyun.com on 15-4-10.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import "RequestConfig.h"

@implementation RequestConfig
DEF_SINGLETON(RequestConfig)
- (instancetype)init
{
    self = [super init]  ;
    if (self) {
        _emailReg = @"m=Passport&a=register";
        
        
        // 登录
        _thirdloginCallBack = @"m=Passport&a=loginThirdCallback"  ;
        _login              = @"m=Passport&a=loginNormal";
        _thirdlogin         = @"m=Passport&a=loginThird&type=";
        
        //31 首页
        _home               = @"m=Tao&a=getHomeList";
        //3 检查版本更新
        _checkUp            = @"m=More&a=checkUpgrade";
        
        //首页->商城返利
        _mallFanli          = @"m=Mall&a=getList";
        //打卡赚钱的显示数据
        _dakashuju          = @"m=User&a=checkQiandao";
        //提交打卡赚钱
        _dakaZHUANQIAN      = @"m=User&a=subQiandao";
        
        //个人中心（我的返利）的用户数据
        _userInfo           = @"m=User&a=getBaseInfo";
        // 我的返利
        _fanliList          = @"m=User&a=getRebateList";
        // 我的集分宝
        _jifenbaoList       = @"m=User&a=getJfbList";
        // 订单记录
        _myOrder            = @"m=User&a=getOrderList";
        // 提现记录
        _tixianRecord       = @"m=User&a=getWithdrawList";
        // 兑换记录
        _duihuanRecord      = @"m=User&a=getExchangeList";

        //商品分类
        _productCatgs       = @"m=Tao&a=getList";
        
        //检索页面：热门关键字
        //_hotSearchKey       = @"m=Search&a=keywords";
        //检索页面：检索
        _search             = @"m=Search&a=searchByKeyword";
        //_searchByType       = @"m=Search&a=searchByType";
        _searchTBByKEY      = @"m=Tao&a=searchTaoByKeyword";
        _PRODuCTdetail      = @"m=ConvertTaobao&a=danpin";
         
        //左侧滑动菜单中的检索
        _leftSearch         = @"m=Tao&a=searchTaoByKeyword";
        //问题反馈：历史记录
        _feedbackHistory    = @"m=More&a=adviseList";
        //问题反馈：提交
        _feedbackCommit     = @"m=More&a=advise";
        
        _zhuanti            = @"m=Tao&a=getBannerList";
        //_JINRISHANGXIN      = @"m=Tao&a=getNewList";
        
        _XIAQIYUGAO         = @"m=Tao&a=getFutureList";
        //_CHAOJIFANLI        = @"m=Tao&a=getChaofanList";
        
        //发送邮箱验证码
        _sendEmailCode      = @"m=Passport&a=sendEmailCode";
        //找回密码：邮箱，提交验证码
        _checkEmailCode     = @"m=Passport&a=checkEmailCode";
        //设置新密码
        _modifyPassword     = @"m=Passport&a=modifyPassword";
        
        //发送手机验证码
        _sendMobileCode     = @"m=Passport&a=sendMobileCode";
        //找回密码：手机，提交验证码
        _checkMobileCode    = @"m=Passport&a=checkMobileCode";
        //手机绑定
        _bindMobile         = @"m=User&a=bindMobile";
        //支付宝绑定
        _bindAlipay         = @"m=User&a=bindAlipay";
        //支付宝绑定中获取手机验证码
        _sendMobileAuthCode = @"m=Passport&a=sendMobileAuthCode";
        //个人中心->账户设置信息获取
        _getSecurityInfo    = @"m=User&a=getSecurityInfo";
        //邮箱绑定
        _bindEmail          = @"m=User&a=bindEmail";

        //返利提现申请
       _subWithdrawRebate   = @"m=User&a=subWithdrawRebate";
        //集分宝提现申请
       _subWithdrawJifenbao = @"m=User&a=subWithdrawJifenbao";
        //设置->关闭推送通知
       _filterOrderNotify   = @"m=More&a=filterOrderNotify";
        //检查session有效期（每次进入个人中心都执行）
       _checkSessionExpired = @"m=Passport&a=checkSessionExpired";

        _adviseList         = @"m=More&a=adviseList";
        _advise             = @"m=More&a=advise";
        
    }
    return self  ;
}
@end
