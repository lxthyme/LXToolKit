//
//  LXCommonAlertView.m
//  DJBusinessTools
//
//  Created by lxthyme on 2022/2/21.
//

#import "LXCommonAlertView.h"
#import <Masonry/Masonry.h>
// #import <UIColor_Hex/UIColor+Hex.h>
#import "UIColor+ex.h"
// #import <BLSafeFetchDataFunctions/BLSafeFetchDataFunctions.h>
// #import <HandyFrame/UIView+LayoutMethods.h>
// #import <BLCategories/UIColor+Hex.h>
// #import <BLImage/iBLImage.h>
#import "LXMacro.h"

@interface LXCommonAlertView() {
}
@end

@implementation LXCommonAlertView
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
- (void)show {
    if(self.isShowing) {
        return;
    }
    self.isShowing = YES;

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    self.alpha = 1.f;
    self.imgViewLogo.alpha = 1.f;
    self.wrapperView.alpha = 1.f;
    self.frame = keyWindow.bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;

    NSMutableArray *values = [NSMutableArray array];

    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
    animation.values = values;

    [self.imgViewLogo.layer addAnimation:animation forKey:nil];
    [self.wrapperView.layer addAnimation:animation forKey:nil];
}
- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.wrapperView.alpha = 0;
        self.imgViewLogo.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.isShowing = NO;
        [self removeFromSuperview];
        if (self.closeBtnBlock) {
            self.closeBtnBlock();
        }
    }];
}

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)btnConfirmClick:(UIButton *)sender {
    [self hide];
    if(self.dismissBlock) {
        self.dismissBlock();
    }
}
- (void)btnClosedClick:(UIButton *)sender {
    [self hide];
}
- (void)btnCancelClick:(UIButton *)sender {
    [self hide];
}
- (void)bringBtnCancelToFront {
    [self.btnCancel removeFromSuperview];
    [self.btnWrapperStackView insertArrangedSubview:self.btnCancel atIndex:0];
    [self.btnWrapperStackView setNeedsLayout];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.clipsToBounds = YES;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];

    [self.wrapperView addSubview:self.btnClosed];

    [self.wrapperView addSubview:self.labTitle];
    [self.wrapperView addSubview:self.labContent];
    [self.wrapperView addSubview:self.lineView];
    [self.btnWrapperStackView addArrangedSubview:self.btnConfirm];
    [self.btnWrapperStackView addArrangedSubview:self.btnCancel];
    [self.btnWrapperView addSubview:self.btnWrapperStackView];
    [self.wrapperView addSubview:self.btnWrapperView];

    [self addSubview:self.wrapperView];
    [self addSubview:self.imgViewLogo];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    // UIView *superView = self;
    [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kWPercentage(50.f)));
        make.right.equalTo(@(-kWPercentage(50.f)));
        make.centerY.equalTo(@0.f);
    }];
    [self.imgViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.wrapperView.mas_top);
        make.centerX.equalTo(@0.f);
    }];
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kWPercentage(20.f)));
        make.left.greaterThanOrEqualTo(@(kWPercentage(20.f)));
        make.right.lessThanOrEqualTo(@(-kWPercentage(20.f)));
        make.centerX.equalTo(@0.f);
    }];
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(kWPercentage(15.f));
        make.left.equalTo(@(kWPercentage(20.f)));
        make.right.lessThanOrEqualTo(@(-kWPercentage(20.f)));
        // make.height.lessThanOrEqualTo(@(kWPercentage(250.f)));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labContent.mas_bottom).offset(kWPercentage(16.f));
        make.left.right.equalTo(@0.f);
        make.height.equalTo(@1.f);
    }];
    [self.btnWrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
        make.height.equalTo(@(48.f));
    }];
    [self.btnWrapperStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
    [self.btnClosed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kWPercentage(20.f)));
        make.right.equalTo(@(-kWPercentage(20.f)));
        make.width.height.equalTo(@(kWPercentage(15.f)));
    }];
}

#pragma mark Lazy Property
- (UIImageView *)imgViewLogo {
    if(!_imgViewLogo){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        iv.hidden = YES;
        _imgViewLogo = iv;
    }
    return _imgViewLogo;
}

- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"满返规则";
        label.font = [UIFont boldSystemFontOfSize:kWPercentage(15.f)];
        label.textColor = [UIColor xl_colorWithHex:0x1E1E1E];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        _labTitle = label;
    }
    return _labTitle;
}
- (UILabel *)labContent {
    if(!_labContent){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:kWPercentage(14.f)];
        label.textColor = [UIColor xl_colorWithHex:0x5F6067];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentLeft;
        _labContent = label;
    }
    return _labContent;
}
- (UIView *)lineView {
    if(!_lineView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor xl_colorWithHex:0xEAEAEA];
        _lineView = v;
    }
    return _lineView;
}
- (UIStackView *)btnWrapperStackView {
    if(!_btnWrapperStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisHorizontal;
        sv.distribution = UIStackViewDistributionFillEqually;
        sv.spacing = 1.f;
        _btnWrapperStackView = sv;
    }
    return _btnWrapperStackView;
}
- (UIView *)btnWrapperView {
    if(!_btnWrapperView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor xl_colorWithHex:0xDDDDDD];
        _btnWrapperView = v;
    }
    return _btnWrapperView;
}
- (UIButton *)btnConfirm {
    if(!_btnConfirm){
        //初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];

        [btn setTitle:@"知道了" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor xl_colorWithHex:0x1E1E1E] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:kWPercentage(15.f)];

        [btn addTarget:self action:@selector(btnConfirmClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnConfirm = btn;
    }
    return _btnConfirm;
}
- (UIButton *)btnCancel {
    if(!_btnCancel){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.hidden = YES;
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:@"取消" forState:UIControlStateNormal];

        [btn addTarget:self action:@selector(btnCancelClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnCancel = btn;
    }
    return _btnCancel;
}
- (LXButton *)btnClosed {
    if(!_btnClosed){
        // 初始化一个 Button
        LXButton *btn = [LXButton buttonWithType:UIButtonTypeCustom];
        btn.f_expandInset = 8.f;
        btn.hidden = YES;
        [btn setImage:[UIImage imageNamed:@"icon_closed"] forState:UIControlStateNormal];

        [btn addTarget:self action:@selector(btnClosedClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnClosed = btn;
    }
    return _btnClosed;
}
- (UIView *)wrapperView
{
    if (_wrapperView == nil) {
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor xl_colorWithHex:0xf8f8f8];
        v.layer.masksToBounds = YES;
        v.layer.cornerRadius = 6;

        _wrapperView = v;
    }
    return _wrapperView;
}
@end
