//
//  DDUtil.m
//  TeamTalk
//
//  Created by nary on 15/9/12.
//  Copyright (c) 2015年 Michael Hu. All rights reserved.
//

#import "DDUtil.h"

@implementation DDUtil
{
    int _privateNum;
}

+ (void)viewFlipTransitionWithDuration:(NSTimeInterval)duration forView:(UIView*)view trans:(void(^)(void))trans
{
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:view cache:YES];
    trans();
    [UIView commitAnimations];
}

+ (void)viewRippleTransitionWithDuration:(NSTimeInterval)duration forView:(UIView*)view trans:(void(^)(void))trans
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = duration;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    trans();
    [[view layer] addAnimation:animation forKey:@"animation"];
}

+ (void)showMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((SCREEN_WIDTH - LabelSize.width - 20)/2, SCREEN_HEIGHT - 100, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:1.5 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

@end