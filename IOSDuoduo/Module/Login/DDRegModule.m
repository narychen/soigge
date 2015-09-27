//
//  DDRegModule.m
//  TeamTalk
//
//  Created by nary on 15/9/12.
//  Copyright (c) 2015年 Michael Hu. All rights reserved.
//

#import "DDRegModule.h"
#import "RegisterAPI.h"
#import "DDClientState.h"
#import "DDDatabaseUtil.h"
#import "LoginModule.h"

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
                NSDictionary* dic = @{
                    @"name": ((UITextField*)userinfo[@"username"]).text,
                    @"password": ((UITextField*)userinfo[@"password"]).text,
                    @"gender": ((UITextField*)userinfo[@"gender"]).text,
                    @"department": ((UITextField*)userinfo[@"department"]).text,
                    @"email": ((UITextField*)userinfo[@"email"]).text,
                    @"avatar": @"avatar/avatar.png",
                    @"domain": ((UITextField*)userinfo[@"username"]).text,
                    @"nickname": ((UITextField*)userinfo[@"nickname"]).text,
                    @"realname": ((UITextField*)userinfo[@"username"]).text,
                    @"tel": ((UITextField*)userinfo[@"telphone"]).text
                };
                
                RegisterAPI* api = [[RegisterAPI alloc] init];
                [api requestWithObject:dic Completion:^(id res, NSError* err) {
                    if (!err) {
                        [[NSUserDefaults standardUserDefaults] setObject:dic[@"password"] forKey:@"password"];
                        [[NSUserDefaults standardUserDefaults] setObject:dic[@"name"] forKey:@"username"];
                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"autologin"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        [DDClientState shareInstance].userState = DDUserOnline;
                        [[DDDatabaseUtil instance] openCurrentUserDB];
                        
                        [[LoginModule instance] p_loadAllUsersCompletion:^{}];
                        [[LoginModule instance] setLastLoginPassword:dic[@"password"]];
                        [[LoginModule instance] setLastLoginUserName:dic[@"username"]];
                        [[LoginModule instance] setRelogining:YES];
                        DDUserEntity *user = res[@"user"];
                        success(user);
                    } else {
                        fail(err.domain);
                    }
                }];
                
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