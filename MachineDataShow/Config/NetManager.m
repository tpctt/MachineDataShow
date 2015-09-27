//
//  NetManager.m
//  Fanli
//
//  Created by zhiyun.com on 15-4-10.
//  Copyright (c) 2015年 Tim All rights reserved.
//

#import "NetManager.h"
#import <EasyIOS/Action.h>
#import "RequestConfig.h"
#import "AppDelegate.h"
#import "BaseObject.h"

#import "FixProgressViewController.h"
#import <TMCache/TMCache.h>

@implementation NetManager
+(NSString*)removiewHuhao:(NSString*)string
{
    if ([string hasPrefix:@"\""]) {
        string = [string substringFromIndex:1];
    }
    if ([string hasSuffix:@"\""]) {
        string = [string substringToIndex:string.length-1];

    }
    return string;
}
+(NSString *)getErrorMsg:(NSString*)code
{
    NSDictionary *INFO = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ErrorCode" ofType:@"plist"]];
    
    return [INFO objectAtPath:code];
    
    return nil;
}
+(AFHTTPRequestOperation*)RegMobile:(NSString*)mobile
                           password:(NSString *)password
                               code:(NSString *)code
                              block:(HotKeyBlock)block
{

    NSString *PATH = [NSString stringWithFormat:@"%@/%@/%@/%@",@"userRegisterJson",mobile,password, code];
  
    
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSString* stateString =  operation.responseString  ;
        stateString = [self removiewHuhao:stateString];
        int state = [stateString intValue];
        
        if (state >0  ) {
            [UserObject sharedInstance].uid = stateString;
          
            block(@[@(state)],nil,nil);
 
        }else{
            block(nil,nil,[self getErrorMsg:stateString]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil, error,nil);
        
    }];
    
    return op;

}

+(AFHTTPRequestOperation*)wanshanziliao: (NSString*)trueName
                            companyName:(NSString*)companyName
                                   duty:(NSString*)duty
                                  email:(NSString*)email
                                    fax:(NSString*)fax
                                address:(NSString*)address
                               isModify:(BOOL)isModify

                                  block:(HotKeyBlock)block
{
    
    NSString *PATH = [NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@/%@/%@/%@/%@%@",isModify?@"setUserInfoJson":@"userRegisterCompleteJson",[UserObject sharedInstance].uid,companyName, @"SHENGFEN",@"CHENGSHI",@"HANGYE",@"BUMEN",duty,email,address,isModify?@"":@"/0"];
    
    PATH = [PATH stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionary ];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        UserObject *obj = [UserObject objectWithKeyValues:jsonObject];
        if ([obj.uid integerValue]>0) {
            [UserObject setDataFrom:obj];
            
            block(@[obj],nil,nil);

        }
        else{
            block(nil,nil,[self getErrorMsg:[self removiewHuhao:operation.responseString]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil, error,nil);
        
    }];
    
    return op;
    
}

+(AFHTTPRequestOperation*)LogMobile:(NSString*)mobile
                           password:(NSString *)password
                              block:(HotKeyBlock)block
{
    
    NSString *PATH = [NSString stringWithFormat:@"%@/%@/%@",@"userLoginJson",mobile,password];
    
    
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSString* stateString =  operation.responseString  ;
        stateString = [self removiewHuhao:stateString];
        int state = [stateString intValue];
        
        if (state >0  ) {
            [UserObject sharedInstance].uid = stateString;
            
            block(@[@(state)],nil,nil);
            
        }else{
            block(nil,nil,[self getErrorMsg:stateString]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil, error,nil);
        
    }];
    
    return op;
    
}

