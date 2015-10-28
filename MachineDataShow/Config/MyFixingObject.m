//
//  MyFixingObject.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/21.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "MyFixingObject.h"

@implementation MyFixingObject

@end
@implementation MyFixingObjectRequest
-(void)loadRequest
{
    [super loadRequest];
    self.page = 1;
    //    self.PATH = [[RequestConfig sharedInstance] home];
    self.PATH = @"getUserRepairListJson";
    //    self.HOST = AppHostAddress;
    
}
-(NSMutableDictionary *)requestParams{
    NSMutableDictionary *dict = [[super requestParams] mutableCopy];
    //    [dict setObject: self.category forKey:@"category"];
    //    [dict setObject: self.big_category forKey:@"big_category"];
    //    [dict setObject: self.biz_type forKey:@"biz_type"];
    
    return dict;
}
@end


@implementation MyFixingObjectSceneModel
@synthesize request=_request;

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
    self.request  = [MyFixingObjectRequest RequestWithBlock:^{
        @strongify(self);
        [self SEND_IQ_ACTION:self.request];
        
    }];
    
    [[RACObserve(self.request, state)
      filter:^BOOL(NSNumber *state) { //过滤请求状态
          NSLog(@"获取用户报修列表：%@",self.request.PATH);
          @strongify(self);
          return  self.request.succeed;
      }]
     subscribeNext:^(NSNumber *state) {
         @strongify(self);
         NSError *error = self.request.error;
//         NSDictionary *dict = [self.request.output objectAtPath:@"response"];
        NSDictionary *dict =  self.request.output  ;
         
         
         NSArray* list  =  [[MyFixingObject objectArrayWithKeyValuesArray:dict  error:&error]mutableCopy ] ;
         NSInteger totalPage = 0;
         if(list.count <10)
             totalPage = self.request.page;
         else
             totalPage = self.request.page+1;

         [self getArray:list totalPage:totalPage];
         
     }];
    
}
@end