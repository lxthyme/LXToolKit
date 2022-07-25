//
//  LXClassifySkeletonScreen.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/23.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifySkeletonScreen.h"
#import <DJBusinessTools/iPhoneX.h>
#import "LXClassifyRightSkeletonScreen.h"

@interface LXCategorySkeletonScreen: UIStackView {
}
@property(nonatomic, strong)UIView *topView;
@property(nonatomic, strong)UIView *bottomView;

@end

@implementation LXCategorySkeletonScreen
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
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.spacing = kWPercentage(6.5f);
    self.axis = UILayoutConstraintAxisVertical;
    self.distribution = UIStackViewDistributionFillProportionally;
    self.alignment = UIStackViewAlignmentCenter;

    [self addArrangedSubview:self.topView];
    [self addArrangedSubview:self.bottomView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(kWPercentage(36.f)));
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kWPercentage(44.f)));
        make.height.equalTo(@(kWPercentage(15.f)));
    }];
}

#pragma mark Lazy Property
- (UIView *)topView {
    if(!_topView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xF9F9F8];
        v.layer.cornerRadius = kWPercentage(18.f);
        _topView = v;
    }
    return _topView;
}
- (UIView *)bottomView {
    if(!_bottomView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xF9F9F8];
        v.layer.cornerRadius = kWPercentage(4.f);
        _bottomView = v;
    }
    return _bottomView;
}
@end

@interface LXClassifySkeletonScreen() {
}
@property(nonatomic, strong)UIView *panelTopView;
@property(nonatomic, strong)UIView *searchView;
@property(nonatomic, strong)LXCategorySkeletonScreen *categoryView1;
@property(nonatomic, strong)LXCategorySkeletonScreen *categoryView2;
@property(nonatomic, strong)LXCategorySkeletonScreen *categoryView3;
@property(nonatomic, strong)LXCategorySkeletonScreen *categoryView4;
@property(nonatomic, strong)LXCategorySkeletonScreen *categoryView5;
@property(nonatomic, strong)LXCategorySkeletonScreen *categoryView6;

@property(nonatomic, strong)UIView *panelLeftView;
@property(nonatomic, strong)LXClassifyRightSkeletonScreen *panelRightView;

@property(nonatomic, strong)UIView *panelBottomView;
@property(nonatomic, strong)UIView *tabbarLineView;
@property(nonatomic, strong)UIView *tabbarView1;
@property(nonatomic, strong)UIView *tabbarView2;
@property(nonatomic, strong)UIView *tabbarView3;
@property(nonatomic, strong)UIView *tabbarView4;

@end