+(AFHTTPRequestOperation*)getUserInfo :(HotKeyBlock)block
{
    
    NSString *PATH = [NSString stringWithFormat:@"%@/%@",@"getUserInfoJson",[UserObject sharedInstance].uid];
    PATH = [PATH stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionary ];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        UserObject *obj = [UserObject objectWithKeyValues:jsonObject];
        if ([obj.uid integerValue]>0) {
            [UserObject setDataFrom:obj];
            [UserObject save];

            block(@[obj],nil,nil);
            
        }
        else{
            block(nil,nil,[self getErrorMsg:(NSString*)jsonObject]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil, error,nil);
        
    }];
    
    return op;
    
}
+(AFHTTPRequestOperation*)uploadHead:(UIImage *)image
                               block:(HotKeyBlock)block
{
     NSString *PATH = [NSString stringWithFormat:@"%@",@"uploadHeadJson"];
    PATH = [PATH stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSDictionary *requestParams = [NSMutableDictionary dictionary ];
    [requestParams setValue:[[UserObject sharedInstance] uid] forKey:@"uid"];
    [requestParams setValue:@"JPG" forKey:@"FileType"];
    
    
    
    NSData *imageData = UIImagePNGRepresentation(image);
    if(imageData==nil){
        imageData = UIImageJPEGRepresentation(image, 1);
    }
    NSString *REQU = [NSString stringWithFormat:@"%@",requestParams];
    NSData *requData = [REQU dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSNumber*  size = @(requData.length);
    NSString *sizeString = [NSString stringWithFormat:@"%d",size];
    NSData *sizeData = [sizeString dataUsingEncoding:NSASCIIStringEncoding];
    NSMutableData *data = [NSMutableData data];
    
    [data getBytes:&size length:4];
 //    [data appendData:sizeData];
    [data appendData:requData];
    [data appendData:imageData];
    
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
    
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:[NSDictionary dictionary] constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:data name:@"head"];
        
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSString* stateString =  operation.responseString  ;
        stateString = [self removiewHuhao:stateString];
        int state = [stateString intValue];
        
        if (state >0  ) {
            
            block(@[@(state)],nil,nil);
            
        }else{
            block(nil,nil,[self getErrorMsg:stateString]);
        }
        
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil, error,nil);
        
    }];
    
    return op;
}

 
+(AFHTTPRequestOperation*)setpassword:(NSString*)oldpwd
                             password:(NSString*)password

                                block:(HotKeyBlock)block
{
    
    NSString *PATH = [NSString stringWithFormat:@"%@/%@/%@/%@",@"setUserPasswordJson",[UserObject sharedInstance].uid,oldpwd,password];
    
    
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSString* stateString =  operation.responseString  ;
        stateString = [self removiewHuhao:stateString];
        int state = [stateString intValue];
        
        if (state >0  ) {
//            [UserObject sharedInstance].uid = stateString;
            
            block(@[@(state)],nil,nil);
            
        }else{
            block(nil,nil,[self getErrorMsg:stateString]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil, error,nil);
        
    }];
    
    return op;
    
}

+(AFHTTPRequestOperation*)setEquipmentRepairID:(NSString*)equipmentId
                                       contact:(NSString*)contact
                                          tele:(NSString*)tele
                                        detail:(NSString*)detail

                                        images:(NSArray*)images
                                        videos:(NSArray*)videos

                                         block:(HotKeyBlock)block
{
    
    NSString *PATH = [NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@/%@",@"setEquipmentRepairJson",[UserObject sharedInstance].uid,equipmentId,contact,tele,detail,[TimeTool formatDateSinceNow:0 formatWith:@"YYYY-MM-dd"]];
    PATH = [PATH stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
//    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    NSMutableDictionary *requestParams = nil;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(images.count){
            [formData appendPartWithFormData:UIImageJPEGRepresentation(images[0], 1) name:@"attachment"];
        }
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSString* stateString =  operation.responseString  ;
        stateString = [self removiewHuhao:stateString];
        int state = [stateString intValue];
        
        if (state >0  ) {
            //            [UserObject sharedInstance].uid = stateString;
            
            block(@[@(state)],nil,nil);
            
        }else{
            block(nil,nil,[self getErrorMsg:stateString]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil, error,nil);
        
    }];
    
    return op;
    
}

