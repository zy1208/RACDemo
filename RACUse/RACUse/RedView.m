//
//  RedView.m
//  RACUse
//
//  Created by Palm on 2018/3/30.
//  Copyright © 2018年 palm. All rights reserved.
//

#import "RedView.h"
#import <Masonry/Masonry.h>

@interface RedView()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation RedView

+ (RedView *)redView {
    static RedView *redView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        redView = [[RedView alloc] init];
    });
    return redView;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    CGRect btnFrame = self.btn.frame;
    btnFrame.size = CGSizeMake(100, 43);
    self.btn.frame = btnFrame;
    self.btn.center = self.center;
    [self addSubview:self.btn];
    [self.btn sizeToFit];
    [self setNeedsLayout];

//    NSLog(@"按钮的坐标是 == %@", NSStringFromCGRect(self.btn.frame));
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(43);
        make.width.mas_equalTo(100);
        make.center.mas_equalTo(self);
    }];
}

- (void)btnDidClick:(UIButton *)btn {
    
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"我是一个按钮" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btn setBackgroundColor:[UIColor cyanColor]];
        [_btn sizeToFit];
    }
    return _btn;
}
@end
