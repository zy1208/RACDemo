//
//  ViewController.m
//  RACUpUse
//
//  Created by Palm on 2018/4/2.
//  Copyright © 2018年 palm. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //聚合
//    [self testCombine];
    
    //组合
//    [self testMakeUp];
    
    //压缩
//    [self testZip];
    
    //合并
//    [self testMerge];
    
    //拼接
//    [self concat];
    
#pragma mark ================== 过滤 =======================
    //跳过
//    [self testSkip];
    
//    [self take];
    
//    [self distinctUntilChanged];
    
//    [self ignore];
    
//    [self testFilter];
  
    [self lastSignal];
}

#pragma mark ================== 过滤 =======================
- (void)lastSignal {
    RACSubject *signalA  = [RACSubject subject];
    RACSubject *signalB  = [RACSubject subject];
    [signalA sendNext:signalB];
    [signalA sendNext:@"爱就爱加加加"];

    [signalA.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"wpwpwwowowowo === %@", x);
    }];
}

- (void)testFilter {
    [_textFiled.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        NSLog(@"喔喔喔哦我那 === %@", value);
        return value.length > 3;
    }];
}

- (void)ignore {
    [[_textFiled.rac_textSignal ignore:@"g"] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"are you  === %@", x);
    }];
}

- (void)testSkip {
    [[_textFiled.rac_textSignal skip:1] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"头疼，呜呜呜呜 === %@", x);
    }];
}

- (void)take {
    [_textFiled.rac_textSignal takeUntil:self.rac_willDeallocSignal];
    
    RACSubject *sinal = [RACSubject subject];
    [[sinal take:1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"你有什么用啊 === %@", x);
    }];
    [sinal sendNext:@"aoaoo"];
    [sinal sendNext:@"pwpwpwp"];
}

- (void)distinctUntilChanged {
    [[_textFiled.rac_textSignal distinctUntilChanged] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"你是不是被改变了啊 == %@", x);
    }];
}


#pragma mark ================== 组合 =======================

- (void)testCombine {
    RACSignal *singalA  = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"呜呜呜呜呜！~"];
        return nil;
    }];
    RACSignal *signalB  = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"头疼，不开心"];
        return nil;
    }];
    RACSignal *combine  = [RACSignal combineLatest:@[singalA, signalB] reduce:^id (NSString *str1,  NSString *str2){
        return [NSString stringWithFormat:@"%@%@", str1, str2];
    }];
    [combine subscribeNext:^(id  _Nullable x) {
        NSLog(@"有点热啊 ~~~ %@", x);
    }];
}

- (void)testMakeUp {
    RACSignal *singalA  = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"呜呜呜呜呜！~"];
        return nil;
    }];
    RACSignal *signalB  = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"头疼，不开心"];
        return nil;
    }];
    RACSignal *sos  = [singalA combineLatestWith:signalB];
    
    [sos subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *str1, NSString *str2) = x;
        NSLog(@"路漫漫， 其修远兮，  我我哦我欧文 -%@ %@",str1, str2);
    }];
}

- (void)testZip {
    RACSignal *singalA  = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"呜呜呜呜呜！~"];
        return nil;
    }];
    RACSignal *signalB  = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"头疼，不开心"];
        return nil;
    }];
    RACSignal *signalC = [singalA zipWith:signalB];
    [signalC subscribeNext:^(id _Nullable x) {
        RACTupleUnpack(NSString *hh, NSString *kk) = x;
        NSLog(@"woowowoowowoo %@ %@", hh, kk);
    }];
}

- (void)testMerge {
    RACSignal *singalA  = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"呜呜呜呜呜！~"];
        return nil;
    }];
    RACSignal *signalB  = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"头疼，不开心"];
        return nil;
    }];
    RACSignal *merge = [singalA merge:signalB];
    [merge subscribeNext:^(id  _Nullable x) {
        NSLog(@"巴拉啦啦啦啦啦 -- %@", x);
    }];
}

- (void)concat {
    RACSignal *singalA  = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"呜呜呜呜呜！~"];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *signalB  = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"头疼，不开心"];
         [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *concat  = [singalA concat:signalB];
    [concat subscribeNext:^(id  _Nullable x) {
        NSLog(@"听说这是拼接 == %@", x);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
