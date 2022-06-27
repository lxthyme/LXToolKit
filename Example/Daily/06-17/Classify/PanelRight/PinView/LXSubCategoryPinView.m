//
//  LXSubCategoryPinView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXSubCategoryPinView.h"

/// filter 类型
typedef NS_ENUM(NSInteger, LXSubcategoryFilterType) {
    /// 即时达
    LXSubcategoryFilterTypeJiShiDa = 1,
    /// 价格(递增)
    LXSubcategoryFilterTypePriceAsc = 2,
    /// 价格(递减)
    LXSubcategoryFilterTypePriceDesc = 3,
    /// 销量
    LXSubcategoryFilterTypeSale = 4
};

@interface LXSubCategoryPinView() {
}
@property (nonatomic, strong)JXCategoryTitleBackgroundView *pinCategoryView;
@property(nonatomic, strong)YYLabel *labAll;
@property(nonatomic, strong)UIView *filterView;
/// 即时达 最快30分钟
@property(nonatomic, strong)UIButton *btnJiShiDa;
/// 价格
@property(nonatomic, strong)UIControl *priceWrapperView;
@property(nonatomic, strong)UIButton *btnPrice;
@property(nonatomic, strong)UIImageView *imgViewArrowUp;
@property(nonatomic, strong)UIImageView *imgViewArrowDown;
/// 销量
@property(nonatomic, strong)UIButton *btnSale;

/// filter 类型
@property(nonatomic, assign)LXSubcategoryFilterType filterType;

@end

@implementation LXSubCategoryPinView
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
- (void)dataFill:(LXSubCategoryModel *)subCateogryModel {
    // self.subCateogryModel = subCateogryModel;
    self.pinCategoryView.titles = [[subCateogryModel.sectionList.rac_sequence skip:1]
                                   map:^id _Nullable(LXSectionModel * _Nullable value) {
        return value.title;
    }].array;
    [self.pinCategoryView reloadDataWithoutListContainer];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.pinCategoryView];
    [self addSubview:self.labAll];

    self.filterType = LXSubcategoryFilterTypeJiShiDa;

    [self.filterView addSubview:self.btnJiShiDa];

    [self.priceWrapperView addSubview:self.btnPrice];
    [self.priceWrapperView addSubview:self.imgViewArrowUp];
    [self.priceWrapperView addSubview:self.imgViewArrowDown];
    [self.filterView addSubview:self.priceWrapperView];

    [self.filterView addSubview:self.btnSale];
    [self addSubview:self.filterView];

    [self masonry];
}
- (void)prepareVM {
    [[[self.btnJiShiDa rac_signalForControlEvents:UIControlEventTouchUpInside]
      throttle:0.3]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.filterType = LXSubcategoryFilterTypeJiShiDa;
    }];
    [[[self.priceWrapperView rac_signalForControlEvents:UIControlEventTouchUpInside]
      throttle:0.3]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        if(self.filterType == LXSubcategoryFilterTypePriceAsc) {
            self.filterType = LXSubcategoryFilterTypePriceDesc;
        } else {
            self.filterType = LXSubcategoryFilterTypePriceAsc;
        }
    }];
    [[[self.btnSale rac_signalForControlEvents:UIControlEventTouchUpInside]
      throttle:0.3]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.filterType = LXSubcategoryFilterTypeSale;
    }];
}

