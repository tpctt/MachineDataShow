//
//  SZGCObject.m
//  MachineDataShow
//
//  Created by tim on 15-9-5.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "GCYSSB_Object.h"

@interface CLJ_object()<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *asyncSocket;
    
}
@property (strong,nonatomic)NSURLConnection *conn;
@property (assign,nonatomic)BOOL isEnd;

@end

@implementation  CLJ_object
DEF_SINGLETON(CLJ_object)
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.url = @"http://112.74.18.72:8080";
        self.responseData = [NSMutableData data];
        self.stateArray = [NSMutableArray array];
        self.productArray = [NSMutableArray array];
        self.DEVICE_STATE_Array = [NSMutableArray array];
        
        self.isEnd = YES;
        
    }
    return self;
}

-(void)start
{
    if ( _isEnd == NO) {
        return;
    }
    dispatch_queue_t mainQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:mainQueue];
    NSString *host = @"112.74.18.72";
    uint16_t port = 8080;
    
    NSError *error = nil;
    if (![asyncSocket connectToHost:host onPort:port error:&error])
    {
        
    }
    _isEnd = NO;

    
    return;
   //设置请求路径
    NSString *urlStr=self.url;
    NSURL *url=[NSURL URLWithString:urlStr];
    
    //   2.2创建请求对象
    //    NSURLRequest *request=[NSURLRequest requestWithURL:url];//默认就是GET请求
    //设置请求超时
    NSMutableURLRequest *request=[NSMutableURLRequest  requestWithURL:url];
//    request.HTTPMethod = @"telnet";
    request.timeoutInterval = 0.0 ;
    //   2.3.发送请求
    //使用代理发送异步请求（通常应用于文件下载）
    self.conn =[NSURLConnection connectionWithRequest:request delegate:self];
    [_conn start];
    
    
    NSLog(@"已经发出请求---");
    _isEnd = NO;
    
}

