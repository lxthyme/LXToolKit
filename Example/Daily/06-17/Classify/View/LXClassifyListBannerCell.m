//
//  LXClassifyListBannerCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyListBannerCell.h"

#import <SDCycleScrollView/SDCycleScrollView.h>

@interface LXClassifyListBannerCell()<SDCycleScrollViewDelegate> {
}
@property(nonatomic, strong)SDCycleScrollView *bannerView;
@end

@implementation LXClassifyListBannerCell
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
    self.contentView.backgroundColor = [UIColor whiteColor];

    self.bannerView.imageURLStringsGroup = @[
        @"https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302",
        @"https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302",
        @"https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302",
        @"https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302",
        @"https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302"
    ];
    [self.contentView addSubview:self.bannerView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (SDCycleScrollView *)bannerView {
    if(!_bannerView){
        SDCycleScrollView *v = [[SDCycleScrollView alloc]init];
        v.delegate = self;
        v.placeholderImage = [UIImage imageNamed:@""];
        _bannerView = v;
    }
    return _bannerView;
}

@end
