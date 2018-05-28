//
//  LoginModel.m
//  RACLogin
//
//  Created by Palm on 2018/4/2.
//  Copyright © 2018年 palm. All rights reserved.
//

#import "LoginModel.h"
#import <MBProgressHUD_Add/UIView+MBPHUD.h>


@interface LoginModel()

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation LoginModel

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _enbleLogin = [RACSignal combineLatest:@[RACObserve(self.account, account), RACObserve(self.account, pwd)] reduce:^id (NSString *account, NSString *pwd){
        return @(account.length && pwd.length);
    }];
    
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"登录成功"];
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
    
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        if ([x isEqualToString:@"登录成功"]) {
            NSLog(@"登录成功");
        }
    }];
    
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x isEqualToNumber:@(YES)]) {
            [self.hud showHUDMessage:@"正在加载中..."];
        } else {
            [self.hud hideHUD];
        }
    }];
}


- (Account *)account {
    if (!_account) {
        _account = [[Account alloc] init];
    }
    return _account;
}

@end
