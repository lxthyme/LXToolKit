//
//  DJ1rdAllCategoryWrapperView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJ1rdAllCategoryWrapperView.h"
#import <DJBusinessTools/UIView+ex.h>
#import <pop/POP.h>

@interface DJ1rdAllCategoryWrapperView() {
}
@property(nonatomic, strong)UIView *wrapperView;
@property(nonatomic, strong)UILabel *labTitle;
@property(nonatomic, strong)UIView *containerView;
@property(nonatomic, strong)UIView *lineView;
@property(nonatomic, strong)UIControl *btnBottom;
@property(nonatomic, strong)UILabel *labClosed;
@property(nonatomic, strong)UIImageView *imgViewClosed;

@end

@implementation DJ1rdAllCategoryWrapperView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.wrapperView xl_setRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                        raddi:kWPercentage(10.f)];
}
#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFillWithContainerView:(UIView *)containerView {}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)showWithContainerView:(UIView *)containerView topConstraint:(MASViewAttribute *)topConstraint {
    if(self.superview) {
        [self dismissFirstCategoryViewAnimation];
        return;
    }
    [self.containerView addSubview:containerView];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];

    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topConstraint);
        make.left.right.bottom.equalTo(@0.f);
    }];
    [containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];

    POPSpringAnimation *maskAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    maskAnim.fromValue = @0.f;
    maskAnim.toValue = @1.f;
    [self.layer pop_addAnimation:maskAnim forKey:@"MaskView.opacity"];
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    CGFloat positionY = kWPercentage(266 + 38 * 2) / 2.f;
    anim.fromValue = @(-positionY);
    anim.toValue = @(positionY);
    anim.springBounciness = 0.f;
    [self.wrapperView.layer pop_addAnimation:anim forKey:@"allCategoryView.translation.y"];
}
- (void)dismissFirstCategoryView {
    if(!self.superview) {
        return;
    }
    POPSpringAnimation *maskAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    maskAnim.fromValue = @1.f;
    maskAnim.toValue = @0.f;
    maskAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        [self removeFromSuperview];
    };
    [self.layer pop_addAnimation:maskAnim forKey:@"MaskView.opacity"];
}
- (void)dismissFirstCategoryViewAnimation {
    if(!self.superview) {
        return;
    }
    POPSpringAnimation *maskAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    maskAnim.fromValue = @1.f;
    maskAnim.toValue = @0.f;
    [self.layer pop_addAnimation:maskAnim forKey:@"MaskView.opacity"];

    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(kWPercentage(-400.f));
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        [self removeFromSuperview];
    };
    [self.wrapperView.layer pop_addAnimation:anim forKey:@"allCategoryView.translation.y"];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.7f];
    [self addTarget:self action:@selector(dismissFirstCategoryViewAnimation) forControlEvents:UIControlEventTouchUpInside];

    [self.wrapperView addSubview:self.labTitle];
    [self.wrapperView addSubview:self.containerView];
    [self.wrapperView addSubview:self.lineView];

    [self.btnBottom addSubview:self.labClosed];
    [self.btnBottom addSubview:self.imgViewClosed];
    [self.wrapperView addSubview:self.btnBottom];

    [self addSubview:self.wrapperView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
    }];
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0.f);
        make.left.equalTo(@(kWPercentage(15.f)));
        make.height.equalTo(@(kWPercentage(38.f)));
    }];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom);
        make.left.right.equalTo(@0.f);
        make.height.equalTo(@(kWPercentage(266.f)));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView.mas_bottom);
        make.left.right.equalTo(@0.f);
        make.height.equalTo(@1.f);
    }];
    [self.btnBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
        make.height.equalTo(@(kWPercentage(38.f)));
    }];
    [self.labClosed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.btnBottom);
    }];
    [self.imgViewClosed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labClosed.mas_right).offset(kWPercentage(7.5f));
        make.centerY.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UIView *)wrapperView {
    if(!_wrapperView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xF9F9F9];
        _wrapperView = v;
    }
    return _wrapperView;
}
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"全部分类";
        label.font = [UIFont boldSystemFontOfSize:kWPercentage(13.f)];
        label.textColor = [UIColor colorWithHex:0x333333];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
- (UIView *)containerView {
    if(!_containerView){
        UIView *v = [[UIView alloc]init];
        _containerView = v;
    }
    return _containerView;
}
- (UIView *)lineView {
    if(!_lineView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
        _lineView = v;
    }
    return _lineView;
}
- (UIControl *)btnBottom {
    if(!_btnBottom){
        UIControl *v = [[UIControl alloc]init];
        [v addTarget:self action:@selector(dismissFirstCategoryViewAnimation) forControlEvents:UIControlEventTouchUpInside];
        _btnBottom = v;
    }
    return _btnBottom;
}
- (UILabel *)labClosed {
    if(!_labClosed){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"点击收起";
        label.font = [UIFont systemFontOfSize:kWPercentage(14.f)];
        label.textColor = [UIColor colorWithHex:0x333333];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labClosed = label;
    }
    return _labClosed;
}
- (UIImageView *)imgViewClosed {
    if(!_imgViewClosed){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [iBLImage imageNamed:@"dj_newClassifyList_arrowUp"];
        iv.tintColor = [UIColor colorWithHex:0x666666];
        _imgViewClosed = iv;
    }
    return _imgViewClosed;
}

@end
