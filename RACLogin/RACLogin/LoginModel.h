//
//  LoginModel.h
//  RACLogin
//
//  Created by Palm on 2018/4/2.
//  Copyright © 2018年 palm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "Account.h"

@interface LoginModel : NSObject

@property (nonatomic, strong) RACSignal *enbleLogin;

@property (nonatomic, strong) RACCommand *loginCommand;

@property (nonatomic, strong) Account *account;

@end
