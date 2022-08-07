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
    self.lineView.hidden = self.btnO2O.isHidden || self.btnB2C.isHidden;
    [self.btnO2O setTitle:o2oTitle forState:UIControlStateNormal];
    [self.btnB2C setTitle:b2cTitle forState:UIControlStateNormal];
    if(isEmptyString(o2oTitle)) {
        self.headerType = DJNewClassifyHeaderTypeB2C;
    } else {
        self.headerType = DJNewClassifyHeaderTypeO2O;
    }
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareVM {
    @weakify(self)
    [[[self.btnO2O rac_signalForControlEvents:UIControlEventTouchUpInside]
      throttle:0.2]
     subscribeNext:^(UIControl *x) {
        @strongify(self)
        self.headerType = DJNewClassifyHeaderTypeO2O;
    }];
    [[[self.btnB2C rac_signalForControlEvents:UIControlEventTouchUpInside]
      throttle:0.2]
     subscribeNext:^(UIControl *x) {
        @strongify(self)
        self.headerType = DJNewClassifyHeaderTypeB2C;
    }];
    [[RACObserve(self, headerType)
      distinctUntilChanged]
     subscribeNext:^(NSNumber *x) {
        @strongify(self)
        self.btnO2O.titleLabel.font = [UIFont boldSystemFontOfSize:kWPercentage(14.f)];
        self.btnB2C.titleLabel.font = [UIFont boldSystemFontOfSize:kWPercentage(14.f)];
        self.btnO2O.selected = NO;
        self.btnB2C.selected = NO;
        switch ([x integerValue]) {
            case DJNewClassifyHeaderTypeO2O: {
                self.btnO2O.selected = YES;
                self.btnO2O.titleLabel.font = [UIFont boldSystemFontOfSize:kWPercentage(16.f)];
            }
                break;
            case DJNewClassifyHeaderTypeB2C: {
                self.btnB2C.selected = YES;
                self.btnB2C.titleLabel.font = [UIFont boldSystemFontOfSize:kWPercentage(16.f)];
            }
                break;
        }
    }];
}
- (void)prepareUI {
    self.backgroundColor = [UIColor colorWithHex:0xF9F9F9];
    self.axis = UILayoutConstraintAxisHorizontal;
    self.spacing = 0.f;

    [self addArrangedSubview:self.btnO2O];
    [self addArrangedSubview:self.btnB2C];
    [self addSubview:self.btnSearch];
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
    [self.btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(kWPercentage(-15.f)));
        make.centerY.equalTo(@0.f);
        make.width.height.equalTo(@(kWPercentage(23.f)));
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
- (UIButton *)btnSearch {
    if(!_btnSearch){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];

        [btn setBackgroundImage:[iBLImage imageNamed:@"icon_classify_search"] forState:UIControlStateNormal];
        _btnSearch = btn;
    }
    return _btnSearch;
}

@end