-(void)stop
{

}
#pragma mark delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"接收到服务器的数据22");

}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
 {
     NSLog(@"接收到服务器的数据");
   //拼接数据
     [self.responseData appendData:data];
     
     NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
     if(string.length==0){
         unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
         string = [[NSString alloc] initWithData:data encoding:encode];
     }
     if ([string hasPrefix:@"MachineStatus"]) {
//         MachineState|801112|Connected
//         State :Connected/Ready/Busy/Error
//     Connected:绿色  .
//         默认红色,其他三态保留
         
         NSArray *ARRAY = [string componentsSeparatedByString:@"|"];
         NSString *MachineID = [ARRAY safeObjectAtIndex:1];
         NSString *State = [ARRAY safeObjectAtIndex:2];
         if([State hasSuffix:@"\r\n"])
         {
             State  = [State substringToIndex:State.length - 2];
         }
         
         
         CLJ_deviceObj *obj = nil;
         for (CLJ_deviceObj *dev_Obj in self.stateArray) {
             if ([[dev_Obj.MachineID lowercaseString] isEqualToString:[MachineID lowercaseString]]) {
                 obj = dev_Obj;
                 
             }
         }
         
//         CLJ_deviceObj *obj = [[self.stateArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"MachineID = %@",MachineID]]] firstObject];
         if(obj==nil){
             obj = [[CLJ_deviceObj alloc] init];
             obj.State = State;
             obj.MachineID = MachineID;
             [self.stateArray addObject:obj];
             
         }else{
             obj.State = State;
             
         }
         self.receviceIndex = @(![self.receviceIndex boolValue]);

     }
     else if ([string hasPrefix:@"HumanResource"]){
//         e.g.
//         HumanResource|GM|5|3|QC|2|2|OP|32|20
//         
//     GM:管理人员
//         GMQTY：管理人员总人数
//         GMQTYOnline：管理人员在线人数
//         QC：质检人员
//         QCQTY：质检人员总人数
//         QCQTYOnline：质检人员总人数
//         OP：操作人员
//         OPQTY：操作人员总人数
//         OPQTYOnline：操作人员在线人数

         NSArray *ARRAY = [string componentsSeparatedByString:@"|"];
         NSString *GM = [ARRAY safeObjectAtIndex:1];
         NSString *GMQTY = [ARRAY safeObjectAtIndex:2];
         NSString *GMQTYOnline = [ARRAY safeObjectAtIndex:3];

         NSString *QC = [ARRAY safeObjectAtIndex:4];
         NSString *QCQTY = [ARRAY safeObjectAtIndex:5];
         NSString *QCQTYOnline = [ARRAY safeObjectAtIndex:6];

         NSString *QP = [ARRAY safeObjectAtIndex:7];
         NSString *QPQTY = [ARRAY safeObjectAtIndex:8];
         NSString *QPQTYOnline = [ARRAY safeObjectAtIndex:9];

         
         if([QPQTYOnline hasSuffix:@"\r\n"])
         {
             QPQTYOnline  = [QPQTYOnline substringToIndex:QPQTYOnline.length - 2];
         }
         
         CLJ_presonObj* obj = [[CLJ_presonObj alloc] init];
         obj.GM = GM;
         obj.GMQTY = GMQTY;
         obj.GMQTYOnline = GMQTYOnline;
         
         obj.QC = QC;
         obj.QCQTY = QCQTY;
         obj.QCQTYOnline = QCQTYOnline;
         
         obj.QP = QP;
         obj.QPQTY = QPQTY;
         obj.QPQTYOnline = QPQTYOnline;
         
         obj.GM = @"管理人员";
          obj.QC = @"质检人员";
          obj.QP = @"操作人员";
         
         
         self.presonObj = obj;
         
         self.receviceIndex = @(![self.receviceIndex boolValue]);

        
     }
     else if ([string hasPrefix:@"ProduceState"]) {
//         ProduceState |801234|BR1209|1203|500|499|BA0043|403|BA0054|502|BA0052|298

         
         NSArray *ARRAY = [string componentsSeparatedByString:@"|"];
         NSString *MachineID = [ARRAY safeObjectAtIndex:1];
         NSString *Task = [ARRAY safeObjectAtIndex:2];
         
         NSString *Output = [ARRAY safeObjectAtIndex:3];
         NSString *Checked = [ARRAY safeObjectAtIndex:4];
         NSString *OK = [ARRAY safeObjectAtIndex:5];

         
         
         if([OK hasSuffix:@"\r\n"])
         {
             OK  = [OK substringToIndex:OK.length - 2];
         }
         
         CLJ_productObj *obj = nil;
         for (CLJ_productObj *PRO_Obj in self.productArray) {
             if ([[PRO_Obj.MachineID lowercaseString] isEqualToString:[MachineID lowercaseString]]) {
                 obj = PRO_Obj;
                 
             }
         }
//         CLJ_productObj *obj = [[self.productArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"MachineID = %@",MachineID]]] firstObject];
         if(obj==nil){
             obj = [[CLJ_productObj alloc] init];
             obj.MachineID = MachineID;
             obj.Task = Task;
             obj.Output = Output;
             obj.Checked = Checked;
             obj.OK = OK;

             obj.preson_productArray = [NSMutableArray array];
             
             [self.productArray addObject:obj];
             
         }else{

             obj.Task = Task;
             obj.Output = Output;
             obj.Checked = Checked;
             obj.OK = OK;
             
         }
         
         for (int i = 6; i<ARRAY.count ; ) {
             NSString *Person = [ARRAY safeObjectAtIndex:i ];
             NSString *Output = [ARRAY safeObjectAtIndex:i+1 ];
             
             
             if([Output hasSuffix:@"\r\n"])
             {
                 Output  = [Output substringToIndex:Output.length - 2];
             }
             
             i+=2;
             CLJ_person_productObj *obj22 = nil;
             for (CLJ_person_productObj *Person_Obj in obj.preson_productArray) {
                 if ([[Person_Obj.Person lowercaseString]isEqualToString:[Person lowercaseString]]) {
                     obj22 = Person_Obj;
                     
                 }
             }
//             CLJ_person_productObj *obj22  =  [[obj.preson_productArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"Person = %@",Person]]] firstObject];
             if(obj22==nil){
                 obj22 = [[CLJ_person_productObj alloc] init];
                 
                 obj22.Person = Person;
//                 obj22.Pro = Pro;
                 obj22.Output = Output;
                
                 
                 
                 [obj.preson_productArray addObject:obj22];
                 
             }else{
                 
                 obj22.Person = Person;
//                 obj22.Pro = Pro;
                 obj22.Output = Output;
                 
                 
                 
             }
             
             
             
         }
         self.receviceIndex = @(![self.receviceIndex boolValue]);

      }else if ([string hasPrefix:@"PartState"]) {
         //         MachineState|801112|Connected
         //         State :Connected/Ready/Busy/Error
         //     Connected:绿色  .
         //         默认红色,其他三态保留
         
         NSArray *ARRAY = [string componentsSeparatedByString:@"|"];
         NSString *MachineID = [ARRAY safeObjectAtIndex:1];
         NSString *PartName = [ARRAY safeObjectAtIndex:2];
         NSString *StateClass = [ARRAY safeObjectAtIndex:3];
         NSString *State = [ARRAY safeObjectAtIndex:4];
         NSString *Note = [ARRAY safeObjectAtIndex:5];
         
         if([Note hasSuffix:@"\r\n"])
         {
             Note  = [Note substringToIndex:Note.length - 2];
         }
         
         CLJ_deveice_state_Obj *obj = nil;
         for (CLJ_deveice_state_Obj *dev_Obj in self.DEVICE_STATE_Array) {
             if ([[dev_Obj.MachineID lowercaseString] isEqualToString:[MachineID lowercaseString]]) {
                 obj = dev_Obj;
                 
             }
         }
         
         //         CLJ_deviceObj *obj = [[self.stateArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"MachineID = %@",MachineID]]] firstObject];
         if(obj==nil){
             obj = [[CLJ_deveice_state_Obj alloc] init];
             obj.MachineID = MachineID;
             obj.PartName = PartName;
             obj.StateClass = StateClass;
             obj.State = State;
             obj.Note = Note;
 
             
             
             [self.DEVICE_STATE_Array addObject:obj];
             
         }else{
             obj.MachineID = MachineID;
             obj.PartName = PartName;
             obj.StateClass = StateClass;
             obj.State = State;
             obj.Note = Note;
             
         }
         self.receviceIndex = @(![self.receviceIndex boolValue]);
         
     }

     
     
     NSLog(@"%d---%@--%@",self.responseData.length,[NSThread currentThread],string);

}


 /*
        *当服务器的数据加载完毕时就会调用
*/

 -(void)connectionDidFinishLoading:(NSURLConnection *)connection
 {
    NSLog(@"服务器的数据加载完毕");
     _isEnd = YES;
     [self start];

   //处理服务器返回的所有数据
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:nil];
    //判断后，在界面提示登录信息
    NSString *error=dict[@"error"];
    if (error) {
     }else
     {
         NSString *success=dict[@"success"];
        }
        NSLog(@"%d---%@--",self.responseData.length,[NSThread currentThread]);
    }
    /*
    100  *请求错误（失败）的时候调用（请求超时\断网\没有网\，一般指客户端错误）
    101  */

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error

