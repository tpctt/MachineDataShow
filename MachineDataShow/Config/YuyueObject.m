//
//  YuyueObject.m
//  MachineDataShow
//
//  Created by tim on 15-9-5.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "YuyueObject.h"

@implementation YuyueObject
+(instancetype)obj:(NSString*)v1 v2:(NSString*)v2
{

    YuyueObject*o = [[YuyueObject alloc] init];
    o.id
    = v1;
    
    o.time = v2;
    
    return o ;
    
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@%@", self.time,self.companyname];
}
@end
@implementation YuyueObjectRequest
-(void)loadRequest
{
    [super loadRequest];
    self.page = 1;
    //    self.PATH = [[RequestConfig sharedInstance] home];
    self.PATH = @"getVisitListJson";
//    self.HOST = AppHostAddress;
    
}
-(NSMutableDictionary *)requestParams{
    return nil;
    NSMutableDictionary *dict = [[super requestParams] mutableCopy];
    //    [dict setObject: self.category forKey:@"category"];
    //    [dict setObject: self.big_category forKey:@"big_category"];
    //    [dict setObject: self.biz_type forKey:@"biz_type"];
    
    return dict;
}
@end


@implementation YuyueObjectSceneModel
-(NSString*)getPath
{
    return [NSString stringWithFormat:@"%@/%@/%ld/%@",self.request.PATH,[UserObject sharedInstance].uid,self.request.page,@"10" ];
    
}
-(void)SEND_IQ_ACTION:(Request *)req
{
    self.request.PATH = [self getPath];
    [super SEND_IQ_ACTION:req];
    
}
-(void)loadSceneModel

{
    [super loadSceneModel];
    
    @weakify(self);
    self.request  = [YuyueObjectRequest RequestWithBlock:^{
        @strongify(self);
        [self SEND_IQ_ACTION:self.request];
        
    }];
    
    [[RACObserve(self.request, state)
      filter:^BOOL(NSNumber *state) { //过滤请求状态
          @strongify(self);
          return  self.request.succeed;
      }]
     subscribeNext:^(NSNumber *state) {
         @strongify(self);
         NSError *error = self.request.error;
         
//         NSDictionary *dict = [self.request.output objectAtPath:@"response"];
                  NSDictionary *dict =  self.request.output  ;
         
         NSArray* list  =  [[YuyueObject objectArrayWithKeyValuesArray:dict  error:&error]mutableCopy ] ;
//         NSInteger totalPage = [dict[@"totalPage"] integerValue];
         
         NSInteger totalPage = 0;
         if(list.count <10)
             totalPage = self.request.page;
         else
             totalPage = self.request.page+1;

         [self getArray:list totalPage:totalPage];
         
     }];
    
}
@end