#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.pinCategoryView, self.filterView,
                  self.btnJiShiDa, self.priceWrapperView, self.btnSale,
                  self.btnPrice, self.imgViewArrowUp, self.imgViewArrowDown)
    [self.pinCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0.f);
        make.left.equalTo(@(kWPercentage(10.f)));
        make.height.equalTo(@(kWPercentage(44.f)));
    }];
    [self.labAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.pinCategoryView);
        make.left.equalTo(self.pinCategoryView.mas_right);
        make.right.equalTo(@(kWPercentage(-10.f)));
        make.width.equalTo(@44.f);
    }];
    [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pinCategoryView.mas_bottom);
        make.left.right.equalTo(self.pinCategoryView);
        make.bottom.equalTo(@0.f);
    }];
    [self.btnJiShiDa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0.f);
    }];
    [self.priceWrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnJiShiDa.mas_right).offset(kWPercentage(40.f));
        make.centerY.equalTo(self.btnJiShiDa);
    }];
    [self.btnPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(@0.f);
    }];
    [self.imgViewArrowUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnPrice.mas_right).offset(kWPercentage(3.5f));
        make.right.equalTo(@0.f);
        // make.centerY.equalTo(@0.f);
        make.bottom.equalTo(self.btnPrice.mas_centerY).offset(kWPercentage(-1.5f));
    }];
    [self.imgViewArrowDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgViewArrowUp);
        // make.centerY.equalTo(@0.f);
        make.top.equalTo(self.btnPrice.mas_centerY).offset(kWPercentage(1.5f));
    }];
    [self.btnSale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceWrapperView.mas_right).offset(kWPercentage(30.f));
        make.centerY.equalTo(self.btnJiShiDa);
    }];
}
#pragma mark getter/setter
- (void)setFilterType:(LXSubcategoryFilterType)filterType {
    if(_filterType == filterType) {
        return;
    }
    _filterType = filterType;

    self.btnJiShiDa.selected = NO;
    self.btnSale.selected = NO;
    self.btnPrice.selected = NO;
    self.imgViewArrowUp.image = [iBLImage imageNamed:@"icon_arrowUp"];
    self.imgViewArrowDown.image = [iBLImage imageNamed:@"icon_arrowDown"];
    switch (_filterType) {
        case LXSubcategoryFilterTypeJiShiDa: {
            self.btnJiShiDa.selected = YES;

        }
            break;
        case LXSubcategoryFilterTypePriceAsc: {
            self.btnPrice.selected = YES;
            self.imgViewArrowUp.image = [iBLImage imageNamed:@"icon_arrowUp_select"];
        }
            break;
        case LXSubcategoryFilterTypePriceDesc: {
            self.btnPrice.selected = YES;
            self.imgViewArrowDown.image = [iBLImage imageNamed:@"icon_arrowDown_select"];
        }
            break;
        case LXSubcategoryFilterTypeSale: {
            self.btnSale.selected = YES;
        }
            break;
    }
}
#pragma mark Lazy Property
- (JXCategoryTitleBackgroundView *)pinCategoryView {
    if(!_pinCategoryView){
        JXCategoryTitleBackgroundView *v = [[JXCategoryTitleBackgroundView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        v.normalBackgroundColor = [UIColor colorWithHex:0xF6F6F6];
        v.selectedBackgroundColor = [UIColor colorWithHex:0xFF774F alpha:0.1];
        v.titleColor = [UIColor colorWithHex:0x666666];
        v.titleSelectedColor = [UIColor colorWithHex:0xFF774F];
        v.borderLineWidth = 0.f;
        v.contentEdgeInsetLeft = 0.f;
        v.contentEdgeInsetRight = 0.f;
        v.backgroundCornerRadius = kWPercentage(4.f);

        // JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        // lineView.verticalMargin = 15;
        // v.indicators = @[lineView];

        _pinCategoryView = v;
    }
    return _pinCategoryView;
}
- (YYLabel *)labAll {
    if(!_labAll){
        YYLabel *lab = [[YYLabel alloc]init];
        lab.text = @"全部";
        lab.textColor = [UIColor blackColor];
        lab.verticalForm = YES;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        lab.exclusionPaths = @[[UIBezierPath bezierPathWithRect:CGRectZero]];
        WEAKSELF(self)
        lab.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            !weakSelf.toggleShowAll ?: weakSelf.toggleShowAll();
        };

        _labAll = lab;
    }
    return _labAll;
}
- (UIView *)filterView {
    if(!_filterView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        _filterView = v;
    }
    return _filterView;
}
- (UIButton *)btnJiShiDa {
    if(!_btnJiShiDa){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithHex:0xF6F6F6];

        btn.titleLabel.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
        [btn setTitle:@"即时达 最快30分钟" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:0xFF774F] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor colorWithHex:0xFF774F] forState:UIControlStateSelected];
        btn.contentEdgeInsets = UIEdgeInsetsMake(kWPercentage(3.5f), kWPercentage(10.f), kWPercentage(4.f), kWPercentage(10.f));
        btn.layer.cornerRadius = kWPercentage(4.f);
        btn.clipsToBounds = YES;

        _btnJiShiDa = btn;
    }
    return _btnJiShiDa;
}
- (UIControl *)priceWrapperView {
    if(!_priceWrapperView){
        UIControl *v = [[UIControl alloc]init];
        _priceWrapperView = v;
    }
    return _priceWrapperView;
}
- (UIButton *)btnPrice {
    if(!_btnPrice){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

        btn.titleLabel.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
        [btn setTitle:@"价格" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:0xFF774F] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor colorWithHex:0xFF774F] forState:UIControlStateSelected];
        btn.userInteractionEnabled = NO;

        _btnPrice = btn;
    }
    return _btnPrice;
}
- (UIImageView *)imgViewArrowUp {
    if(!_imgViewArrowUp){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [iBLImage imageNamed:@"icon_arrowUp"];
        _imgViewArrowUp = iv;
    }
    return _imgViewArrowUp;
}
- (UIImageView *)imgViewArrowDown {
    if(!_imgViewArrowDown){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [iBLImage imageNamed:@"icon_arrowDown"];
        _imgViewArrowDown = iv;
    }
    return _imgViewArrowDown;
}


- (UIButton *)btnSale {
    if(!_btnSale){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

        btn.titleLabel.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
        [btn setTitle:@"销量" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:0xFF774F] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor colorWithHex:0xFF774F] forState:UIControlStateSelected];

        _btnSale = btn;
    }
    return _btnSale;
}
@end
