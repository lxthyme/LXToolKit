//
//  DJClassifyListBannerView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseTableViewCell.h>
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "DJShopResourceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJClassifyListBannerView : LXBaseTableViewCell {
}
@property(nonatomic, strong)SDCycleScrollView *bannerView;

- (void)dataFill:(DJShopResourceModel *)bannerInfo;

@end

NS_ASSUME_NONNULL_END
