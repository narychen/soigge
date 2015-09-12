//
//  RegViewController.h
//  TeamTalk
//
//  Created by nary on 15/9/12.
//  Copyright (c) 2015年 Michael Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *regOrLogin;
- (IBAction)regOrLoginAction:(id)sender;

@property (strong) NSDictionary* userinfo;

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *nickname;
@property (weak, nonatomic) IBOutlet UITextField *department;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *telphone;

- (IBAction)onRegister:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *regButton;

@end
