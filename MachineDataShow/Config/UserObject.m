//
//  UserObject.m
//  Fanli
//
//  Created by zhiyun.com on 15/4/10.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import "UserObject.h"
#import "LoginObject.h"

@implementation UserObject
DEF_SINGLETON(UserObject)
+(BOOL)hadLog
{
    return [[UserObject sharedInstance] uid].length != 0;
    
    return NO;
}
+(void)setDataFrom:(UserObject*)obj
{
    if(obj.uid )
        [UserObject sharedInstance].uid = obj.uid ;
    
    [UserObject sharedInstance].trueName =obj.trueName ;
    [UserObject sharedInstance].companyName =obj.companyName ;
    [UserObject sharedInstance].duty = obj.duty;
    [UserObject sharedInstance].mobile = obj.mobile;
    [UserObject sharedInstance].email = obj.email;
    [UserObject sharedInstance].fax = obj.fax;
    [UserObject sharedInstance].address = obj.address;
    [UserObject sharedInstance].head = obj.head;
    
//    @property (nonatomic, strong ) NSString *uid;
//    @property (nonatomic, strong ) NSString *trueName;
//    @property (nonatomic, strong ) NSString * companyName;
//    @property (nonatomic, strong ) NSString * duty;
//    @property (nonatomic, strong ) NSString * mobile;
//    @property (nonatomic, strong ) NSString *email;
//    @property (nonatomic, strong ) NSString *fax;
//    @property (nonatomic, strong ) NSString *address;
//    @property (nonatomic, strong ) NSString *head;
    
}
@end
