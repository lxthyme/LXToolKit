//
//  LXDJSearchHistoryCell.m
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/4/18.
//
#import "LXDJSearchHistoryCell.h"
#import <DJRSwiftResource/DJRSwiftResource-Swift.h>

#import <Masonry/Masonry.h>

#define kHistoryItemLogoWidth kWPercentage(12.f)
#define kHistoryItemSpacing kWPercentage(5.f)
#define kSearchHistoryCellHPadding kWPercentage(10.f)

@interface LXDJSearchHistoryCell() {
}
@property(nonatomic, strong)UIStackView *contentStackView;
@property(nonatomic, strong)UIImageView *imgViewLogo;
@property(nonatomic, strong)UILabel *labTitle;
@property(nonatomic, strong)UIImageView *imgViewArrow;

@end

@implementation LXDJSearchHistoryCell
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
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)data:(NSDictionary *)item {
    NSString *title = item[@"title"];
    BOOL isHot = [item[@"isHot"] boolValue];
    BOOL isArrow = [item[@"isArrow"] boolValue];
    self.contentStackView.hidden = YES;
    self.imgViewArrow.hidden = YES;
    if(isArrow) {
        self.imgViewArrow.hidden = NO;
        self.imgViewArrow.image = DJTest.icon_arrow_down;
        BOOL isDown = [item[@"isDown"] boolValue];
        CGFloat angle = isDown ? 0 : M_PI;
        self.imgViewArrow.transform = CGAffineTransformMakeRotation(angle);
        [self.imgViewArrow mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0.f);
            make.width.height.equalTo(@(kSearchHistoryCellHeight));
        }];
    } else {
        self.contentStackView.hidden = NO;
        self.labTitle.text = title;
        self.imgViewLogo.hidden = !isHot;
        self.imgViewLogo.image = DJTest.icon_search_hot;
        [self.imgViewArrow mas_remakeConstraints:^(MASConstraintMaker *make) {}];
    }
}

#pragma mark -
#pragma mark - 👀Public Actions
- (CGFloat)calcCellSize:(NSDictionary *)item {
    BOOL isHot = [item[@"isHot"] boolValue];
    CGFloat width = 0;
    CGSize titleSize = [self.labTitle textRectForBounds:CGRectMake(0, 0, CGFLOAT_MAX, 15)
                                 limitedToNumberOfLines:1].size;
    width += titleSize.width;
    if(isHot) {
        width += kHistoryItemSpacing + kHistoryItemLogoWidth;
    }
    width += kSearchHistoryCellHPadding * 2;
    return width;
}
#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor xl_colorWithHexString:@"#F5F5F5"];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = kSearchHistoryCellHeight / 2.f;

    [self.contentStackView addArrangedSubview:self.imgViewLogo];
    [self.contentStackView addArrangedSubview:self.labTitle];
    [self.contentView addSubview:self.contentStackView];
    [self.contentView addSubview:self.imgViewArrow];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.contentStackView,
                  self.imgViewLogo, self.labTitle,
                  self.imgViewArrow)
    [self.contentStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0.f);
        make.left.equalTo(@(kSearchHistoryCellHPadding));
        make.right.equalTo(@(-kSearchHistoryCellHPadding));
        make.height.equalTo(@(kSearchHistoryCellHeight));
    }];
}

#pragma mark Lazy Property
- (UIStackView *)contentStackView {
    if(!_contentStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisHorizontal;
        sv.alignment = UIStackViewAlignmentCenter;
        // sv.distribution = UIStackViewDistributionFillProportionally;
        sv.spacing = kHistoryItemSpacing;
        _contentStackView = sv;
    }
    return _contentStackView;
}
- (UIImageView *)imgViewLogo {
    if(!_imgViewLogo){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [UIImage imageNamed:@"icon_search_hot"];
        _imgViewLogo = iv;
    }
    return _imgViewLogo;
}
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
        label.textColor = [UIColor xl_colorWithHexString:@"#666666"];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
- (UIImageView *)imgViewArrow {
    if(!_imgViewArrow){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeCenter;
        iv.backgroundColor = [UIColor xl_colorWithHexString:@"#F5F5F5"];
        // iv.image = [UIImage imageNamed:@""];
        iv.layer.cornerRadius = kSearchHistoryCellHeight / 2.f;
        iv.clipsToBounds = YES;
        iv.hidden = YES;
        _imgViewArrow = iv;
    }
    return _imgViewArrow;
}

@end
