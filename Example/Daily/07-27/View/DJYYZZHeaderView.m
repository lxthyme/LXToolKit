//
//  DJYYZZHeaderView.m
//  DJBusinessModule
//
//  Created by lxthyme on 2022/7/20.
//
#import "DJYYZZHeaderView.h"

#import <DJBusinessTools/UIView+ex.h>

@interface DJYYZZHeaderView() {
}
@property (nonatomic, strong)UIView *wrapperView;
@property (nonatomic, strong)UILabel *signLabel;
@property (nonatomic, strong)UIView *sepLineView;

@end

@implementation DJYYZZHeaderView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}
- (void)prepareForReuse {
    [super prepareForReuse];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.wrapperView xl_setRoundingCorners:[UIColor whiteColor]
                                borderWidth:0.f
                                      raddi:kWPercentage(4.f)
                                    corners:UIRectCornerTopLeft | UIRectCornerTopRight
                                   isDotted:NO];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor colorWithHex:0xF9F9F9];

    [self addSubview:self.wrapperView];
    [self.wrapperView addSubview:self.signLabel];
    [self.wrapperView addSubview:self.sepLineView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(kWPercentage(10.f)));
        make.right.equalTo(@(kWPercentage(-10.f)));
        make.bottom.equalTo(@0.f);
    }];
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0.f);
        make.left.equalTo(@(kWPercentage(15.f)));
        make.right.equalTo(@(kWPercentage(-15.f)));
    }];
    [self.sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kWPercentage(20.f)));
        make.right.equalTo(@(kWPercentage(-20.f)));
        make.bottom.equalTo(@0.f);
        make.height.equalTo(@1.f);
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
- (UILabel *)signLabel {
    if (!_signLabel) {
        _signLabel = [[UILabel alloc] init];
        //_signLabel.backgroundColor = UIColor.yellowColor;
        _signLabel.text = @"商家从业资质";
        _signLabel.textColor = [UIColor blackColor];
        _signLabel.textAlignment = NSTextAlignmentLeft;
        _signLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _signLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _signLabel;
}

- (UIView *)sepLineView {
    if (!_sepLineView) {
        _sepLineView = [[UIView alloc] init];
        _sepLineView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    }
    return _sepLineView;
}
@end
