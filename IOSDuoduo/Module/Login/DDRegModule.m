//
//  DDRegModule.m
//  TeamTalk
//
//  Created by nary on 15/9/12.
//  Copyright (c) 2015年 Michael Hu. All rights reserved.
//

#import "DDRegModule.h"


@implementation DDRegModule

+ (instancetype)instance
{
    static DDRegModule *s;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s = [[DDRegModule alloc] init];
    });
    return s;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _httpServer = [[DDHttpServer alloc] init];
        _msgServer = [[DDMsgServer alloc] init];
        _tcpServer = [[DDTcpServer alloc] init];

    }
    return self;
}

-(void)registerWithUserinfo:(NSDictionary*)userinfo success:(void(^)(DDUserEntity*))success fail:(void(^)(NSString*))fail
{
    [self.httpServer getMsgIp:^(NSDictionary* dic) {
        NSInteger code = [dic[@"code"] integerValue];
        
        if (code == 0) {
            TheRuntime.msfs = dic[@"msfsPrior"];
            TheRuntime.discoverUrl = dic[@"discovery"];
            
            NSString* ip = dic[@"priorIP"];
            NSInteger port = [dic[@"port"] integerValue];
            [self.tcpServer loginTcpServerIP:ip port:port Success:^{
                
            } failure:^{
                fail(@"连接消息服务器失败");
            }];
        } else {
            fail(dic[@"msg"]);
        }
        
    } failure:^(NSString* err) {
        fail(@"获取消息服务器地址失败");
    }];
}

@end