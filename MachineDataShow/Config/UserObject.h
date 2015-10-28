//
//  UserObject.h
//  Fanli
//
//  Created by zhiyun.com on 15/4/10.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObject : NSObject


@property (nonatomic, strong ) NSString *uid;
@property (nonatomic, strong ) NSString *trueName;
@property (nonatomic, strong ) NSString * companyName;
@property (nonatomic, strong ) NSString * duty;
@property (nonatomic, strong ) NSString * mobile;
@property (nonatomic, strong ) NSString *email;
@property (nonatomic, strong ) NSString *fax;
@property (nonatomic, strong ) NSString *address;
@property (nonatomic, strong ) NSString *head;
@property (nonatomic, strong ) NSString *province;
@property (nonatomic, strong ) NSString *city;
@property (nonatomic, strong ) NSString *industry;
@property (nonatomic, strong ) NSString *department;
@property (nonatomic, strong ) NSString *sex;

+(BOOL)hadLog;
+(void)setDataFrom:(UserObject*)obj;

+(void)save;
+(BOOL)logWithCache;
+(void)clearCache;

AS_SINGLETON(UserObject)

@end
