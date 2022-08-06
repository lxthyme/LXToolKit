//
//  DJClassifyHeaderView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/8/6.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJClassifyHeaderView.h"

#import <Masonry/Masonry.h>

@interface DJClassifyHeaderView() {
}
@property(nonatomic, strong)UIButton *btnO2O;
@property(nonatomic, strong)UIButton *btnB2C;
@property(nonatomic, strong)UIView *lineView;

@end

@implementation DJClassifyHeaderView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
        [self prepareVM];
    }
    return self;
}
#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(NSString *)o2oTitle b2cTitle:(NSString *)b2cTitle {
    self.btnO2O.hidden = isEmptyString(o2oTitle);
    self.btnB2C.hidden = isEmptyString(b2cTitle);
    [self.btnO2O setTitle:o2oTitle forState:UIControlStateNormal];
    [self.btnB2C setTitle:o2oTitle forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareVM {
    [[[self.btnO2O rac_signalForControlEvents:UIControlEventTouchUpInside]
      throttle:0.2]
     subscribeNext:^(id x) {
        NSLog(@"即时达: %@", x);
    }];
    [[[self.btnB2C rac_signalForControlEvents:UIControlEventTouchUpInside]
      throttle:0.2]
     subscribeNext:^(id x) {
        NSLog(@"超市精选: %@", x);
    }];
}
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];
    self.axis = UILayoutConstraintAxisHorizontal;
    self.spacing = 0.f;

    [self addArrangedSubview:self.btnO2O];
    [self addArrangedSubview:self.btnB2C];
    [self addSubview:self.lineView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.btnO2O, self.btnB2C,
                  self.lineView)
    [self.btnO2O mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.btnB2C);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0.f);
        make.width.equalTo(@(kWPercentage(0.5f)));
        make.height.equalTo(@(kWPercentage(14.f)));
    }];
}

#pragma mark Lazy Property
- (UIButton *)btnO2O {
    if(!_btnO2O){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:kWPercentage(16.f)];
        btn.selected = YES;

        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateSelected];
        _btnO2O = btn;
    }
    return _btnO2O;
}
- (UIButton *)btnB2C {
    if(!_btnB2C){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:kWPercentage(14.f)];

        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateSelected];
        _btnB2C = btn;
    }
    return _btnB2C;
}
- (UIView *)lineView {
    if(!_lineView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xDDDDDD];
        _lineView = v;
    }
    return _lineView;
}

@end
