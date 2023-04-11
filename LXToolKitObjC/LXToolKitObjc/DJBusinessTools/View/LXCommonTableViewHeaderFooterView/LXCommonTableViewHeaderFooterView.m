//
//  LXCommonTableViewHeaderFooterView.m
//  DJBusinessTools
//
//  Created by lxthyme on 2022/5/5.
//

#import "LXCommonTableViewHeaderFooterView.h"
#import <Masonry/Masonry.h>
// #import <BLSafeFetchDataFunctions/BLSafeFetchDataFunctions.h>
// #import <HandyFrame/UIView+LayoutMethods.h>
// #import <BLCategories/UIColor+Hex.h>
// #import <BLImage/iBLImage.h>
#import <LXToolKitObjc/DJMacro.h>

@interface LXCommonTableViewHeaderFooterView() {
}

@end

@implementation LXCommonTableViewHeaderFooterView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithReuseIdentifier:reuseIdentifier]) {
        _hPadding = kWPercentage(15.f);
        [self prepareUI];
    }
    return self;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)setHPadding:(CGFloat)hPadding {
    if(_hPadding == hPadding) {
        return;
    }
    _hPadding = hPadding;

    [self masonry];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self.contentView addSubview:self.labTitle];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    [self.labTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(self.hPadding));
        make.right.lessThanOrEqualTo(@(-self.hPadding));
        make.centerY.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        _labTitle = label;
    }
    return _labTitle;
}
@end
