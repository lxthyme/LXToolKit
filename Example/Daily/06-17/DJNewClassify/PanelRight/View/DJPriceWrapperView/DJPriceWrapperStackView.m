//
//  DJPriceWrapperStackView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/8.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJPriceWrapperStackView.h"

#import <Masonry/Masonry.h>

@interface DJPriceWrapperStackView() {
}
@property(nonatomic, strong)UIImageView *imgViewLogo;

@end

@implementation DJPriceWrapperStackView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareUI];
    }
    return self;
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(NSString *)logo price:(NSString *)price {
    self.imgViewLogo.image = [iBLImage imageNamed:logo];
    self.imgViewLogo.hidden = logo.length <= 0;
    self.labTitle.text = price;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];
    self.axis = UILayoutConstraintAxisHorizontal;
    self.alignment = UIStackViewAlignmentCenter;
    self.spacing = kWPercentage(5.f);

    [self addArrangedSubview:self.imgViewLogo];
    [self addArrangedSubview:self.labTitle];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.imgViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kWPercentage(22.f)));
    }];
}

#pragma mark Lazy Property
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
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}

@end
