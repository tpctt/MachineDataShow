
//
//  BaseObject.m
//  Fanli
//
//  Created by zhiyun.com on 15-4-8.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import "BaseObject.h"
#import "LoginObject.h"

///////////////BaseListObjectRequest////////////////////
@implementation BaseListObjectRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.page = @"1";
        
    }
    return self;
}

-(NSMutableDictionary *)requestParams{
    NSMutableDictionary *dict = [[super requestParams] mutableCopy];
    [dict setObject: self.page forKey:@"page"];
    
    return dict;
    
}
@end

///////////////BaseObjectRequest////////////////////
@implementation BaseObjectRequest
DEF_SINGLETON(BaseObjectRequest)

-(void)loadRequest
{
    [super loadRequest];
    self.METHOD = @"POST";
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.userid = [[LoginObject sharedInstance]userid];
        self.session_token = [[LoginObject sharedInstance]session_token];
        self.device = @"ios";
        self.version = @"1.0";
        
    }
    return self;
}

-(NSSet *)acceptableContentTypes
{
    return [NSSet setWithArray:@[@"text/html",@"application/json"]];
}

-(NSMutableDictionary *)requestParams{
    NSMutableDictionary *dict = [[super requestParams] mutableCopy];
    [dict setDictionary:[BaseObjectRequest getBaseRequestInfos]];
    return dict;
    
}

+(NSMutableDictionary*)getBaseRequestInfos
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary ];
    [dict setObject: [BaseObjectRequest sharedInstance].device forKey:@"device"];
    [dict setObject: [BaseObjectRequest sharedInstance].version forKey:@"version"];
    if ([BaseObjectRequest sharedInstance].userid.length) {
        [dict setObject: [BaseObjectRequest sharedInstance].userid forKey:@"userid"];
        
    }
    if ([BaseObjectRequest sharedInstance].session_token.length) {
        [dict setObject: [BaseObjectRequest sharedInstance].session_token forKey:@"session_token"];
        
    }
    
    return dict;
    
}
@end


///////////////BaseObject////////////////////
#pragma <#arguments#>
@implementation BaseObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end


///////////////BaseSceneModel////////////////////
@implementation BaseSceneModel
-(void)loadSceneModel
{
    [super loadSceneModel];
    self.dataArray = [NSMutableArray array];
}


@end


