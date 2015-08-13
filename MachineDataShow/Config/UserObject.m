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
    return [[LoginObject sharedInstance] session_token].length != 0;
    
    return NO;
}

@end