+(AFHTTPRequestOperation*)getFixedProgressInfo:(NSString*)objid block:(HotKeyBlock)block
{
    NSString *PATH = [NSString stringWithFormat:@"%@/%@/%@",@"getUserRepairInfoJson",[UserObject sharedInstance].uid,objid  ];
    
    
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
         if ([jsonObject isKindOfClass:[NSDictionary class] ] ) {
        
            
            FixedProgressInfo *OBJ = [FixedProgressInfo objectWithKeyValues:jsonObject  ];
           
            
            block(@[OBJ],nil,nil);
            
            
        }else{
            block(nil,nil,[self getErrorMsg:[self removiewHuhao:operation.responseString]]);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil, error,nil);
        
    }];
    
    return op;
}
+(AFHTTPRequestOperation*)getHomeAdsblock:(HotKeyBlock)block{
    NSString *PATH = @"getFlashJson";
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json",@"application/octet-stream"]];
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
//        NSString *jsonstring=[[NSString alloc] initWithData:[operation.responseData subdataWithRange:NSMakeRange(8, operation.responseData.length - 8)]encoding:NSUTF8StringEncoding];
//        if(jsonstring.length==0){
//            unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//            jsonstring = [[NSString alloc] initWithData:operation.responseData encoding:encode];
//        }
//
        NSData *lengthData = [operation.responseData subdataWithRange:NSMakeRange(0, 4)];
        NSString *string = [NSString stringWithFormat:@"%@",lengthData];
        string = [string substringWithRange:NSMakeRange(1, string.length-2   )];
        NSInteger length1 = strtol(string.UTF8String, nil, 16);
        
        NSData *data =  [operation.responseData subdataWithRange:NSMakeRange(4, length1)];
        NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
        
        NSInteger  filesNum = [[info objectAtPath:@"filesNum"] integerValue];
        NSMutableArray *ARRAY = [NSMutableArray array ];
        
        int preSize = 4+length1;
        
        for (int i = 0; i< filesNum; i++) {
            NSString *PROPERTY = [info objectAtPath:[NSString stringWithFormat:@"file%dProperty",i + 1]];
            NSString *SIZE = [info objectAtPath:[NSString stringWithFormat:@"file%dSize",i + 1]];
            NSString *TYPE = [info objectAtPath:[NSString stringWithFormat:@"file%dType",i + 1]];

            NSData *imageData = [operation.responseData subdataWithRange:NSMakeRange(preSize, [SIZE integerValue])];
            HomeAD *AD = [[HomeAD alloc]init];
            AD.REALimage = [UIImage imageWithData:imageData];
            
            [ARRAY addObject:AD];
            
            preSize+= [SIZE integerValue];
            
        }
        block(ARRAY,nil,nil);

        
        
        return ;
        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSArray *KEYVAULES =[jsonObject objectAtPath:@"response/dataList"];
            [[TMCache sharedCache]setObject:KEYVAULES forKey:@"adArrayKeyvaules"];
            
            NSArray *array = [HomeAD objectArrayWithKeyValuesArray:KEYVAULES error:nil];
            
            block(array,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
            
        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil, error,nil);
        
    }];
    
    
    
    return op;
    
}
 + (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
     return unicodeString;
    
    
}
+(AFHTTPRequestOperation*)yuyue:(NSString*)compangyName
                      peoplesum:(NSString*)peoplesum
                           duty:(NSString*)duty
                           tele:(NSString*)tele
                           time:(NSString*)time
                           desc:(NSString*)desc

                          block:(HotKeyBlock)block
{
    NSString *PATH = [NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@/%@/%@/%@",@"setVisitJson",[UserObject sharedInstance].uid,compangyName,peoplesum ,duty,tele ,time,desc,[TimeTool formatDateSinceNow:0 formatWith:@"YYYY-MM-DD"]];
    PATH = [PATH stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
//    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionary ];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
    
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSString* stateString =  operation.responseString  ;
        stateString = [self removiewHuhao:stateString];
        int state = [stateString intValue];
        
        if (state >0  ) {
            //            [UserObject sharedInstance].uid = stateString;
            
            block(@[@(state)],nil,nil);
            
        }else{
            block(nil,nil,[self getErrorMsg:stateString]);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil, error,nil);
        
    }];
    
    return op;
}



+(AFHTTPRequestOperation*)setUserInfotrueName:(NSString*)trueName
                                  companyName:(NSString*)companyName
                                         duty:(NSString*)duty
                                        email:(NSString*)email
                                          fax:(NSString*)fax
                                      address:(NSString*)address
                                          sex:(int)sex

                                        block:(HotKeyBlock)block
{
    NSString *PATH = @"setUserInfo.php";
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    [requestParams setValue:[[UserObject sharedInstance] uid] forKey:@"uid"];
    [requestParams setValue:trueName forKey:@"trueName"];
    [requestParams setValue:companyName forKey:@"companyName"];
    [requestParams setValue:duty forKey:@"duty"];
    [requestParams setValue:email forKey:@"email"];
    [requestParams setValue:fax forKey:@"fax"];
    [requestParams setValue:address forKey:@"address"];
    [requestParams setValue:@(sex) forKey:@"sex"];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
    
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSString *string = [jsonObject stringAtPath:@"response/text"];
            if (!string) {
                string=@"";
            }
            
            block(@[string],nil,[jsonObject objectAtPath:@"response/text"]);
            
            
        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil, error,nil);
        
    }];
    
    return op;
}


