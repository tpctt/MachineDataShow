//
//  LoginObject.h
//  Fanli
//
//  Created by zhiyun.com on 15-4-11.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import <Foundation/Foundation.h>
///登录之后相关
@interface LoginObject : NSObject

@property (nonatomic, strong ) NSString *userid;
@property (nonatomic, strong ) NSString *session_token;
@property (nonatomic, strong ) NSString *username;
@property (nonatomic, strong ) NSString *avatar;


+(void)save;
+(BOOL)logWithCache;
+(void)clearCache;

AS_SINGLETON(LoginObject)
@end
