//
//  DJYYZZFooterView.m
//  DJBusinessModule
//
//  Created by lxthyme on 2022/7/20.
//
#import "DJYYZZFooterView.h"

#import <DJBusinessTools/UIView+ex.h>

@interface DJYYZZFooterView() {
}
@property (nonatomic, strong)UIView *wrapperView;

@end

@implementation DJYYZZFooterView
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
                                    corners:UIRectCornerBottomLeft | UIRectCornerBottomRight
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

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0.f);
        make.left.equalTo(@(kWPercentage(10.f)));
        make.right.bottom.equalTo(@(kWPercentage(-10.f)));
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
@end