{
        _isEnd = YES;

    //     NSLog(@"请求错误");
        //隐藏HUD
    
}




#pragma mark Socket Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    
    
    //	DDLogInfo(@"localHost :%@ port:%hu", [sock localHost], [sock localPort]);
    
#if USE_SECURE_CONNECTION
    {
        // Connected to secure server (HTTPS)
        
#if ENABLE_BACKGROUNDING && !TARGET_IPHONE_SIMULATOR
        {
            // Backgrounding doesn't seem to be supported on the simulator yet
            
            [sock performBlock:^{
                if ([sock enableBackgroundingOnSocket])
                 else
             }];
        }
#endif
        
        // Configure SSL/TLS settings
        NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithCapacity:3];
        
        // If you simply want to ensure that the remote host's certificate is valid,
        // then you can use an empty dictionary.
        
        // If you know the name of the remote host, then you should specify the name here.
        //
        // NOTE:
        // You should understand the security implications if you do not specify the peer name.
        // Please see the documentation for the startTLS method in GCDAsyncSocket.h for a full discussion.
        
        [settings setObject:@"www.paypal.com"
                     forKey:(NSString *)kCFStreamSSLPeerName];
        
        // To connect to a test server, with a self-signed certificate, use settings similar to this:
        
        //	// Allow expired certificates
        //	[settings setObject:[NSNumber numberWithBool:YES]
        //				 forKey:(NSString *)kCFStreamSSLAllowsExpiredCertificates];
        //
        //	// Allow self-signed certificates
        //	[settings setObject:[NSNumber numberWithBool:YES]
        //				 forKey:(NSString *)kCFStreamSSLAllowsAnyRoot];
        //
        //	// In fact, don't even validate the certificate chain
        //	[settings setObject:[NSNumber numberWithBool:NO]
        //				 forKey:(NSString *)kCFStreamSSLValidatesCertificateChain];
        
        DDLogInfo(@"Starting TLS with settings:\n%@", settings);
        
        [sock startTLS:settings];
        
        // You can also pass nil to the startTLS method, which is the same as passing an empty dictionary.
        // Again, you should understand the security implications of doing so.
        // Please see the documentation for the startTLS method in GCDAsyncSocket.h for a full discussion.
        
    }