+(AFHTTPRequestOperation*)faceback:(NSString*)content
                              tele:(NSString*)tele

                             block:(HotKeyBlock)block
{
    NSString *PATH = [NSString stringWithFormat:@"%@/%@/%@/%@/%@",@"setFeedbackJson",[UserObject sharedInstance].uid,content,tele ,[TimeTool formatDateSinceNow:0 formatWith:@"YYYY-MM-DD"]];
    PATH = [PATH stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    [requestParams setValue:[[UserObject sharedInstance] uid] forKey:@"uid"];
    //    [requestParams setValue:equipmentId forKey:@"equipmentId"];
    [requestParams setValue:content forKey:@"content"];
    [requestParams setValue:tele forKey:@"tele"];
    
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
    
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:[NSDictionary dictionary ] constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSString* stateString =  operation.responseString  ;
        stateString = [self removiewHuhao:stateString];
        int state = [stateString intValue];
        
        if (state >0  ) {
            //            [UserObject sharedInstance].uid = stateString;
            
            block(@[@(state)],nil,nil);
            
        }else{
            block(nil,nil,[self getErrorMsg:stateString]);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil, error,nil);
        
    }];
    
    return op;
}
+(AFHTTPRequestOperation*)yuyueDetail:(NSString*)id
        block:(HotKeyBlock)block
{
    NSString *PATH = @"getAppointmentInfo.php";
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    //    [requestParams setValue:[[UserObject sharedInstance] uid] forKey:@"uid"];
    //    [requestParams setValue:equipmentId forKey:@"equipmentId"];
    [requestParams setValue:id forKey:@"id"];
 
    
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
    
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams  success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            UserObject *OBJ = [UserObject objectWithKeyValues:[jsonObject objectAtPath:@"response"]];
            NSString *string = [jsonObject stringAtPath:@"response/text"];
            if (!string) {
                string=@"";
            }
            
            block(@[string],nil,[jsonObject objectAtPath:@"response/text"]);
            
            
        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil, error,nil);
        
    }];
    
    return op;
}


+(AFHTTPRequestOperation*)getDakaData:(DataDataBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance]dakashuju];

    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSError *error = nil;
            DakaObject *data = [DakaObject objectWithKeyValues:jsonObject[@"data"] error:&error];
            
            block(data,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
            
        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error,nil);
        
    }];
    
    return op;
}

+(AFHTTPRequestOperation*)daka:(DataDataBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance]dakaZHUANQIAN];
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSError *error = nil;
            DakaObject *data = [DakaObject objectWithKeyValues:jsonObject[@"data"] error:&error];
            
            block(data,nil,[jsonObject objectAtPath:@"response/errorText"]);
 
        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);

        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error,nil);
        
    }];
    
    return op;
}

//+(AFHTTPRequestOperation*)getHotSearch:(NSInteger)num block:(HotKeyBlock)block
//{
//    NSString *PATH = [[RequestConfig sharedInstance]hotSearchKey];
//    
//    NSString *url = nil;
//    NSRange rang = [AppHostAddress rangeOfString:@"://"];
//    if (rang.length) {
//        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
//    }else{
//        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
//    }
//
//    NSDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
// 
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//   
//    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
// 
//    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
// 
//    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
//
//        NSInteger state = [[jsonObject numberAtPath:@"status"] integerValue];
//        if (state == 1  ) {
//
//            NSArray *ARRAY = [NSString objectsFromArray:[jsonObject objectAtPath:@"data/list"] ];
//            
//            block(ARRAY,nil,[jsonObject objectAtPath:@"msg"]);
//            
//            
//        }else{
//            block(nil,nil,[jsonObject objectAtPath:@"msg"]);
//            
//        }
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//        block(nil, error,nil);
//        
//    }];
//    
//    return op;
//}

+(AFHTTPRequestOperation*)getTBurl:(NSString*)key block:(TBurlWithKey)block
{
    NSString *PATH = [[RequestConfig sharedInstance] search];
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    if (key) {
        [requestParams setValue:key forKey:@"keyword"];
    }

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
  
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
  
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
  
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {

        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSString*url  =  [jsonObject objectAtPath:@"data/search_url" ];
            NSString*type  =  [jsonObject objectAtPath:@"data/type"]  ;
 
            block(url,type,nil,[jsonObject objectAtPath:@"response/errorText"]);

        }else{
            block(nil,nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,nil, error,nil);
        
    }];

    return op;
    
}

+(AFHTTPRequestOperation*)getTBurlByNUM:(NSString*)NUMID tc:(NSString*)tc block:(TBurlWithKey)block
{
    NSString *PATH = [[RequestConfig sharedInstance] PRODuCTdetail];
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    if (NUMID) {
        [requestParams setValue:NUMID forKey:@"num_iid"];
    }
    if (tc) {
        [requestParams setValue:tc forKey:@"tc"];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
  
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSString*url  =  [jsonObject objectAtPath:@"data/url" ];
 
            block(url,nil,nil,[jsonObject objectAtPath:@"response/errorText"]);

        }else{
            block(nil,nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,nil, error,nil);
        
    }];

    return op;
}


