
//
//  ThirdObject.m
//  Fanli
//
//  Created by zhiyun.com on 15/4/15.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import "ThirdObject.h"

@implementation ThirdObject
DEF_SINGLETON(ThirdObject)
-(NSString *)client_id
{
    if (_client_id==nil) {
        return @"";
    }
    return _client_id;
}
@end
