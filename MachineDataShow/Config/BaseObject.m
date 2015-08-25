
//
//  BaseObject.m
//  Fanli
//
//  Created by zhiyun.com on 15-4-8.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import "BaseObject.h"
#import "LoginObject.h"

#define FirstPageNum 1
///////////////BaseListObjectRequest////////////////////
@implementation BaseListObjectRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.page = FirstPageNum ;
        
    }
    return self;
}

-(NSMutableDictionary *)requestParams{
    NSMutableDictionary *dict = [[super requestParams] mutableCopy];
    [dict setObject: @(self.page) forKey:@"page"];
    
    return dict;
    
}

-(void)pageAdd
{
    self.page++;
}
-(void)initPage{
    self.page = FirstPageNum;
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
//    [dict setObject: [BaseObjectRequest sharedInstance].device forKey:@"device"];
//    [dict setObject: [BaseObjectRequest sharedInstance].version forKey:@"version"];
//   
//    if ([BaseObjectRequest sharedInstance].session_token.length) {
//        [dict setObject: [BaseObjectRequest sharedInstance].session_token forKey:@"session_token"];
//        
//    }
    
    if ([BaseObjectRequest sharedInstance].userid.length) {
        [dict setObject: [BaseObjectRequest sharedInstance].userid forKey:@"uid"];
        
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
    self.allDataArray = [NSMutableArray array];
    
    
}
-(void)loadNextPage
{
    if(self.hadNextPage){
        [self.request pageAdd];
        self.request.requestNeedActive = YES;
    }else{
        self.currestList = nil;
        
    }
}
-(void)loadFirstPage;
{
    
    [self.request initPage];
    self.request.requestNeedActive = YES;
    
}
-(void)getArray:(NSArray*)list totalPage:(NSInteger)totalPage
{
    self.hadNextPage = totalPage > self.request.page ;
    
    if (self.request.page == 1) {
        [self.allDataArray removeAllObjects];
    }
    if([list  count]>0){
        [self.allDataArray addObjectsFromArray:list];
    }
    
    self.currestList = list;
    
}
@end


