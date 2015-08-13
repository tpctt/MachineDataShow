//
//  BandingObject.h
//  Fanli
//
//  Created by zhiyun.com on 15/4/16.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import <Foundation/Foundation.h>
///绑定数据相关
@interface BandingObject : NSObject
@property(strong,nonatomic) NSString* is_validate_mobile;
@property(strong,nonatomic) NSString* is_validate_account;
@property(strong,nonatomic) NSString* is_validate_email;

@property(strong,nonatomic) NSString* mobile;
@property(strong,nonatomic) NSString* email;
@property(strong,nonatomic) NSString* alipay_need_code;
@property(strong,nonatomic) NSString* card_id;
@property(strong,nonatomic) NSString* real_name;
AS_SINGLETON(BandingObject)

@end
