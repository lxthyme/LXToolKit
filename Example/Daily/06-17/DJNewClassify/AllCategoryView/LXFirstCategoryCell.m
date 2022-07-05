//
//  LXFirstCategoryCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXFirstCategoryCell.h"

@interface LXFirstCategoryCell() {
    /// 边框宽度
    CGFloat __borderWidth;
    /// 图标尺寸
    CGFloat __logoWidth;
    /// 图标外层容器尺寸
    CGFloat __wrapperWidth;
    /// labTitle 选择时高度
    CGFloat __labelHeight;
    /// wrapperStackView's spacing
    CGFloat __wrapperSpacing;
}
@property(nonatomic, strong)UIStackView *wrapperStackView;
@property(nonatomic, strong)UIImageView *imgViewBgLogo;
@property(nonatomic, strong)UIImageView *imgViewLogo;
@property(nonatomic, strong)UIView *logView;
@property(nonatomic, strong)LXLabel *labTitle;

@end

@implementation LXFirstCategoryCell
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareCategoryConfig];
        [self prepareUI];
    }
    return self;
}
- (void)prepareForReuse {
    [super prepareForReuse];
}
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    // Configure the view for the selected state
    if(selected) {
        // self.imgViewLogo.layer.borderColor = [UIColor colorWithHex:0xFF774F].CGColor;
        self.logView.layer.borderWidth = kWPercentage(1.5f);
        self.labTitle.backgroundColor = [UIColor colorWithHex:0xFF774F];
        self.labTitle.textColor = self.selectedTextColor;
        self.labTitle.font = [UIFont boldSystemFontOfSize:11.f];
    } else {
        // self.imgViewLogo.layer.borderColor = [UIColor whiteColor].CGColor;
        self.logView.layer.borderWidth = 0.f;
        self.labTitle.backgroundColor = [UIColor clearColor];
        self.labTitle.textColor = self.normalTextColor;
        self.labTitle.font = [UIFont systemFontOfSize:11.f];
    }
}
#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(LXCategoryModel *)categoryModel {
    self.labTitle.text = categoryModel.title;
    // [self.imgViewLogo bl_setImageWithUrl:[NSURL URLWithString:@"https://loremflickr.com/200/200?random=1"] placeholderImage:nil];
    [self.imgViewLogo setImage:[iBLImage imageNamed:categoryModel.imageNames]];
}

#pragma mark -
#pragma mark - 👀Public Actions
/// 配置分类球属性
/// @param logoWidth 图标尺寸
/// @param borderWidth 边框宽度
/// @param wrapperSpacing wrapperStackView's spacing
/// @param labelHeight label 选中时的高度
- (void)configCategoryWithLogoWidth:(CGFloat)logoWidth
                        borderWidth:(CGFloat)borderWidth
                     wrapperSpacing:(CGFloat)wrapperSpacing
                        labelHeight:(CGFloat)labelHeight {
    __borderWidth = borderWidth;
    __logoWidth = logoWidth;
    __wrapperWidth = logoWidth + borderWidth * 4;
    __labelHeight = labelHeight;
    __wrapperSpacing = kWPercentage(2.5f);

    CGFloat h = 0.f;
    h += __logoWidth + __borderWidth * 4;
    h += __wrapperSpacing + __labelHeight;
}

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
/// 预置分类球样式属性
- (void)prepareCategoryConfig {
    [self configCategoryWithLogoWidth:kWPercentage(36.f)
                          borderWidth:kWPercentage(1.5f)
                       wrapperSpacing:kWPercentage(3.5f)
                          labelHeight:kWPercentage(17.f)];
}
- (void)prepareUI {
    [self.logView addSubview:self.imgViewBgLogo];
    [self.imgViewBgLogo addSubview:self.imgViewLogo];
    [self.wrapperStackView addArrangedSubview:self.logView];
    [self.wrapperStackView addArrangedSubview:self.labTitle];
    [self.contentView addSubview:self.wrapperStackView];

    [self masonry];
}
#pragma mark getter / setter
- (void)setSelectedTextColor:(UIColor *)selectedTextColor {
    if([selectedTextColor isEqual:_selectedTextColor]) {
        return;
    }
    _selectedTextColor = selectedTextColor;
    if(self.isSelected) {
        self.labTitle.textColor = selectedTextColor;
    }
}
- (void)setNormalTextColor:(UIColor *)normalTextColor {
    if([normalTextColor isEqual:_normalTextColor]) {
        return;
    }
    _normalTextColor = normalTextColor;
    if(!self.isSelected) {
        self.labTitle.textColor = normalTextColor;
    }
}
#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.wrapperStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(@0.f);
        make.left.greaterThanOrEqualTo(@0.f);
        make.bottom.right.lessThanOrEqualTo(@0.f);
    }];
    [self.imgViewBgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.logView).inset(__borderWidth);
    }];
    [self.imgViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.imgViewBgLogo).inset(__borderWidth);
        make.width.height.equalTo(@(__logoWidth));
    }];
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(__labelHeight));
        make.width.greaterThanOrEqualTo(@(20.f));
    }];
}

#pragma mark Lazy Property
- (UIStackView *)wrapperStackView {
    if(!_wrapperStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisVertical;
        sv.spacing = __wrapperSpacing;
        sv.alignment = UIStackViewAlignmentCenter;
        sv.distribution = UIStackViewDistributionFillProportionally;
        _wrapperStackView = sv;
    }
    return _wrapperStackView;
}
- (UIView *)logView {
    if(!_logView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xF9F9F9];
        v.layer.borderColor = [UIColor colorWithHex:0xFF774F].CGColor;
        v.layer.borderWidth = 0.f;
        v.layer.cornerRadius = __wrapperWidth / 2.f;
        v.clipsToBounds = YES;
        _logView = v;
    }
    return _logView;
}
- (UIImageView *)imgViewLogo {
    if(!_imgViewLogo){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        iv.backgroundColor = [UIColor lightGrayColor];
        // iv.layer.borderColor = [UIColor whiteColor].CGColor;
        // iv.layer.borderWidth = kWPercentage(1.5f);
        iv.clipsToBounds = YES;
        iv.layer.cornerRadius = __logoWidth / 2.f;
        _imgViewLogo = iv;
    }
    return _imgViewLogo;
}
- (UIImageView *)imgViewBgLogo {
    if(!_imgViewBgLogo){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [iBLImage imageNamed:@"icon_classify_placeholder"];
        _imgViewBgLogo = iv;
    }
    return _imgViewBgLogo;
}

- (LXLabel *)labTitle {
    if(!_labTitle){
        LXLabel *label = [[LXLabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:11.f];
        label.textColor = [UIColor blackColor];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.clipsToBounds = YES;
        label.layer.cornerRadius = __labelHeight / 2.f;
        label.x_insets = UIEdgeInsetsMake(kWPercentage(1.f), kWPercentage(3.5f), kWPercentage(1.f), kWPercentage(3.5f));

        _labTitle = label;
    }
    return _labTitle;
}
@end
