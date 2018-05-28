//
//  ViewController.m
//  RACTest
//
//  Created by Palm on 2018/3/27.
//  Copyright © 2018年 palm. All rights reserved.
//

#import "ViewController.h"
#import "TwoViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()

@property (nonatomic, strong) RACCommand *command;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //测试RAC
//    [self testRAC];
    
//    [self testRACSubject];
    
//    [self testRACReplaySubject];
    
    //创建通知按钮
//    [self createNotiBtn];
    
    //遍历数组
//    [self testSequence];
    
//    [self testRACMulticastConnection];
    
//    [self testRACCommand];
}

#pragma mark -- testRACCommand
- (void)testRACCommand {
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"ni dao di you mei you shu ju"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    _command = command;
    
    [self.command execute:@"apppp"];
    
//    [_command.executionSignals subscribeNext:^(id  _Nullable x) {
//        [x subscribeNext:^(id  _Nullable x) {
//            NSLog(@"得到的数据是 == %@", x);
//        }];
//    }];
    
    [self.command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"这只是一个测试，听说你很难哦哦哦 === %@", x);
    }];
}

#pragma mark -- testRACMulticastConnection
- (void)testRACMulticastConnection {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"听说这是发送信号"];
        return nil;
    }];
    RACMulticastConnection *connect = [signal publish];
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"wo shi 1 hao");
    }];
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"wo shi 2 hao");
    }];
    //建立连接
    [connect connect];
}

#pragma mark -- RACSignal
- (void)testRAC {
    //1、创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //2、发送信号，实际是执行  订阅信号
        [subscriber sendNext:@"wo jiu shi lai xie zhe wan de"];
        
        return [RACDisposable disposableWithBlock:^{
            //信号发送完或者是发送错误
            NSLog(@"这个地方信号被销毁了哦。");
        }];
    }];
    //3、订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"喔喔喔喔喔 === %@",x);
    }];
    
}

#pragma mark -- RACSubject
- (void)testRACSubject {
    //1、创建信号
    RACSubject *subject = [RACSubject subject];
    //2、订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号发出新值，，，，%@",x);
    }];
    [subject sendNext:@"丽丽啊"];
    [subject sendNext:@"我来到你的城市。"];
}

#pragma mark -- RACReplaySubject
- (void)testRACReplaySubject {
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    [replaySubject sendNext:@"啊哈哈哈"];
    [replaySubject sendNext:@"aaaaaa"];
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"菠萝菠萝蜜 === %@",x);
    }];
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"月光宝盒 === %@",x);
    }];
}

#pragma mark -- 遍历数组
- (void)testSequence {
    NSArray *arr = @[@"大脸猫",@"爱吃鱼",@"miao~~~",@"啦啦啦"];
    [arr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"我就是测试一下遍历数组 === %@", x);
    }];
    
    NSDictionary *dic = @{@"name":@"娃哈哈",@"productName":@"😪"};
    [dic.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"听说可以遍历字典 ==  %@ : %@", key, value);
    }];
}

#pragma mark -- 创建通知按钮
- (void)createNotiBtn {
    UIButton *notiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    notiBtn.frame = CGRectMake(100, 200, 100, 100);
    notiBtn.backgroundColor = [UIColor orangeColor];
    [notiBtn addTarget:self action:@selector(notiBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:notiBtn];
}

- (void)notiBtnDidClick:(UIButton *)btn {
    TwoViewController *twoVC = [[TwoViewController alloc] init];
    twoVC.delegateSignal = [RACSubject subject];
    [twoVC.delegateSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"点击了按钮同志。。。点击了按钮同志。。。");
    }];
    [self presentViewController:twoVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
