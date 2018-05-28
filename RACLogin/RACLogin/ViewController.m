//
//  ViewController.m
//  RACLogin
//
//  Created by Palm on 2018/4/2.
//  Copyright © 2018年 palm. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "LoginModel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextFiled;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextFiled;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong) LoginModel *loginModel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    RAC(self.loginModel.account, account) = self.accountTextFiled.rac_textSignal;
    RAC(self.loginModel.account, pwd) = self.pwdTextFiled.rac_textSignal;
    RAC(self.loginBtn, enabled) = self.loginModel.enbleLogin;
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.loginModel.loginCommand execute:nil];
    }];
}

- (LoginModel *)loginModel {
    if (!_loginModel) {
        _loginModel = [[LoginModel alloc] init];
    }
    return _loginModel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
