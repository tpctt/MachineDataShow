//
//  UserObject.h
//  Fanli
//
//  Created by zhiyun.com on 15/4/10.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObject : NSObject


@property (nonatomic, strong ) NSString *username;
@property (nonatomic, strong ) NSString *photo;
@property (nonatomic, strong ) NSString * money;
@property (nonatomic, strong ) NSString * jifenbao;
@property (nonatomic, strong ) NSString * withdrawFlag;
@property (nonatomic, strong ) NSString *exchangeFlag;

+(BOOL)hadLog;
 
AS_SINGLETON(UserObject)

@end
