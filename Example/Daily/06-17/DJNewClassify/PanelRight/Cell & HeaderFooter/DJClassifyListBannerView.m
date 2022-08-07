//
//  DJClassifyListBannerView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJClassifyListBannerView.h"

#import <SDCycleScrollView/SDCycleScrollView.h>
#import "DJClassifyListBannerCell.h"

@interface DJClassifyListBannerView()<SDCycleScrollViewDelegate> {
}

@end

@implementation DJClassifyListBannerView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
}
#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(DJShopResourceModel *)bannerInfo {
    self.bannerView.autoScroll = YES;
    self.bannerView.imageURLStringsGroup = [[bannerInfo.onlineDeployList.rac_sequence
                                             filter:^BOOL(DJOnlineDeployList *value) {
        return !isEmptyString(value.picUrl);
    }]
                                            map:^id(DJOnlineDeployList *value) {
        return value.picUrl;
    }].array;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️SDCycleScrollViewDelegate
- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view {
    return [DJClassifyListBannerCell class];
}
- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view {
    if([cell isKindOfClass:[DJClassifyListBannerCell class]]) {
        DJClassifyListBannerCell *bannerCell = (DJClassifyListBannerCell *)cell;
        NSString *imagePath = self.bannerView.imageURLStringsGroup[index];
        [bannerCell.imageView bl_setImageWithUrl:[NSURL URLWithString:imagePath] animated:YES];
    }
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor whiteColor];

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
        v.autoScrollTimeInterval = 3.f;
        v.infiniteLoop = YES;
        v.delegate = self;
        v.placeholderImage = [iBLImage imageNamed:@""];
        v.layer.cornerRadius = kWPercentage(4.f);
        v.clipsToBounds = YES;
        _bannerView = v;
    }
    return _bannerView;
}

@end
