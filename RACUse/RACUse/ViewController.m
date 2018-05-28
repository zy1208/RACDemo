//
//  ViewController.m
//  RACUse
//
//  Created by Palm on 2018/3/30.
//  Copyright © 2018年 palm. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "RedView.h"

@interface ViewController ()

@property (nonatomic, strong) RedView *redView;

@property (nonatomic, strong) UIButton *btnCoco;

@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@property (weak, nonatomic) IBOutlet UILabel *labelView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加RedView
    [self addRedView];
    
//    [self ThisIsDelegate];
    
//    [self ThisIsKVO];
    
//    [self addButton];
//    [self ThisIsBtnAction];
    
//    [self ThisIsNoti];
//
//    [self ThisIsTextChange];
    
//    [self moreRequest];
    
//    RAC(self.labelView, text) = self.textFiled.rac_textSignal;
    
    [self ThisIsMap];

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    
}

- (void)addRedView {
    self.redView.frame = CGRectMake(100, 200, 200, 200);
    self.redView.center = self.view.center;
    [self.view addSubview:self.redView];
}

- (void)addButton {
    self.btnCoco = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnCoco setTitle:@"哇哈哈" forState:UIControlStateNormal];
    [self.btnCoco setBackgroundColor:[UIColor orangeColor]];
    self.btnCoco.frame = CGRectMake(70, 50, 200, 100);
    [self.view addSubview:self.btnCoco];
}

- (void)ThisIsMap {
//    RACSubject *singnalOne = [[RACSubject alloc] init];
//    RACSubject *signalTwo = [[RACSubject alloc] init];
//    [[singnalOne flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
//        return value;
//    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"我我哦我 == %@", x);
//    }];
//    [singnalOne sendNext:signalTwo];
//    [singnalOne sendNext:@"你啊哦哦嗷嗷"];
}


- (void)ThisIsDelegate {
    [[self.redView rac_signalForSelector:@selector(btnDidClick:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"听说你可以监测到按钮的点击事件 ==== 6666");
    }];
}

- (void)ThisIsKVO {
    [[self.redView rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        NSLog(@"赶脚这个还蛮有意思的 === ni gai bian zhi l m %@",  x);
    }];
}

- (void)ThisIsBtnAction {
    [[self.btnCoco rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"听说你可以监听按钮的点击，阿拉啦啦啦");
    }];
}

- (void)ThisIsNoti {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"听说键盘出来了。。。呜呜呜呜~~~~");
    }];
}

- (void)ThisIsTextChange {
    [self.textFiled.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"你可以监听输入框值的改变 === %@", x);
    }];
}

- (void)moreRequest {
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"啊好好干哈哈"];
        return nil;
    }];
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"麻雀 家具啊急急急"];
        return nil;
    }];
    [self rac_liftSelector:@selector(receiveData1:data2:) withSignalsFromArray:@[signal1, signal2]];
}

- (void)receiveData1:(id)data1 data2:(id)data2 {
    NSLog(@"你传过啦的什么数据啊 data1 %@=== data2 %@", data1, data2);
}


- (RedView *)redView {
    if (!_redView) {
        _redView = [RedView redView];
    }
    return _redView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
