//
//  LXStackViewCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/12/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXStackViewCell.h"

#import <Masonry/Masonry.h>

@interface LXStackViewCell() {
}
@property(nonatomic, strong)UIStackView *wrapperStackView;

@end

@implementation LXStackViewCell
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
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    // self.contentView.backgroundColor = [UIColor RandomColor];

    [self.contentView addSubview:self.self.wrapperStackView];
    [self.contentView addSubview:self.labTitle];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.wrapperStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@20.f);
    }];
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wrapperStackView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UIStackView *)wrapperStackView {
    if(!_wrapperStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisVertical;
        sv.alignment = UIStackViewAlignmentCenter;
        // sv.distribution = UIStackViewDistributionFillProportionally;
        sv.spacing = 0.f;
        _wrapperStackView = sv;
    }
    return _wrapperStackView;
}
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor whiteColor];
        // label.backgroundColor = [UIColor cyanColor];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}

@end
