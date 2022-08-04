//
//  DJClassifyRightSkeletonScreen.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/23.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJClassifyRightSkeletonScreen.h"

@interface DJClassifyRightGoodsItemSkeletonScreen: LXBaseView{
}
@property(nonatomic, strong)UIView *leftView;
@property(nonatomic, strong)UIView *rightView1;
@property(nonatomic, strong)UIView *rightView2;
@property(nonatomic, strong)UIView *rightView3;
@property(nonatomic, strong)UIView *rightView4;
@property(nonatomic, strong)UIView *lineView;

@end

@implementation DJClassifyRightGoodsItemSkeletonScreen
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
- (UIView *)createTemplateView {
    UIColor *color = [UIColor colorWithHex:0xF9F9F8];
    CGFloat cornerRaidus = kWPercentage(2.75f);
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = color;
    v.layer.cornerRadius = cornerRaidus;
    return v;
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    self.leftView = [self createTemplateView];
    self.rightView1 = [self createTemplateView];
    self.rightView2 = [self createTemplateView];
    self.rightView3 = [self createTemplateView];
    self.rightView4 = [self createTemplateView];
    self.rightView4.layer.cornerRadius = kWPercentage(10.f);
    self.lineView = [self createTemplateView];
    self.lineView.layer.cornerRadius = 0.f;


    [self addSubview:self.leftView];
    [self addSubview:self.rightView1];
    [self addSubview:self.rightView2];
    [self addSubview:self.rightView3];
    [self addSubview:self.rightView4];
    [self addSubview:self.lineView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    CGFloat padding1 = kWPercentage(10.f);
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(padding1));
        make.bottom.equalTo(@(-padding1));
        make.width.height.equalTo(@(kWPercentage(100.f)));
    }];
    [self.rightView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftView);
        make.left.equalTo(self.leftView.mas_right).offset(padding1);
        make.right.equalTo(@(-padding1));
        make.height.equalTo(@(kWPercentage(20.f)));
    }];
    [self.rightView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightView1.mas_bottom).offset(padding1);
        make.left.right.height.equalTo(self.rightView1);
    }];
    [self.rightView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(self.rightView1);
        make.bottom.equalTo(self.leftView);
    }];
    [self.rightView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightView3.mas_right).offset(kWPercentage(15.f));
        make.right.equalTo(@(kWPercentage(-15.f)));
        make.centerY.equalTo(self.rightView3);
        make.width.height.equalTo(@(kWPercentage(20.f)));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftView.mas_right).offset(kWPercentage(5.f));
        make.right.bottom.equalTo(@0.f);
        make.height.equalTo(@1.f);
    }];
}

#pragma mark Lazy Property
@end

@interface DJClassifyRightSkeletonScreen() {
}
@property(nonatomic, strong)UIView *topView;
@property(nonatomic, strong)UIView *topLeftView;
@property(nonatomic, strong)UIView *topRightView;
@property(nonatomic, strong)DJClassifyRightGoodsItemSkeletonScreen *goodsItemSkeletonScreen1;
@property(nonatomic, strong)DJClassifyRightGoodsItemSkeletonScreen *goodsItemSkeletonScreen2;
@property(nonatomic, strong)DJClassifyRightGoodsItemSkeletonScreen *goodsItemSkeletonScreen3;
@end

@implementation DJClassifyRightSkeletonScreen
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
- (UIView *)createTemplateView {
    UIColor *color = [UIColor colorWithHex:0xF9F9F8];
    CGFloat cornerRaidus = kWPercentage(4.f);
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = color;
    v.layer.cornerRadius = cornerRaidus;
    return v;
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    self.topView = [self createTemplateView];
    self.topLeftView = [self createTemplateView];
    self.topRightView = [self createTemplateView];
    self.goodsItemSkeletonScreen1 = [[DJClassifyRightGoodsItemSkeletonScreen alloc]init];
    self.goodsItemSkeletonScreen2 = [[DJClassifyRightGoodsItemSkeletonScreen alloc]init];
    self.goodsItemSkeletonScreen3 = [[DJClassifyRightGoodsItemSkeletonScreen alloc]init];

    [self addSubview:self.topView];
    [self addSubview:self.topLeftView];
    [self addSubview:self.topRightView];
    [self addSubview:self.goodsItemSkeletonScreen1];
    [self addSubview:self.goodsItemSkeletonScreen2];
    [self addSubview:self.goodsItemSkeletonScreen3];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    CGFloat padding1 = kWPercentage(10.f);
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(padding1));
        make.right.equalTo(@(-padding1));
        make.height.equalTo(@(kWPercentage(90.f)));
    }];
    [self.topLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(padding1);
        make.left.equalTo(self.topView);
        make.height.equalTo(@(kWPercentage(24.f)));
    }];
    [self.topRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.topLeftView);
        make.left.equalTo(self.topLeftView.mas_right).offset(kWPercentage(26.f));
        make.right.equalTo(self.topView);
        make.width.height.equalTo(self.topLeftView);
    }];
    [self.goodsItemSkeletonScreen1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLeftView.mas_bottom);
        make.left.right.equalTo(@0.f);
    }];
    [self.goodsItemSkeletonScreen2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsItemSkeletonScreen1.mas_bottom);
        make.left.right.equalTo(self.goodsItemSkeletonScreen1);
    }];
    [self.goodsItemSkeletonScreen3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsItemSkeletonScreen2.mas_bottom);
        make.left.right.equalTo(self.goodsItemSkeletonScreen1);
    }];
}

#pragma mark Lazy Property

@end
