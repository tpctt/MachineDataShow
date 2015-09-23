//
//  DeviceObject.m
//  MachineDataShow
//
//  Created by tim on 15-8-15.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "DeviceObject.h"
#import "AppDelegate.h"

@implementation DeviceObject
 
@end

@implementation DeviceObjectRequest
-(void)loadRequest
{
    [super loadRequest];
    self.page = 1;
//    self.PATH = [[RequestConfig sharedInstance] home];
    self.PATH = @"getUserEquipmentListJson";
//    self.HOST = AppHostAddress;
    
    
}
-(NSMutableDictionary *)requestParams{
    return nil;
    
//    NSMutableDictionary *dict = [[super requestParams] mutableCopy];
//  
//    if (self.keyword) {
//        [dict setObject: self.keyword forKey:@"keyword"];
//
//    }
//    
//    if ([UserObject hadLog]) {
//        [dict setObject: [BaseObjectRequest sharedInstance].userid forKey:@"uid"];
//        
//    }
//
//    return dict;
}
@end


@implementation DeviceObjectSceneModel
@synthesize request=_request;

-(NSString*)getPath
{
    return [NSString stringWithFormat:@"%@/%@/%ld/%@/%@",self.request.PATH,[UserObject sharedInstance].uid,self.request.page,@"10",self.request.keyword];
    
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
    self.request  = [DeviceObjectRequest RequestWithBlock:^{
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
         
         NSDictionary *dict = [self.request.output objectAtPath:@"response"];
//         NSDictionary *dict =  self.request.output  ;
         
         NSArray* list  =  [[DeviceObject objectArrayWithKeyValuesArray:dict[@"dataList"] error:&error]mutableCopy ] ;
         NSInteger totalPage = [dict[@"totalPage"] integerValue];
 
         
         [self getArray:list totalPage:totalPage];
         
     }];
    
}



@end