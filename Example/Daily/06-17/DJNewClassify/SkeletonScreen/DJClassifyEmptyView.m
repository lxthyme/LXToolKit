//
//  DJClassifyEmptyView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/25.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJClassifyEmptyView.h"

#import <Masonry/Masonry.h>

@interface DJClassifyEmptyView() {
}
@property(nonatomic, strong)UIView *wrapperView;
@property(nonatomic, strong)UIImageView *imgViewLogo;
@property(nonatomic, strong)UILabel *labTitle;
@property(nonatomic, strong)UIButton *btnLeft;
@property(nonatomic, strong)UIButton *btnRight;

@end

@implementation DJClassifyEmptyView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}
#pragma mark -
#pragma mark - 🌎LoadData
/// 无数据样式
- (void)dataFillEmptyStyle {
    self.imgViewLogo.image = [iBLImage imageNamed:@"icon_classify_empty"];
    self.labTitle.text = @"当前分类商品暂无";
    self.labTitle.font = [UIFont systemFontOfSize:kWPercentage(14.f)];
    self.labTitle.textColor = [UIColor colorWithHex:0x333333 alpha:0.4];
}
/// 无网络样式
- (void)dataFillOfflineStyle {
    self.imgViewLogo.image = [iBLImage imageNamed:@"icon_classify_empty"];
    self.labTitle.text = @"网兜没了，快去找回来";
    self.labTitle.font = [UIFont systemFontOfSize:kWPercentage(14.f)];
    self.labTitle.textColor = [UIColor colorWithHex:0x333333 alpha:0.4];
    self.btnLeft.hidden = NO;
    self.btnRight.hidden = NO;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self.wrapperView addSubview:self.imgViewLogo];
    [self.wrapperView addSubview:self.labTitle];
    [self addSubview:self.wrapperView];
    [self addSubview:self.btnLeft];
    [self addSubview:self.btnRight];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@(kWPercentage(40.f)));
        make.right.lessThanOrEqualTo(@(kWPercentage(40.f)));
        make.center.equalTo(@0.f);
    }];
    [self.imgViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0.f);
        make.left.greaterThanOrEqualTo(@0.f);
        make.right.lessThanOrEqualTo(@0.f);
        make.centerX.equalTo(@0.f);
    }];
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgViewLogo.mas_bottom).offset(kWPercentage(6.f));
        make.left.greaterThanOrEqualTo(@0.f);
        make.right.lessThanOrEqualTo(@0.f);
        make.bottom.centerX.equalTo(@0.f);
    }];
    [self.btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wrapperView.mas_bottom).offset(kWPercentage(27.f));
        make.left.equalTo(@(kWPercentage(59.f)));
        make.height.equalTo(@(kWPercentage(30.f)));
    }];
    [self.btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnLeft);
        make.left.equalTo(self.btnLeft.mas_right).offset(kWPercentage(10.f));
        make.right.equalTo(@(kWPercentage(-58.f)));
        make.width.height.equalTo(self.btnLeft);
    }];
}

#pragma mark Lazy Property
- (UIView *)wrapperView {
    if(!_wrapperView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        _wrapperView = v;
    }
    return _wrapperView;
}
- (UIImageView *)imgViewLogo {
    if(!_imgViewLogo){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewLogo = iv;
    }
    return _imgViewLogo;
}
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:kWPercentage(14.f)];
        label.textColor = [UIColor colorWithHex:0x333333];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
- (UIButton *)btnLeft {
    if(!_btnLeft){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = 1.f;
        btn.layer.borderWidth = 1.f;
        btn.layer.borderColor = [UIColor colorWithHex:0xCCCCCC].CGColor;
        btn.titleLabel.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
        btn.hidden = YES;

        [btn setTitle:@"刷新一下试试" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];

        _btnLeft = btn;
    }
    return _btnLeft;
}
- (UIButton *)btnRight {
    if(!_btnRight){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = 1.f;
        btn.layer.borderWidth = 1.f;
        btn.layer.borderColor = [UIColor colorWithHex:0xFFB1B1].CGColor;
        btn.titleLabel.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10.f, 0, 0);
        btn.hidden = YES;

        [btn setTitle:@"去设置网络" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:0xFF6F6F] forState:UIControlStateNormal];
        [btn setImage:[iBLImage imageNamed:@"icon_classify_refresh"] forState:UIControlStateNormal];

        _btnRight = btn;
    }
    return _btnRight;
}

@end
