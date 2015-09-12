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

@end