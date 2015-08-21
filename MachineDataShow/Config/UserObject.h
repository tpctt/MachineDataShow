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

+(BOOL)hadLog;
 
AS_SINGLETON(UserObject)

@end
