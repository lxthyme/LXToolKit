//
//  LXFirstCategoryCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXFirstCategoryCell.h"

@interface LXFirstCategoryCell() {
}
@property(nonatomic, strong)UIStackView *wrapperStackView;
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
    } else {
        // self.imgViewLogo.layer.borderColor = [UIColor whiteColor].CGColor;
        self.logView.layer.borderWidth = 0.f;
        self.labTitle.backgroundColor = [UIColor clearColor];
    }
}
#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(LXCategoryModel *)categoryModel {
    self.labTitle.text = categoryModel.title;
    // [self.imgViewLogo bl_setImageWithUrl:[NSURL URLWithString:@"https://loremflickr.com/200/200?random=1"] placeholderImage:nil];
    // [self.imgViewLogo setImage:[iBLImage imageNamed:categoryModel.imageNames]];

    if([self.reuseIdentifier isEqualToString:kFirstCategoryCellFoldReuseIdentifier]) {
        self.logView.layer.cornerRadius = kFirstCategoryCellFoldBorderWidth / 2.f;
        self.imgViewLogo.layer.cornerRadius = kFirstCategoryCellFoldImgLogoWidth / 2.f;
    } else if([self.reuseIdentifier isEqualToString:kFirstCategoryCellUnfoldReuseIdentifier]) {
        
    }
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    [self.logView addSubview:self.imgViewLogo];
    [self.wrapperStackView addArrangedSubview:self.logView];
    [self.wrapperStackView addArrangedSubview:self.labTitle];
    [self.contentView addSubview:self.wrapperStackView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.wrapperStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kWPercentage(2.f)));
        make.left.right.equalTo(@0.f);
        make.bottom.lessThanOrEqualTo(@0.f);
    }];
    [self.logView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(kFirstCategoryCellFoldBorderWidth));
    }];
    [self.imgViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0.f);
        make.width.height.equalTo(@(kFirstCategoryCellFoldImgLogoWidth));
    }];
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(kFirstCategoryCellLabelHeight));
        make.width.greaterThanOrEqualTo(@(kFirstCategoryCellLabelHeight));
    }];
}

#pragma mark Lazy Property
- (UIStackView *)wrapperStackView {
    if(!_wrapperStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisVertical;
        sv.spacing = kWPercentage(2.5f);
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
        _imgViewLogo = iv;
    }
    return _imgViewLogo;
}
- (LXLabel *)labTitle {
    if(!_labTitle){
        LXLabel *label = [[LXLabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor blackColor];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.clipsToBounds = YES;
        label.layer.cornerRadius = kFirstCategoryCellLabelHeight / 2.f;
        label.x_insets = UIEdgeInsetsMake(kWPercentage(1.f), kWPercentage(3.5f), kWPercentage(1.f), kWPercentage(3.5f));

        _labTitle = label;
    }
    return _labTitle;
}
@end
