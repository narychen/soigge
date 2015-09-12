//
//  RegViewController.m
//  TeamTalk
//
//  Created by nary on 15/9/12.
//  Copyright (c) 2015年 Michael Hu. All rights reserved.
//

#import "RegViewController.h"
#import "MBProgressHUD.h"
#import "DDUtil.h"
#import "DDAppDelegate.h"

static NSInteger _upCount = 0;

@interface RegViewController ()

@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.regOrLogin.selectedSegmentIndex = 1;

    self.userinfo = @{
       @"username": self.username,
       @"password": self.password,
       @"gender": self.gender,
       @"nickname": self.nickname,
       @"department": self.department,
       @"email": self.email,
       @"telphone": self.telphone,
   };
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    [self.regButton.layer setCornerRadius:5];
    for (NSString* key in self.userinfo) {
        UITextField* field = (UITextField*)[self.userinfo objectForKey:key];
        [field.layer setBorderColor:RGB(25, 139, 255).CGColor];
        [field.layer setBorderWidth:0.9];
        [field.layer setCornerRadius:5];
        field.delegate = self;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillShowKeyboard)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillHideKeyboard)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    // Do any additional setup after loading the view from its nib.
}

- (void)keyboardHide:(UITapGestureRecognizer*)tap {
    for (NSString* key in self.userinfo) {
        UITextField* field = (UITextField*)[self.userinfo objectForKey:key];
        [field resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)shouldMoveViewUp {
    if (self.nickname.isFirstResponder) {
        return YES;
    } else if (self.department.isFirstResponder) {
        return YES;
    } else if (self.email.isFirstResponder) {
        return YES;
    } else if (self.telphone.isFirstResponder) {
        return YES;
    } else {
        return NO;
    }
}

-(void)handleWillShowKeyboard
{
    if (![self shouldMoveViewUp]) {
        return;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    if ( _upCount == 0 ) {
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y - (IPHONE4?160:65));
        _upCount++;
    }
    
    [UIView commitAnimations];
}

-(void)handleWillHideKeyboard
{
    if (![self shouldMoveViewUp]) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4 animations:^{
            if (_upCount == 1) {
                self.view.center = CGPointMake(self.view.center.x, self.view.center.y + (IPHONE4?160:65));
                _upCount--;
            }
            
        }];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)regOrLoginAction:(id)sender {
    [TheAppDel.loginViewController.view setNeedsDisplay];
    [DDUtil viewRippleTransitionWithDuration:1.25 forView:TheAppDel.window trans:^{
        TheAppDel.window.rootViewController = TheAppDel.loginViewController;
    }];
    self.regOrLogin.selectedSegmentIndex = 1;
    [self.regOrLogin setNeedsDisplay];
}


- (IBAction)onRegister:(id)sender {
    [self.regButton setEnabled:NO];
    
    for (NSString* key in self.userinfo) {
        UITextField* v = (UITextField*)[self.userinfo objectForKey:key];
        if (v.text.length == 0) {
            [self.regButton setEnabled:YES];
            NSString *info = [NSString stringWithFormat:@"%@不能为空", v.placeholder];
            [DDUtil showMessage:info];
            return;
        }
    }

    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [HUD show:YES];
    HUD.dimBackground = YES;
    HUD.labelText = @"正在注册";
    [self.regButton setEnabled:YES];
}
@end
