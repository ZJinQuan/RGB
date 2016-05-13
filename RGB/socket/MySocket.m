//
//  MySocket.m
//  空瀞
//
//  Created by femtoapp's macbook pro  on 15/9/1.
//  Copyright (c) 2015年 WL. All rights reserved.
//

#import "MySocket.h"
#import "AppDelegate.h"

@implementation MySocket
- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.socketHost = @"120.24.165.21";//192.168.1.200
//        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"ipAddress"];
//        if (str.length) {
//            self.socketHost = str;
//        }
//        else
       
            self.socketHost = @"192.168.4.1";
//        self.socketHost = @"192.168.1.122";
    
        
        self.socketPort = 8080;
//        self.socketPort = 6666;
        self.timeout = 2;
        [self createSocket];
        }
    return self;
}

-(void)senddata:(NSData *)data{
    [self.socket writeData:data withTimeout:_timeout tag:0];
}

-(void)sendMessage:(NSString *)message
{
//    NSLog(@"%p send >>> %@",self.socket,message);
    if (_isConnect) {
        NSData *data = [message dataUsingEncoding:NSASCIIStringEncoding];
        [self.socket writeData:data withTimeout:_timeout tag:0];
    }
}

-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
//    NSLog(@"mysocket send ok");
     [self.socket readDataWithTimeout:_timeout tag:0];
}
-(NSTimeInterval)onSocket:(AsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length
{
    if (self.callBack) {
        self.callBack(@"noData");
    }
    return -1;
}
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"%p >>> read %@",self.socket,dataString);
    if (self.callBack) {
        self.callBack(dataString);
    }
//    [self.socket readDataWithTimeout:5 tag:0];
}

-(void)createSocket{
    
    self.socket = [[AsyncSocket alloc] initWithDelegate:self];
    
}

-(void)socketConnectHost
{
    NSError *error = nil;
    self.socket.userData = SocketOfflineByServer;
    [self.socket disconnect];
    if (self.socket.delegate == nil) {
        self.socket.delegate = self;
    }
    [self.socket connectToHost:self.socketHost onPort:self.socketPort withTimeout:5 error:&error];
}

-(void)cutOffSocket
{
    self.socket.userData = SocketOfflineByUser;
    [self.socket disconnect];
    self.socket.delegate = nil;
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"==== >>> %@",sock);
    _isConnect = YES;
    if (self.connectSuccess) {
        self.connectSuccess();
    }
}
-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@">>> disCon %p",sock);
    _isConnect = NO;
    if (self.disConnect) {
        self.disConnect(self.socket.userData);
    }
    if (self.socket.userData != SocketOfflineByUser) {
//        usleep(100000);
        [self socketConnectHost];
    }
}
- (void)dealloc
{
    self.socket.delegate = nil;
    self.socket = nil;
}
@end
