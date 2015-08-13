//
//  SmallObject.h
//  Fanli
//
//  Created by zhiyun.com on 15-4-11.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import <Foundation/Foundation.h>

///有一些小的数据对象,
///打卡
@interface SmallObject : NSObject

@end

@interface DakaObject : NSObject
@property (strong,nonatomic) NSString *jifenbao;
@property (assign) NSInteger hidden;


@end
