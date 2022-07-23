//
//  LXClassifyListLeftCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyListLeftCell.h"

#import <DJBusinessTools/UIView+ex.h>

#define kNormalTextColor [UIColor colorWithHex:0x333333]
#define kSelectedTextColor [UIColor colorWithHex:0xFF774F]
#define kNormalBgColor [UIColor colorWithHex:0xF9F9F9]
#define kSelectedBgColor [UIColor colorWithHex:0xFFFFFF]
@interface LXClassifyListLeftCell() {
}
@property(nonatomic, strong)UIImageView *indicatorView;
@property(nonatomic, strong)UIStackView *wrapperStackView;
@property(nonatomic, strong)UILabel *labTitle;
@property(nonatomic, strong)UIImageView *imgViewLogo;

@end

@implementation LXClassifyListLeftCell
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self prepareUI];
    }
    return self;
}
- (void)prepareForReuse {
    [super prepareForReuse];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    self.indicatorView.hidden = !selected;
    if(selected) {
        self.labTitle.textColor = kSelectedTextColor;
        self.labTitle.font = [UIFont boldSystemFontOfSize:kWPercentage(12.f)];
        self.contentView.backgroundColor = kSelectedBgColor;
    } else {
        self.labTitle.textColor = kNormalTextColor;
        self.labTitle.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
        self.contentView.backgroundColor = kNormalBgColor;
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];

    [self.indicatorView xl_setRoundingCorners:[UIColor clearColor]
                                          borderWidth:0.f
                                                raddi:kWPercentage(4.f)
                                              corners:UIRectCornerTopRight | UIRectCornerBottomRight isDotted:NO];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(NSString *)title {
    self.labTitle.text = title;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = kNormalBgColor;

    [self.wrapperStackView addArrangedSubview:self.imgViewLogo];
    [self.wrapperStackView addArrangedSubview:self.labTitle];
    [self.contentView addSubview:self.wrapperStackView];
    [self.contentView addSubview:self.indicatorView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.wrapperStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0.f);
        // make.height.equalTo(@20.f);
    }];
    [self.imgViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(kWPercentage(11.f)));
    }];
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(@0.f);
        make.width.equalTo(@(kWPercentage(3.f)));
    }];
}

#pragma mark Lazy Property
- (UIImageView *)indicatorView {
    if(!_indicatorView){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.backgroundColor = [UIColor colorWithHex:0xFF774F];
        iv.image = [iBLImage imageNamed:@"icon_secondCategory_indicator"];
        _indicatorView = iv;
    }
    return _indicatorView;
}
- (UIStackView *)wrapperStackView {
    if(!_wrapperStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisHorizontal;
        sv.alignment = UIStackViewAlignmentCenter;
        sv.spacing = kWPercentage(1.5f);
        _wrapperStackView = sv;
    }
    return _wrapperStackView;
}
- (UIImageView *)imgViewLogo {
    if(!_imgViewLogo){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.backgroundColor = [UIColor colorWithHex:0xF6F6F6];
        // iv.image = [UIImage imageNamed:@""];
        _imgViewLogo = iv;
    }
    return _imgViewLogo;
}

- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:12.f];
        label.textColor = kNormalTextColor;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
@end
