//
//  RegisterAPI.m
//  TeamTalk
//
//  Created by nary on 15/9/13.
//  Copyright (c) 2015年 Michael Hu. All rights reserved.
//


#import "RegisterAPI.h"
#import "IMLogin.pb.h"
#import "NSString+Additions.h"

@implementation RegisterAPI

/**
 *  请求超时时间
 *
 *  @return 超时时间
 */
- (int)requestTimeOutTimeInterval
{
    return 15;
}

/**
 *  请求的serviceID
 *
 *  @return 对应的serviceID
 */
- (int)requestServiceID
{
    return ServiceIDSidLogin;
}

/**
 *  请求返回的serviceID
 *
 *  @return 对应的serviceID
 */
- (int)responseServiceID
{
    return ServiceIDSidLogin;
}

/**
 *  请求的commendID
 *
 *  @return 对应的commendID
 */
- (int)requestCommendID
{
    return LoginCmdIDCidLoginReqUserreg;
}

/**
 *  请求返回的commendID
 *
 *  @return 对应的commendID
 */
- (int)responseCommendID
{
    return LoginCmdIDCidLoginResUserreg;
}

/**
 *  解析数据的block
 *
 *  @return 解析数据的block
 */
- (Analysis)analysisReturnData
{
    Analysis analysis = (id)^(NSData* data)
    {
        IMRegisterRes *res = [IMRegisterRes parseFromData:data];
        NSInteger serverTime = res.serverTime;
        NSInteger loginResult = res.resultCode;
        NSString *resultString = res.resultString;
        
        NSDictionary* result = nil;
        
        if (loginResult !=0) {
            return result;
        } else {
            DDUserEntity *user = [[DDUserEntity alloc] initWithPB:res.userInfo];
            result = @{
                @"serverTime":@(serverTime),
                @"result":resultString,
                @"user":user,
            };
            return result;
        }
    };
    
    return analysis;
}

/**
 *  打包数据的block
 *
 *  @return 打包数据的block
 */
- (Package)packageRequestObject
{
    Package package = (id)^(id object,UInt32 seqNo)
    {
        NSDictionary* info = [[NSBundle mainBundle] infoDictionary];
        NSString *clientVersion = [NSString stringWithFormat:@"MAC/%@-%@", info[@"CFBundleShortVersionString"],info[@"CFBundleVersion"] ];
        
        NSDictionary* _ = (NSDictionary*)object;
        
        DDDataOutputStream *dataout = [[DDDataOutputStream alloc] init];
        [dataout writeInt:0];
        [dataout writeTcpProtocolHeader:ServiceIDSidLogin
                                    cId:LoginCmdIDCidLoginReqUserreg
                                  seqNo:seqNo];
        
        IMRegisterReqBuilder *reg = [IMRegisterReq builder];
        UserInfoBuilder *userInfo = [UserInfo builder];
        
        [reg setUserName:_[@"name"]];
        [reg setPassword:[_[@"password"] MD5]];

        [reg setClientType:ClientTypeClientTypeIos];
        [reg setClientVersion:clientVersion];
        [reg setOnlineStatus:UserStatTypeUserStatusOnline];
        
        [userInfo setDepartmentId:(UInt32)[_[@"department"] intValue]];
        [userInfo setEmail:(NSString*)_[@"email"]];
        [userInfo setAvatarUrl:(NSString*)_[@"avatar"]];
        [userInfo setUserDomain:(NSString*)_[@"domain"]];
        [userInfo setUserGender:(UInt32)[_[@"gender"] intValue]];
        [userInfo setUserNickName:(NSString*)_[@"nickname"]];
        [userInfo setUserRealName:(NSString*)_[@"realname"]];
        [userInfo setUserTel:(NSString*)_[@"tel"]];
        
        [reg setUserInfo:[userInfo build]];
        
        [dataout directWriteBytes:[reg build].data];
        [dataout writeDataCount];
        return [dataout toByteArray];
    };
    return package;
}

@end