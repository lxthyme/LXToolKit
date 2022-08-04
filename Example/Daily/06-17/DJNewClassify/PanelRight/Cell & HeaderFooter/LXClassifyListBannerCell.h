//
//  LXClassifyListBannerCell.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseTableViewCell.h>
#import "LXShopResourceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXClassifyListBannerCell : LXBaseTableViewCell {
}

- (void)dataFill:(LXShopResourceModel *)bannerInfo;

@end

NS_ASSUME_NONNULL_END
