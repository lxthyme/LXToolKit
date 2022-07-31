//
//  LXSubCategoryPinView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXSubCategoryPinView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

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

@interface LXSubCategoryPinView()<SDCycleScrollViewDelegate> {
}
@property(nonatomic, strong)UIStackView *wrapperStackView;
@property(nonatomic, strong)SDCycleScrollView *bannerView;
@property (nonatomic, strong)LX3rdCategoryView *pinCategoryView;
@property(nonatomic, strong)UIButton *btnAll;
@property(nonatomic, strong)UIStackView *topStackView;
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
- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = self.topStackView.frame;
    if(!CGRectEqualToRect(rect, CGRectZero)) {
        !self.layoutSubviewsCallback ?: self.layoutSubviewsCallback(rect);
    }
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(NSArray<LXClassifyBaseCategoryModel *> *)categoryListModel shouldShowJiShiDa:(BOOL)shouldShowJiShiDa {
    self.bannerView.imageURLStringsGroup = @[
        @"https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302",
        @"https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302",
        @"https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302",
        @"https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302",
        @"https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302"
    ];

    self.topStackView.hidden = categoryListModel.count <= 0;
    self.btnAll.hidden = categoryListModel.count <= 5;
    self.btnJiShiDa.hidden = !shouldShowJiShiDa;
    [self.pinCategoryView dataFill:categoryListModel];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    // [self.wrapperStackView addArrangedSubview:self.bannerView];

    [self.topStackView addArrangedSubview:self.pinCategoryView];
    [self.topStackView addArrangedSubview:self.btnAll];
    [self.wrapperStackView addArrangedSubview:self.topStackView];

    self.filterType = LXSubcategoryFilterTypeJiShiDa;

    [self.filterView addSubview:self.btnJiShiDa];

    [self.priceWrapperView addSubview:self.btnPrice];
    [self.priceWrapperView addSubview:self.imgViewArrowUp];
    [self.priceWrapperView addSubview:self.imgViewArrowDown];
    [self.filterView addSubview:self.priceWrapperView];

    [self.filterView addSubview:self.btnSale];
    [self.wrapperStackView addArrangedSubview:self.filterView];

    [self addSubview:self.wrapperStackView];

    [self masonry];
}
- (void)prepareVM {
    @weakify(self)
    [[[self.btnAll rac_signalForControlEvents:UIControlEventTouchUpInside]
      throttle:0.3]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        !self.toggleShowAll ?: self.toggleShowAll(self.btnAll);
    }];
    [[[self.btnJiShiDa rac_signalForControlEvents:UIControlEventTouchUpInside]
      throttle:0.3]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        self.filterType = LXSubcategoryFilterTypeJiShiDa;
    }];
    [[[self.priceWrapperView rac_signalForControlEvents:UIControlEventTouchUpInside]
      throttle:0.3]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if(self.filterType == LXSubcategoryFilterTypePriceAsc) {
            self.filterType = LXSubcategoryFilterTypePriceDesc;
        } else {
            self.filterType = LXSubcategoryFilterTypePriceAsc;
        }
    }];
    [[[self.btnSale rac_signalForControlEvents:UIControlEventTouchUpInside]
      throttle:0.3]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        self.filterType = LXSubcategoryFilterTypeSale;
    }];
}

#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.pinCategoryView, self.filterView,
                  self.btnJiShiDa, self.priceWrapperView, self.btnSale,
                  self.btnPrice, self.imgViewArrowUp, self.imgViewArrowDown)
    [self.wrapperStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0.f);
        make.left.equalTo(@(kWPercentage(10.f)));
        make.right.equalTo(@(kWPercentage(-10.f)));
    }];
    // [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.height.equalTo(@(kBannerSectionHeight));
    // }];
    [self.pinCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.top.left.bottom.equalTo(@0.f);
        make.height.equalTo(@(kPinCategoryViewHeight));
    }];
    [self.btnAll mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.top.bottom.equalTo(self.pinCategoryView);
        // make.left.equalTo(self.pinCategoryView.mas_right);
        // make.right.equalTo(@0.f);
        make.width.equalTo(@35.f);
    }];
    [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(kPinFilterViewHeight));
    }];
    [self.btnJiShiDa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(@0.f);
    }];
    [self.priceWrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnJiShiDa.mas_right).offset(kWPercentage(40.f));
        make.centerY.equalTo(self.btnJiShiDa);
    }];
    [self.btnPrice setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.btnPrice setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.btnPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(@0.f);
    }];
    [self.imgViewArrowUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnPrice.mas_right).offset(kWPercentage(3.5f));
        make.right.equalTo(@0.f);
        make.bottom.equalTo(self.btnPrice.mas_centerY).offset(kWPercentage(-1.5f));
    }];
    [self.imgViewArrowDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgViewArrowUp);
        make.top.equalTo(self.btnPrice.mas_centerY).offset(kWPercentage(1.5f));
    }];
    [self.btnSale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceWrapperView.mas_right).offset(kWPercentage(30.f));
        make.right.lessThanOrEqualTo(@0.f);
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
- (UIStackView *)wrapperStackView {
    if(!_wrapperStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisVertical;
        sv.spacing = 0.f;
        _wrapperStackView = sv;
    }
    return _wrapperStackView;
}
- (SDCycleScrollView *)bannerView {
    if(!_bannerView){
        SDCycleScrollView *v = [[SDCycleScrollView alloc]init];
        v.delegate = self;
        v.placeholderImage = [iBLImage imageNamed:@""];
        v.layer.cornerRadius = kWPercentage(4.f);
        v.clipsToBounds = YES;
        _bannerView = v;
    }
    return _bannerView;
}
- (UIStackView *)topStackView {
    if(!_topStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisHorizontal;
        sv.spacing = 0.f;
        _topStackView = sv;
    }
    return _topStackView;
}
- (LX3rdCategoryView *)pinCategoryView {
    if(!_pinCategoryView){
        LX3rdCategoryView *v = [[LX3rdCategoryView alloc]init];
        [v customized3rdCategoryViewStyle];
        v.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [v.flowLayout prepareLayout];
        v.minimumLineSpacing = kWPercentage(5.f);
        v.minimumInteritemSpacing = kWPercentage(5.f);
        v.sectionInset = UIEdgeInsetsMake(kWPercentage(10.f), 0.f, kWPercentage(10.f), 0.f);
        v.itemSize = CGSizeMake(kWPercentage(68.f), kPinCategoryViewHeight - v.sectionInset.top - v.sectionInset.bottom);

        _pinCategoryView = v;
    }
    return _pinCategoryView;
}
- (UIButton *)btnAll {
    if(!_btnAll){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];

        [btn setImage:[iBLImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
        _btnAll = btn;
    }
    return _btnAll;
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
