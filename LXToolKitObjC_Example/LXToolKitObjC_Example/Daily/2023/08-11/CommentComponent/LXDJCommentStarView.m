//
//  LXDJCommentStarView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/11.
//
#import "LXDJCommentStarView.h"

#import <Masonry/Masonry.h>

@interface LXDJCommentStarView() {
}
@property(nonatomic, strong)UIStackView *wrapperStackView;
@property(nonatomic, strong)UIImageView *imgViewStar1;
@property(nonatomic, strong)UIImageView *imgViewStar2;
@property(nonatomic, strong)UIImageView *imgViewStar3;
@property(nonatomic, strong)UIImageView *imgViewStar4;
@property(nonatomic, strong)UIImageView *imgViewStar5;

@end

@implementation LXDJCommentStarView
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
- (void)dataFill:(NSInteger)score {
    UIImage *star_filled = [UIImage imageNamed:@"icon_star_filled"];
    UIImage *star_outline = [UIImage imageNamed:@"icon_star_outline"];
    self.imgViewStar1.image = score >= 1 ? star_filled : star_outline;
    self.imgViewStar2.image = score >= 2 ? star_filled : star_outline;
    self.imgViewStar3.image = score >= 3 ? star_filled : star_outline;
    self.imgViewStar4.image = score >= 4 ? star_filled : star_outline;
    self.imgViewStar5.image = score >= 5 ? star_filled : star_outline;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self.wrapperStackView addArrangedSubview:self.imgViewStar1];
    [self.wrapperStackView addArrangedSubview:self.imgViewStar2];
    [self.wrapperStackView addArrangedSubview:self.imgViewStar3];
    [self.wrapperStackView addArrangedSubview:self.imgViewStar4];
    [self.wrapperStackView addArrangedSubview:self.imgViewStar5];
    [self addSubview:self.wrapperStackView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.wrapperStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
    [self.imgViewStar1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@10.f);
    }];
    [self.imgViewStar2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self.imgViewStar1);
    }];
    [self.imgViewStar3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self.imgViewStar1);
    }];
    [self.imgViewStar4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self.imgViewStar1);
    }];
    [self.imgViewStar5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self.imgViewStar1);
    }];
}

#pragma mark Lazy Property
- (UIStackView *)wrapperStackView {
    if(!_wrapperStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisHorizontal;
        sv.alignment = UIStackViewAlignmentCenter;
        // sv.distribution = UIStackViewDistributionFillProportionally;
        sv.spacing = 2.5f;
        _wrapperStackView = sv;
    }
    return _wrapperStackView;
}
- (UIImageView *)imgViewStar1 {
    if(!_imgViewStar1){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewStar1 = iv;
    }
    return _imgViewStar1;
}
- (UIImageView *)imgViewStar2 {
    if(!_imgViewStar2){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewStar2 = iv;
    }
    return _imgViewStar2;
}
- (UIImageView *)imgViewStar3 {
    if(!_imgViewStar3){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewStar3 = iv;
    }
    return _imgViewStar3;
}
- (UIImageView *)imgViewStar4 {
    if(!_imgViewStar4){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewStar4 = iv;
    }
    return _imgViewStar4;
}
- (UIImageView *)imgViewStar5 {
    if(!_imgViewStar5){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewStar5 = iv;
    }
    return _imgViewStar5;
}

@end