@implementation LXClassifySkeletonScreen
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
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (UIView *)createTabbarView {
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [UIColor colorWithHex:0xF9F9F8];
    return v;
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    self.categoryView1 = [[LXCategorySkeletonScreen alloc]init];
    self.categoryView2 = [[LXCategorySkeletonScreen alloc]init];
    self.categoryView3 = [[LXCategorySkeletonScreen alloc]init];
    self.categoryView4 = [[LXCategorySkeletonScreen alloc]init];
    self.categoryView5 = [[LXCategorySkeletonScreen alloc]init];
    self.categoryView6 = [[LXCategorySkeletonScreen alloc]init];

    self.tabbarView1 = [self createTabbarView];
    self.tabbarView2 = [self createTabbarView];
    self.tabbarView3 = [self createTabbarView];
    self.tabbarView4 = [self createTabbarView];

    [self.panelTopView addSubview:self.searchView];
    [self.panelTopView addSubview:self.categoryView1];
    [self.panelTopView addSubview:self.categoryView2];
    [self.panelTopView addSubview:self.categoryView3];
    [self.panelTopView addSubview:self.categoryView4];
    [self.panelTopView addSubview:self.categoryView5];
    [self.panelTopView addSubview:self.categoryView6];
    [self addSubview:self.panelTopView];

    [self addSubview:self.panelLeftView];
    [self addSubview:self.panelRightView];

    [self.panelBottomView addSubview:self.tabbarView1];
    [self.panelBottomView addSubview:self.tabbarView2];
    [self.panelBottomView addSubview:self.tabbarView3];
    [self.panelBottomView addSubview:self.tabbarView4];
    [self.panelBottomView addSubview:self.tabbarLineView];
    [self addSubview:self.panelBottomView];

    [self masonry];
    [self masonryPanelTopView];
    [self masonryTabbarView];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    CGFloat topPading = iPhoneX.xl_safeareaInsets.top + kWPercentage(44.f + 67.5f);
    [self.panelTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@(topPading));
    }];
    [self.panelLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.panelTopView.mas_bottom);
        make.left.equalTo(@0.f);
        make.width.equalTo(@(kWPercentage(50.f)));
    }];
    [self.panelRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.panelLeftView);
        make.left.equalTo(self.panelLeftView.mas_right);
        make.right.equalTo(@0.f);
    }];
    MASViewAttribute *bottomAttribute = self.mas_bottom;
    if (@available(iOS 11.0, *)) {
        bottomAttribute = self.mas_safeAreaLayoutGuideBottom;
    }
    [self.panelBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.panelLeftView.mas_bottom);
        make.left.right.equalTo(@0.f);
        make.bottom.equalTo(bottomAttribute);
        make.height.equalTo(@(kWPercentage(50.f)));
    }];
}
- (void)masonryPanelTopView {
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kWPercentage(15.f)));
        make.right.equalTo(@(kWPercentage(-15.f)));
        make.bottom.equalTo(@(kWPercentage(-73.5f)));
        make.height.equalTo(@(kWPercentage(32.f)));
    }];
    [self.categoryView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kWPercentage(16.f)));
        make.bottom.equalTo(@(kWPercentage(-5.f)));
    }];
    [self.categoryView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.categoryView1.mas_right).offset(kWPercentage(22.f));
        make.width.centerY.equalTo(self.categoryView1);
    }];
    [self.categoryView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.categoryView2.mas_right).offset(kWPercentage(22.f));
        make.width.centerY.equalTo(self.categoryView1);
    }];
    [self.categoryView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.categoryView3.mas_right).offset(kWPercentage(22.f));
        make.width.centerY.equalTo(self.categoryView1);
    }];
    [self.categoryView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.categoryView4.mas_right).offset(kWPercentage(22.f));
        make.width.centerY.equalTo(self.categoryView1);
    }];
    [self.categoryView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.categoryView5.mas_right).offset(kWPercentage(22.f));
        make.width.centerY.equalTo(self.categoryView1);
    }];
}
- (void)masonryTabbarView {
    [self.tabbarLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@1.f);
    }];
    CGFloat itemWidth = kWPercentage(21.f);
    CGFloat padding = floorf((SCREEN_WIDTH / 4.f - itemWidth) / 2.f);
    [self.tabbarView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kWPercentage(10.f)));
        make.left.equalTo(@(padding));
        make.width.height.equalTo(@(itemWidth));
        // make.centerX.equalTo(self.panelBottomView).multipliedBy(1 / 4.f);
    }];
    [self.tabbarView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tabbarView1.mas_right).offset(padding * 2);
        make.size.centerY.equalTo(self.tabbarView1);
        // make.centerX.equalTo(self.panelBottomView).multipliedBy(2 / 4.f);
    }];
    [self.tabbarView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tabbarView2.mas_right).offset(padding * 2);
        make.size.centerY.equalTo(self.tabbarView1);
        // make.centerX.equalTo(self.panelBottomView).multipliedBy(3 / 4.f);
    }];
    [self.tabbarView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tabbarView3.mas_right).offset(padding * 2);
        make.size.centerY.equalTo(self.tabbarView1);
        // make.centerX.equalTo(self.panelBottomView).multipliedBy(4 / 4.f);
    }];
}

#pragma mark Lazy Property
- (UIView *)panelTopView {
    if(!_panelTopView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xE3E3E3];
        _panelTopView = v;
    }
    return _panelTopView;
}
- (UIView *)searchView {
    if(!_searchView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xF9F9F8];
        v.layer.cornerRadius = kWPercentage(16.f);
        _searchView = v;
    }
    return _searchView;
}
- (UIView *)panelLeftView {
    if(!_panelLeftView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xF9F9F8];
        _panelLeftView = v;
    }
    return _panelLeftView;
}
- (LXClassifyRightSkeletonScreen *)panelRightView {
    if(!_panelRightView){
        LXClassifyRightSkeletonScreen *v = [[LXClassifyRightSkeletonScreen alloc]init];
        _panelRightView = v;
    }
    return _panelRightView;
}
- (UIView *)panelBottomView {
    if(!_panelBottomView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xFFFFFF];
        _panelBottomView = v;
    }
    return _panelBottomView;
}
- (UIView *)tabbarLineView {
    if(!_tabbarLineView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xEAEAEA];
        _tabbarLineView = v;
    }
    return _tabbarLineView;
}
@end
