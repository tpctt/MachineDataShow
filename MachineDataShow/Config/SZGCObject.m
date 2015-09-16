//
//  SZGCObject.m
//  MachineDataShow
//
//  Created by tim on 15-9-5.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "SZGCObject.h"

@implementation SZGCObject
+(SZGCObject*)random
{
    SZGCObject*O = [[SZGCObject alloc]init];
    O.NAME = [NSString stringWithFormat:@"设备名字:%d",  arc4random()];
    O.all = [NSString stringWithFormat:@"%d",  arc4random()%1000];
    O.check = [NSString stringWithFormat:@"%d",  arc4random()%1000];
    O.good = [NSString stringWithFormat:@"%d",  arc4random()%1000];
    O.checkrate =  [NSString stringWithFormat:@"%f",  [O.check integerValue]/(CGFloat)[O.all integerValue]];
    O.goodrate =  [NSString stringWithFormat:@"%f",  [O.good integerValue]/(CGFloat)[O.all integerValue]];
    
    O.state =  arc4random()%10;
    
    
    return O;
}
@end
@implementation SZGCObjectRequest

-(void)loadRequest
{
    [super loadRequest];
    self.page = 1;
    //    self.PATH = [[RequestConfig sharedInstance] home];
    self.PATH = @"/getUserRepairList.php";
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


@implementation SZGCObjectSceneModel
-(void)loadSceneModel

{
    [super loadSceneModel];
    
    @weakify(self);
    self.request  = [SZGCObjectRequest RequestWithBlock:^{
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
         
         NSArray* list  =  [[SZGCObject objectArrayWithKeyValuesArray:dict[@"dataList"] error:&error]mutableCopy ] ;
         NSInteger totalPage = [dict[@"totalPage"] integerValue];
         
         
         [self getArray:list totalPage:totalPage];
         
     }];
    
}
@end