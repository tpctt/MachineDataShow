//
//  Config.h
//  Fanli
//
//  Created by zhiyun.com on 15-4-8.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import "Model.h"
#import <AVFoundation/AVFoundation.h>

#define getYandH(uiview) (uiview.frame.origin.y + uiview.frame.size.height)
#define getXandW(uiview) (uiview.frame.origin.x + uiview.frame.size.width)

#define FLlogin @"FLlogin"
#define FLlogout  @"FLlogout"

//app 配置
@interface Config : NSObject
@property (strong,nonatomic)  AVAudioPlayer *player;

@property (strong,nonatomic) NSString * aps_token;
@property (strong,nonatomic) NSString * name;
@property (strong,nonatomic) NSString * pwd;



@property (strong,nonatomic) NSString *deviceToken;

@property (strong,nonatomic) UIColor *leftViewBackgroudColor;
@property (strong,nonatomic) UIColor *viewBackgroudColor;
@property (strong,nonatomic) UIColor *appMainColor;
@property (strong,nonatomic) UIColor *appYellowColor;
@property (strong,nonatomic) UIColor *appBlueColor;
@property (strong,nonatomic) UIColor *borderColor;

@property (strong,nonatomic) NSString *phone;

@property (strong,nonatomic) NSString *qq1;
@property (strong,nonatomic) NSString *qq2;
@property (strong,nonatomic) NSString *homePage;
@property (strong,nonatomic) NSString *companyName;


@property (assign) BOOL audioEnable;
@property (assign) BOOL pushEnable;



AS_SINGLETON(Config)

+(EzUserDefaults *)appUserDefaults;
+(BOOL)isFirstTimeLauchThisVersion;
+(void)addLayerTo:(UIView*)view color:(UIColor*)color;
-(void)playerAudio:(NSString*)name type:(NSString*)type;


@end
