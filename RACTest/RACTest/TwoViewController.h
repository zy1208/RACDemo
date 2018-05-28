//
//  TwoViewController.h
//  RACTest
//
//  Created by Palm on 2018/3/29.
//  Copyright © 2018年 palm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface TwoViewController : UIViewController

@property (nonatomic, strong) RACSubject *delegateSignal;

@end