+(AFHTTPRequestOperation*)getUserData:(GetUserDataBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] userInfo];
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
 
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
 
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {

        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            UserObject *OBJ  =  [UserObject objectWithKeyValues:[jsonObject objectAtPath:@"data"]]  ;

            block(OBJ,nil,[jsonObject objectAtPath:@"response/errorText"]);

        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        block(nil, error,nil);
        
    }];

    return op;
}

//+(AFHTTPRequestOperation*)emailReg:(NSString*)email  name:(NSString *)name pwd:(NSString*)pwd block:(LoinBlock)block
+(AFHTTPRequestOperation*)RegMobile:(NSString*)mobile
                           password:(NSString *)password
                               code:(NSString*)code
                           trueName:(NSString*)trueName
                        companyName:(NSString*)companyName
                               duty:(NSString*)duty
                              email:(NSString*)email
                                fax:(NSString*)fax
                            address:(NSString*)address

                             block:(HotKeyBlock)block
{
    
    NSString *PATH = nil;
    if (password) {
        PATH = [NSString stringWithFormat:@"/%@/%@/%@/%@",@"userRegisterJson",mobile,password, code];
    }else{
        PATH = [NSString stringWithFormat:@"/%@/%@/%@/%@",@"userRegisterJson",mobile,password, code];

    }
    
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
////    [requestParams setObject:userName atPath:@"userName"];
//    [requestParams setObject:password atPath:@"password"];
//    [requestParams setObject:trueName atPath:@"trueName"];
//    [requestParams setObject:companyName atPath:@"companyName"];
//    [requestParams setObject:duty atPath:@"duty"];
//    [requestParams setObject:mobile atPath:@"mobile"];
//    [requestParams setObject:email atPath:@"email"];
//    [requestParams setObject:fax atPath:@"fax"];
//    [requestParams setObject:address atPath:@"address"];
//    ///性别(0-保密、1-男、2-女)
//    [requestParams setObject:@"0" atPath:@"sex"];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            UserObject *OBJ  =  [UserObject objectWithKeyValues:[jsonObject objectAtPath:@"response"]]  ;
            if(OBJ){
//                [LoginObject sharedInstance].userid = OBJ.userid;
//                [LoginObject sharedInstance].session_token = OBJ.session_token;
//                [LoginObject sharedInstance].username =OBJ.username;
//                [LoginObject sharedInstance].avatar = OBJ.avatar;
                [UserObject setDataFrom:OBJ];
                [BaseObjectRequest sharedInstance].userid = OBJ.uid;
//                [BaseObjectRequest sharedInstance].session_token = OBJ.session_token;
                
                
//                [[NSNotificationCenter defaultCenter] postNotificationName:FLlogin object:nil];
                
            }
            
            block(OBJ,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil, error,nil);
        
    }];
    
    return op;
}
+(AFHTTPRequestOperation*)login:(NSString*)name pwd:(NSString*)pwd aps:(NSString *)aps block:(LoinBlock)block
{
    NSString *PATH = @"userLogin.php";
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
//    [requestParams setObject:aps forKey:@"aps_token"];
    [requestParams setObject:pwd forKey:@"password"];
    [requestParams setObject:name forKey:@"userName"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {

        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            UserObject *OBJ  =  [UserObject objectWithKeyValues:[jsonObject objectAtPath:@"response"]]  ;
            if(OBJ){
//                [LoginObject sharedInstance].userid = OBJ.userid;
//                [LoginObject sharedInstance].session_token = OBJ.session_token;
//                [LoginObject sharedInstance].username =OBJ.username;
//                [LoginObject sharedInstance].avatar = OBJ.avatar;
                
                [UserObject setDataFrom:OBJ];
                [BaseObjectRequest sharedInstance].userid = OBJ.uid;
             
                
                [UserObject save];

                
                [[NSNotificationCenter defaultCenter] postNotificationName:FLlogin object:nil];
                                 
            }

            block(OBJ,nil,[jsonObject objectAtPath:@"response/text"]);

        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        block(nil, error,nil);
        
    }];

    return op;
}

