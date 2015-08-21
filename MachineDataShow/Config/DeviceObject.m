//
//  DeviceObject.m
//  MachineDataShow
//
//  Created by tim on 15-8-15.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "DeviceObject.h"

@implementation DeviceObject
 
@end

@implementation DeviceObjectRequest
-(void)loadRequest
{
    [super loadRequest];
    self.page = 1;
    self.PATH = [[RequestConfig sharedInstance] home];
    self.PATH = @"getUserEquipmentList";
    
}
-(NSMutableDictionary *)requestParams{
    NSMutableDictionary *dict = [[super requestParams] mutableCopy];
//    [dict setObject: self.category forKey:@"category"];
//    [dict setObject: self.big_category forKey:@"big_category"];
//    [dict setObject: self.biz_type forKey:@"biz_type"];
    
    return dict;
}
@end


@implementation DeviceObjectSceneModel
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
          return 1 || self.request.succeed;
      }]
     subscribeNext:^(NSNumber *state) {
         @strongify(self);
         NSError *error;
         
         NSDictionary *dict = [self.request.output objectAtPath:@"data"];
//         NSDictionary *dict =  self.request.output  ;
         
         NSArray* list  =  [[DeviceObject objectArrayWithKeyValuesArray:dict[@"list"] error:&error]mutableCopy ] ;
         NSInteger totalPage = [dict[@"total_page"] integerValue];
         
         [self getArray:list totalPage:totalPage];
         
     }];
    
}



@end