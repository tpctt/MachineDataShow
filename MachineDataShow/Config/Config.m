//
//  Config.m
//  Fanli
//
//  Created by zhiyun.com on 15-4-8.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import "Config.h"
 
@implementation Config
DEF_SINGLETON(Config)
+(void)addLayerTo:(UIView*)view color:(UIColor*)color
{
    if (color==nil) {
        view.layer.borderColor = [[[Config sharedInstance]borderColor]CGColor];
    }else
        view.layer.borderColor = [color CGColor];

    
    view.layer.borderWidth = 1;
    
}
+(EzUserDefaults *)appUserDefaults
{
    return [EzUserDefaults sharedInstance];
}
+(BOOL)isFirstTimeLauchThisVersion
{
    NSString *preStr= [[Config appUserDefaults] objectForKey:@"launchVersion"];
    NSString *nowStr = [EzSystemInfo appVersion];
    [[Config appUserDefaults] setObject:nowStr forKey:@"launchVersion"];
    
    if (preStr.length ==0) {
        return YES;
    }
    
    if ([preStr isEqualToString:nowStr] == NO) {
        return YES;
    }
    
    return NO;
}

//TODO,apns,name,pwd

-(NSString *)aps_token
{
    NSString *string = [[Config appUserDefaults] objectForKey:@"aps_token"];
    if (string) {
        return string;
    }
    
    return @"";
}
-(void)setAps_token:(NSString *)aps_token
{

    [[Config appUserDefaults] setObject:aps_token forKey:@"aps_token"];
//    _aps_token = aps_token;
    
}
-(void)setAudioEnable:(BOOL)audioEnable
{
     [[Config appUserDefaults] setObject:[NSNumber numberWithBool:audioEnable] forKey:@"audioEnable"];
    
}
-(BOOL)audioEnable
{
    id aa = [[Config appUserDefaults]objectForKey:@"audioEnable"];
    return [aa boolValue];
    
}
-(void)setPushEnable:(BOOL)pushEnable
{
    [[Config appUserDefaults] setObject:[NSNumber numberWithBool:pushEnable] forKey:@"pushEnable"];
    
}
-(BOOL)pushEnable
{
    return [[[Config appUserDefaults]objectForKey:@"pushEnable"] boolValue];

}


-(void)playerAudio:(NSString*)name type:(NSString*)type
{
    if ([[Config sharedInstance] audioEnable] == NO) {
        return;
    }
    NSString *fileName = [[NSBundle mainBundle] pathForResource:name ofType:type];
    NSURL *fileUrl = [NSURL fileURLWithPath:fileName];
    NSError *error = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&error];
    if (! _player ) {
        
    } else {
        [ _player  setNumberOfLoops:0 ]; //默认为0，即播放一次就结束；如果设置为负值，则音频内容会不停的循环播放下去。
        //        [self.player  setDelegate:self];
        [_player prepareToPlay];
        [ _player  play];
    }

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.leftViewBackgroudColor = RGB(41, 47, 46);
        self.viewBackgroudColor = RGB(236, 236, 236);
        self.appMainColor = [UIColor colorWithString:@"#ff6699"];
        self.appYellowColor = RGB(245, 160, 27);
        self.appBlueColor = RGB(81, 119, 255);
        self.borderColor = RGB(214, 214, 214);
        
        
        //self.phone = @"15036263002";
        
        self.qq1 = @"800052377";
        self.qq2 = @"719064922";
        self.homePage = @"www.67bi.com";
        self.companyName = @"河南省南阳市Tim科技有限公司";
        
        NSString *audioEnable =@"audioEnable";
        if ([[EzUserDefaults sharedInstance]hasObjectForKey:audioEnable]) {
            self.audioEnable = [[[EzUserDefaults sharedInstance ] objectForKey:audioEnable] boolValue];
            
        }else{
            [[EzUserDefaults sharedInstance] setObject:@"1" forKey:audioEnable];
            self.audioEnable = YES;
        }
        
    }
    return self;
}


@end