+(AFHTTPRequestOperation*)thirdLogin:(NSString*)client_id type:(NSString*)type code:(NSString*)code aps:(NSString *)aps block:(LoinBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] thirdloginCallBack];
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    if (aps) {
        [requestParams setObject:aps forKey:@"aps_token"];
        
    }
    if (type) {
        [requestParams setObject:type forKey:@"type"];
        
    }
    if (code) {
        [requestParams setObject:code forKey:@"code"];
        
    }
    if (client_id) {
        [requestParams setObject:client_id forKey:@"client_id"];
        
    }

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
 
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
 
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            LoginObject *OBJ  =  [LoginObject objectWithKeyValues:[jsonObject objectAtPath:@"data"]]  ;
            if(OBJ){
                
                [LoginObject sharedInstance].userid = OBJ.userid;
                [LoginObject sharedInstance].session_token = OBJ.session_token;
                [LoginObject sharedInstance].username =OBJ.username;
                [LoginObject sharedInstance].avatar = OBJ.avatar;
                
                [BaseObjectRequest sharedInstance].userid = OBJ.userid;
                [BaseObjectRequest sharedInstance].session_token = OBJ.session_token;
 
                [[NSNotificationCenter defaultCenter] postNotificationName:FLlogin object:nil];

            }
            block(OBJ,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error,nil);
        
    }];

    return op;
}

+(AFHTTPRequestOperation*)thirdLoginAddressType:(NSString*)type block:(LoinBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] thirdlogin];
    PATH = [PATH stringByAppendingString:type];
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];

    [requestParams setObject:type forKey:@"type"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {

        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {

            LoginObject *OBJ  =  [LoginObject objectWithKeyValues:[jsonObject objectAtPath:@"data"]]  ;
            if(OBJ){
                [LoginObject sharedInstance].userid = OBJ.userid;
                [LoginObject sharedInstance].session_token = OBJ.session_token;
                [LoginObject sharedInstance].username =OBJ.username;
                [LoginObject sharedInstance].avatar = OBJ.avatar;
                
                [BaseObjectRequest sharedInstance].userid = OBJ.userid;
                [BaseObjectRequest sharedInstance].session_token = OBJ.session_token;

                [[NSNotificationCenter defaultCenter] postNotificationName:FLlogin object:nil];
                
            }
        }else{
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
    
    
    return op;
}

+(AFHTTPRequestOperation*)sendEmailCode:(NSString*)mail isBanding:(BOOL) isBanding block:(SendMailBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] sendEmailCode];

    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
 
    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    [requestParams setObject:isBanding?@"2":@"0" forKey:@"type"];
    [requestParams setObject:mail forKey:@"email"];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {

        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSString *goUrl =  [jsonObject objectAtPath:@"data/email_goto_url"]; ;

            block(goUrl,nil,[jsonObject objectAtPath:@"response/errorText"]);

        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error,nil);
        
    }];
    
    return op;
}

+(AFHTTPRequestOperation*)checkEmail:(NSString*)mail Code:(NSString*)mailCode  block:(SendMailBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] checkEmailCode];

    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];

    [requestParams setObject:mail forKey:@"email"];
    
    [requestParams setObject:mailCode forKey:@"code"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSString *goUrl =  [jsonObject objectAtPath:@"data/success"]; ;

            block(goUrl,nil,[jsonObject objectAtPath:@"response/errorText"]);

        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }
 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        block(nil, error,nil);
        
    }];

    return op;
}

+(AFHTTPRequestOperation*)modifyPassword:(NSString*)ids isMail:(BOOL)isMall password:(NSString*)password code:(NSString*)code re_password:(NSString*)re_password client_id:(NSString*)client_id block:(LoinBlock)block;
{
    NSString *PATH = [[RequestConfig sharedInstance] modifyPassword];

    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];

    [requestParams setObject:code forKey:@"code"];
    if (isMall) {
        [requestParams setObject:ids forKey:@"email"];
        [requestParams setObject:@"1" forKey:@"type"];
        
    }else{
        [requestParams setObject:ids forKey:@"mobile"];
        [requestParams setObject:@"2" forKey:@"type"];
        
    }
    [requestParams setObject:client_id forKey:@"client_id"];
    [requestParams setObject:password forKey:@"password"];
    [requestParams setObject:re_password forKey:@"re_password"];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
 
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
 
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {

        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {

            LoginObject *OBJ  =  [LoginObject objectWithKeyValues:[jsonObject objectAtPath:@"data"]]  ;
            if(OBJ){
                [LoginObject sharedInstance].userid = OBJ.userid;
                [LoginObject sharedInstance].session_token = OBJ.session_token;
                [LoginObject sharedInstance].username =OBJ.username;
                [LoginObject sharedInstance].avatar = OBJ.avatar;
                
                [BaseObjectRequest sharedInstance].userid = OBJ.userid;
                [BaseObjectRequest sharedInstance].session_token = OBJ.session_token;

                [[NSNotificationCenter defaultCenter] postNotificationName:FLlogin object:nil];
            }
            
            block(OBJ,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
            
        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
  
        block(nil, error,nil);
        
    }];

    return op;
}

