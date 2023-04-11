//
//  DJTagView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/5.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJTagView.h"

#import <DJBusinessTools/LXLabel.h>
#import <BLCategories/UIColor+Hex.h>

@interface DJTagView() {
}
@property(nonatomic, strong)UIStackView *wrapperStackView;
@property(nonatomic, strong)UIImageView *imgViewLogo;
@property(nonatomic, strong)LXLabel *labTitle;

@end

@implementation DJTagView
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
#pragma mark - 🌎LoadData
- (void)dataFill:(DJGoodItemPopinfosList *)popInfoItem {
    self.labTitle.attributedText = popInfoItem.f_textAttributeString;
    self.labTitle.layer.borderWidth = popInfoItem.f_borderWidth;
    self.labTitle.layer.borderColor = popInfoItem.f_borderColor.CGColor;
    self.labTitle.layer.cornerRadius = popInfoItem.f_cornerRadius;
    UIColor *bgColor = popInfoItem.f_backgroundColor;
    if(!bgColor) {
        bgColor = [UIColor whiteColor];
    }
    self.labTitle.backgroundColor = bgColor;

    self.wrapperStackView.layer.cornerRadius = 0.f;
    self.imgViewLogo.hidden = YES;
    if([popInfoItem.buyMember isEqualToString:@"1"]) {
        self.imgViewLogo.hidden = NO;
        self.imgViewLogo.image = [iBLImage imageNamed:@"dj_plus_member"];
        self.wrapperStackView.layer.cornerRadius = kWPercentage(4.f);
    }
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self.wrapperStackView addArrangedSubview:self.imgViewLogo];
    [self.wrapperStackView addArrangedSubview:self.labTitle];
    [self addSubview:self.wrapperStackView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.imgViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kWPercentage(14.f)));
    }];
    [self.wrapperStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
        // make.top.greaterThanOrEqualTo(@0.f);
        // make.bottom.lessThanOrEqualTo(@0.f);
        // make.centerY.equalTo(@0.f);
        make.height.equalTo(@15.f);
    }];
}

#pragma mark Lazy Property
- (UIStackView *)wrapperStackView {
    if(!_wrapperStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.clipsToBounds = YES;
        sv.axis = UILayoutConstraintAxisHorizontal;
        sv.spacing = 0.f;
        _wrapperStackView = sv;
    }
    return _wrapperStackView;
}
- (UIImageView *)imgViewLogo {
    if(!_imgViewLogo){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewLogo = iv;
    }
    return _imgViewLogo;
}

- (LXLabel *)labTitle {
    if(!_labTitle){
        LXLabel *label = [[LXLabel alloc]init];
        label.text = @"";
        label.x_insets = UIEdgeInsetsMake(kWPercentage(2.f), kWPercentage(4.f), kWPercentage(2.f), kWPercentage(4.f));
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.layer.borderWidth = 1.f;
        _labTitle = label;
    }
    return _labTitle;
}
@end
