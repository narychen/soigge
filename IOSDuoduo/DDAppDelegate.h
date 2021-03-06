//
//  DDAppDelegate.h
//  IOSDuoduo
//
//  Created by 独嘉 on 14-5-23.
//  Copyright (c) 2014年 dujia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "std.h"
#import "MainViewControll.h"
#import "LoginViewController.h"
#import "RegViewController.h"

@interface DDAppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong) UINavigationController *nv;
@property(strong) MainViewControll* mainViewControll;
@property(strong) LoginViewController* loginViewController;
@property(strong) RegViewController* regViewController;

@end
#define TheApp           ([UIApplication sharedApplication])
#define TheAppDel        ((DDAppDelegate*)TheApp.delegate)