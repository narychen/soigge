//
//  DDUtil.h
//  TeamTalk
//
//  Created by nary on 15/9/12.
//  Copyright (c) 2015年 Michael Hu. All rights reserved.
//

#ifndef TeamTalk_DDUtil_h
#define TeamTalk_DDUtil_h

#import <Foundation/Foundation.h>

@interface DDUtil : NSObject

+ (void)viewFlipTransitionWithDuration:(NSTimeInterval)duration style:(NSString*)style forView:(UIView*)view trans:(void(^)(void))trans;
+ (void)viewRippleTransitionWithDuration:(NSTimeInterval)duration forView:(UIView*)view trans:(void(^)(void))trans;

+ (void)showMessage:(NSString *)message;


@end

#endif
