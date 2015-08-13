//
//  BaseObject.h
//  Fanli
//
//  Created by zhiyun.com on 15-4-8.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "Easy.h"
#import "SceneModel.h"

///基础对象 集合
@interface BaseObjectRequest : Request
AS_SINGLETON(BaseObjectRequest)
@property (nonatomic,strong) NSString *userid;
@property (nonatomic,strong) NSString *device;
@property (nonatomic,strong) NSString *version;
@property (nonatomic,strong) NSString *session_token;
+(NSMutableDictionary*)getBaseRequestInfos;
@end


@interface BaseListObjectRequest : BaseObjectRequest
@property(strong,nonatomic) NSString *page;
@end


@interface BaseObject : NSObject
@end

@interface BaseSceneModel : SceneModel
@property(nonatomic,retain) NSMutableArray *dataArray;
@end