////发送手机验证码
+(AFHTTPRequestOperation*)sendMobileCode:(NSString*)mobile isBanding:(BOOL)isBanding  block:(SendMailBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] sendMobileCode];

    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];

    [requestParams setObject:mobile forKey:@"mobile"];
    if(isBanding){
        [requestParams setObject:@"2" forKey:@"type"];
        
    }else{
        [requestParams setObject:@"1" forKey:@"type"];
        
    }

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {

        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {

            NSString *goUrl =  [jsonObject stringAtPath:@"data/success"]; ;

            block(goUrl,nil,[jsonObject objectAtPath:@"response/errorText"]);

        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        block(nil, error,nil);
        
    }];

    return op;
}

+(AFHTTPRequestOperation*)checkMobileCode:(NSString*)mobile code:(NSString*)code  block:(SendMailBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] checkMobileCode];

    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
 
    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];

    [requestParams setObject:mobile forKey:@"mobile"];
    [requestParams setObject:code forKey:@"code"];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {

        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {

            NSString *goUrl =  [jsonObject objectAtPath:@"data/success"]; ;

            block(goUrl,nil,[jsonObject objectAtPath:@"response/errorText"]);

        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        block(nil, error,nil);
        
    }];
    
    return op;
}

+(AFHTTPRequestOperation*)bindMobile:(NSString*)mobile code:(NSString*)code  block:(SendMailBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] bindMobile];

    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];

    [requestParams setObject:mobile forKey:@"mobile"];
    [requestParams setObject:code forKey:@"code"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {

        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSString *goUrl =  [jsonObject objectAtPath:@"data/mobile"]; ;

            block(goUrl,nil,[jsonObject objectAtPath:@"response/errorText"]);
 
        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        block(nil, error,nil);
        
    }];

    return op;
}

+(AFHTTPRequestOperation*)bindAlipay:(NSString*)alipay_account alipay_realname:(NSString*)alipay_realname code:(NSString*)code  block:(BandingAlipayBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] bindAlipay];
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    
    [requestParams setObject:alipay_realname forKey:@"alipay_realname"];
    [requestParams setObject:alipay_account forKey:@"alipay_account"];
    [requestParams setObject:code forKey:@"code"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
 
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
 
        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSString *alipay_account =  [jsonObject objectAtPath:@"data/alipay_account"]; ;
            NSString *alipay_realname =  [jsonObject objectAtPath:@"data/alipay_realname"]; ;

            block(alipay_account,alipay_realname,nil,[jsonObject objectAtPath:@"response/errorText"]);

        }else{
            block(nil,nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        block(nil,nil, error,nil);
        
    }];

    return op;
}

+(AFHTTPRequestOperation*)sendMobileAuthCode:(SendMailBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] sendMobileAuthCode];

    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
   
    
    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {

        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSString *success =  [jsonObject objectAtPath:@"data/success"]; ;
            block(success,nil,[jsonObject objectAtPath:@"response/errorText"]);

        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
        }
  
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil, error,nil);
        
    }];

    return op;
}

+(AFHTTPRequestOperation*)getSecurityInfo:(GetSecurityInfoBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] getSecurityInfo];

    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {

        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSString *is_validate_mobile = [jsonObject objectAtPath:@"data/is_validate_mobile"];
            NSString*is_validate_account= [jsonObject objectAtPath:@"data/is_validate_account"];
            
            NSString*mobile =[jsonObject objectAtPath:@"data/mobile"];
            NSString*alipay_need_code= [jsonObject objectAtPath:@"data/alipay_need_code"];
            
            NSString*is_validate_email =[jsonObject objectAtPath:@"data/is_validate_email"];
            NSString*email= [jsonObject objectAtPath:@"data/email"];
            
            NSString*card_id= [jsonObject objectAtPath:@"data/alipay/card_id"];
            NSString*real_name= [jsonObject objectAtPath:@"data/alipay/real_name"];
 
            BandingObject *bandingObject = [[BandingObject alloc] init];
            
            bandingObject.is_validate_mobile =is_validate_mobile;
            bandingObject.is_validate_account =is_validate_account;
            bandingObject.is_validate_email =is_validate_email;
            
            bandingObject.email =email;
            bandingObject.mobile =mobile;
            bandingObject.alipay_need_code =alipay_need_code;
            
            bandingObject.card_id =card_id;
            bandingObject.real_name =real_name;
  
            block( bandingObject ,nil,[jsonObject objectAtPath:@"response/errorText"]);

        }else{
            block( nil,   nil,[jsonObject objectAtPath:@"response/errorText"]);
            
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block( nil, error,nil);
        
    }];

    return op;
}

