//
//  ThirdObject.h
//  Fanli
//
//  Created by zhiyun.com on 15/4/15.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import <Foundation/Foundation.h>

///三方登陆相关
@interface ThirdObject : NSObject
@property (nonatomic, strong ) NSString *type;
@property (nonatomic, strong ) NSString *code;
@property (nonatomic, strong ) NSString *client_id;

AS_SINGLETON(ThirdObject)
@end
