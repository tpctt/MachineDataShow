
//
//  LoginObject.m
//  Fanli
//
//  Created by zhiyun.com on 15-4-11.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import "LoginObject.h"
#import <TMCache/TMCache.h>

@implementation LoginObject
DEF_SINGLETON(LoginObject)
+(void)save
{
    if ([[[LoginObject sharedInstance] session_token] length]!=0) {
        NSDictionary *dict = [[LoginObject sharedInstance] keyValues];
        
        [[TMCache sharedCache] setObject:dict forKey:NSStringFromClass([LoginObject class])];
        
    }
}
+(BOOL)logWithCache
{
    NSDictionary *dict =     [[TMCache sharedCache] objectForKey:NSStringFromClass ([LoginObject class])];
    LoginObject *obj = [LoginObject  objectWithKeyValues:dict];
    if (obj.session_token.length !=0) {
        [LoginObject sharedInstance] .userid = obj.userid;
        [LoginObject sharedInstance] .session_token = obj.session_token;
        [LoginObject sharedInstance] .username = obj.username;
        [LoginObject sharedInstance] .avatar = obj.avatar;
        
        
        return YES;
        
    }
    
    return NO;
                            

}
+(void)clearCache
{
    [[TMCache sharedCache] removeObjectForKey:NSStringFromClass ([LoginObject class])];
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.userid = @"";
        self.session_token=@"";
    }
    return self;
}
@end