+(AFHTTPRequestOperation*)bindEmail:(NSString*)mail code:(NSString*)code  block:(SendMailBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] bindEmail];

    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];

    [requestParams setObject:mail forKey:@"email"];
    [requestParams setObject:code forKey:@"code"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
 
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {

        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSString *success =  [jsonObject objectAtPath:@"data/email"]; ;
            block(success,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
            
        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        block(nil, error,nil);
        
    }];

    return op;
}

////返利提现申请
+(AFHTTPRequestOperation*)subWithdrawRebate:(NSString*)money   block:(SendMailBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] subWithdrawRebate];

    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];

    [requestParams setObject:money forKey:@"money"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {

        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSString *success =  [jsonObject objectAtPath:@"data/success"]; ;

            block(success,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
            
        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error,nil);
        
    }];
    
    
    return op;
}

////集分宝提现申请
+(AFHTTPRequestOperation*)subWithdrawJifenbao:(NSString*)jifenbao   block:(SendMailBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] subWithdrawJifenbao];

    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];

    [requestParams setObject:jifenbao forKey:@"jifenbao"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSString *success =  [jsonObject objectAtPath:@"data/success"]; ;
            block(success,nil,[jsonObject objectAtPath:@"response/errorText"]);
            
        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error,nil);
        
    }];
    
    
    return op;
}

////设置->关闭推送通知
+(AFHTTPRequestOperation*)filterOrderNotify:(BOOL)enable   block:(SendMailBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] filterOrderNotify];
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];

    if (enable) {
        //0：关闭推送
        //1：开启推送
        [requestParams setObject:@"1" forKey:@"status"];
        
    }else{
        
        [requestParams setObject:@"0" forKey:@"status"];
    }

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {

        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSString *success =  [jsonObject objectAtPath:@"data/success"]; ;
            block(success,nil,[jsonObject objectAtPath:@"response/errorText"]);

        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error,nil);
        
    }];

    return op;
}

////检查session有效期（每次进入个人中心都执行）
+(AFHTTPRequestOperation*)checkSessionExpired:(BOOL)enable   block:(checkSessionExpiredBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] checkSessionExpired];
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }
    
    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];

    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            LoginObject *OBJ  =  [LoginObject objectWithKeyValues:[jsonObject objectAtPath:@"data"]]  ;
            NSString *checkSessionExpiredString = [jsonObject objectAtPath:@"data/checkSessionExpired"];
            BOOL checkSessionExpired = [checkSessionExpiredString boolValue];
            
            if(OBJ){
                [LoginObject sharedInstance].userid = OBJ.userid;
                [LoginObject sharedInstance].session_token = OBJ.session_token;
                [LoginObject sharedInstance].username =OBJ.username;
                [LoginObject sharedInstance].avatar = OBJ.avatar;
                
                [BaseObjectRequest sharedInstance].userid = OBJ.userid;
                [BaseObjectRequest sharedInstance].session_token = OBJ.session_token;
                
                
//                [[NSNotificationCenter defaultCenter] postNotificationName:FLlogin object:nil];
            }
            block(checkSessionExpired,OBJ,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }else{
            block(NO,nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO,nil, error,nil);
    }];
    return op;
}

///问题反馈：提交
+(AFHTTPRequestOperation*)advise:(NSString *)content  connect:(NSString *)connect   block:(SendMailBlock)block
{
    NSString *PATH = [[RequestConfig sharedInstance] advise];
    
    NSString *url = nil;
    NSRange rang = [AppHostAddress rangeOfString:@"://"];
    if (rang.length) {
        url = [NSString stringWithFormat:@"%@%@",AppHostAddress,PATH ];
    }else{
        url = [NSString stringWithFormat:@"http://%@%@",AppHostAddress,PATH ];
    }

    NSMutableDictionary *requestParams = [BaseObjectRequest getBaseRequestInfos];
    if (content) {
        [requestParams setObject:content forKey:@"content"];
        
    }
    if (connect) {
        [requestParams setObject:connect forKey:@"connect"];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithArray:@[@"text/html",@"application/json"]];
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    } success:^(AFHTTPRequestOperation *operation, NSDictionary* jsonObject) {
        
        NSInteger state = [[jsonObject stringAtPath:@"result"] isEqualToString:requestOK];
        if (state == 1  ) {
            NSString *success =  [jsonObject objectAtPath:@"data/success"]; ;
            block(success,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }else{
            block(nil,nil,[jsonObject objectAtPath:@"response/errorText"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error,nil);
    }];
    
   
    
    return op;
}


@end