#else
    {
        // Connected to normal server (HTTP)
        
#if ENABLE_BACKGROUNDING && !TARGET_IPHONE_SIMULATOR
        {
            // Backgrounding doesn't seem to be supported on the simulator yet
            
            [sock performBlock:^{
                if ([sock enableBackgroundingOnSocket])
                    DDLogInfo(@"Enabled backgrounding on socket");
                else
                    DDLogWarn(@"Enabling backgrounding failed!");
            }];
        }
#endif
    }
#endif
    
    //模拟发送一条数据
    NSString *requestStr = [NSString stringWithFormat:@"telnet %@\r\n\r\n", @"112.74.18.72"];
    NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [sock writeData:requestData withTimeout:2000. tag:1];
    [sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:0];

}

- (void)socketDidSecure:(GCDAsyncSocket *)sock
{
  
    NSString *requestStr = [NSString stringWithFormat:@"telnet %@\r\n\r\n", @"112.74.18.72"];
    NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [sock writeData:requestData withTimeout:-1 tag:0];
    [sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{

}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *httpResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self connection:nil didReceiveData:data];
    [sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:0];
    
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
 
}
@end
@implementation CLJ_deviceObj

@end
@implementation CLJ_person_productObj

@end
@implementation CLJ_deveice_state_Obj

@end

@implementation CLJ_productObj
-(NSString *)checkrate
{
    if (_checkrate) {
        return _checkrate;
    }else{
        _checkrate  = [NSString stringWithFormat:@"%.3f",[_Checked integerValue]/[_Output floatValue]];
        return _checkrate;
    }
}
-(NSString *)goodrate
{
    if (_goodrate) {
        return _goodrate;
    }else{
        _goodrate  = [NSString stringWithFormat:@"%.3f",[_OK integerValue]/[_Output floatValue]];
        return _goodrate;
    }
}

@end
@implementation CLJ_presonObj

@end












@implementation GCYSSB_Object


@end
@implementation SZGCObjectRequest

-(void)loadRequest
{
    [super loadRequest];
    self.page = 1;
    //    self.PATH = [[RequestConfig sharedInstance] home];
    self.PATH = @"getMachineStatusListJson";
    //    self.HOST = AppHostAddress;
    
}
-(NSMutableDictionary *)requestParams{
    return nil;
    NSMutableDictionary *dict = [[super requestParams] mutableCopy];
    //    [dict setObject: self.category forKey:@"category"];
    //    [dict setObject: self.big_category forKey:@"big_category"];
    //    [dict setObject: self.biz_type forKey:@"biz_type"];
    
    return dict;
}
@end


@implementation SZGCObjectSceneModel
-(NSString*)getPath
{
    return [NSString stringWithFormat:@"%@/%@/%ld/%@",self.request.PATH,[UserObject sharedInstance].uid,self.request.page,@"10" ];
    
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
         
//         NSDictionary *dict = [self.request.output objectAtPath:@"response"];
         NSDictionary *dict =  self.request.output  ;
         NSMutableArray *array1 = [NSMutableArray array ];
         for (NSDictionary *INFO in (NSArray*)dict) {
             GCYSSB_Object *obj = [GCYSSB_Object objectWithKeyValues:INFO];
             
             if (![obj isKindOfClass:[GCYSSB_Object class]]) {
                 obj = [[GCYSSB_Object alloc] init];
                 obj.id = INFO[@"id"];
                 obj.model = INFO[@"model"];
                 obj.name = INFO[@"name"];
                 obj.serial = INFO[@"serial"];
                 obj.status = INFO[@"status"];
             
             
             }
         
             if(obj) [array1 addObject:obj];
             
         }
         NSArray* list = array1;
//         NSArray* list  =  [[SZGCObject objectArrayWithKeyValuesArray:dict  error:&error]mutableCopy ] ;
//         NSInteger totalPage = [dict[@"totalPage"] integerValue];
         NSInteger totalPage = 0;
        if(list.count <10)
            totalPage = self.request.page;
         else
             totalPage = self.request.page+1;

         
         [self getArray:list totalPage:totalPage];
         
     }];
    
}
/*
 {
 id = 123;
 model = "SUPERCUT2000+";
 name = "\U8d85\U7ea7\U5207\U5272";
 serial = 801011;
 status = 1;
 },
 {
 id = 235;
 model = ROBOTD306SD;
 name = "\U52a0\U5de5\U4e2d\U5fc3";
 serial = 801012;
 status = 1;
 },
 {
 id = 346;
 model = HERMES;
 name = "\U7ec4\U88c5\U6d41\U6c34\U7ebf";
 serial = 801013;
 status = 1;
 }HERMES801110
 */
@end