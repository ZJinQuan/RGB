//
//  MySocket.h
//  空瀞
//
//  Created by femtoapp's macbook pro  on 15/9/1.
//  Copyright (c) 2015年 WL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

@interface MySocket : NSObject <AsyncSocketDelegate>
typedef NS_ENUM(NSInteger, SocketOffline) {
    SocketOfflineByServer,// 服务器掉线，默认为0
    SocketOfflineByUser,  // 用户主动cut
};
@property (nonatomic,assign) BOOL isConnect;
@property (nonatomic,strong) AsyncSocket *socket;
@property (nonatomic,copy) NSString *socketHost;
@property (nonatomic,assign) NSInteger socketPort;
@property (nonatomic,assign) NSInteger timeout;

@property (nonatomic,copy) void(^connectSuccess)();
@property (nonatomic,copy) void(^callBack)(id data);
@property (nonatomic,copy) void(^disConnect)(SocketOffline);

@property (nonatomic,strong) id userInfo;

-(void)sendMessage:(NSString *)message;
-(void)senddata:(NSData *)data;
-(void)socketConnectHost;
-(void)cutOffSocket;
@end
