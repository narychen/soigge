//
//  DDRegModule.h
//  TeamTalk
//
//  Created by nary on 15/9/12.
//  Copyright (c) 2015年 Michael Hu. All rights reserved.
//

#ifndef TeamTalk_DDRegModule_h
#define TeamTalk_DDRegModule_h

#import <Foundation/Foundation.h>
#import "DDHttpServer.h"
#import "DDMsgServer.h"
#import "DDTcpServer.h"

@interface DDRegModule : NSObject

@property(atomic, strong) DDHttpServer* httpServer;
@property(atomic, strong) DDMsgServer* msgServer;
@property(atomic, strong) DDTcpServer* tcpServer;


+(instancetype)instance;

-(void)registerWithUserinfo:(NSDictionary*)userinfo success:(void(^)(DDUserEntity*))success fail:(void(^)(NSString*))fail;

@end

#endif
