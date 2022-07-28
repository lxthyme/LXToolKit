//
//  LXClassifyRightCollectionCell.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseCollectionViewCell.h>
#import "LXB2CGoodsItemListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXClassifyRightCollectionCell : LXBaseCollectionViewCell {
}

- (void)dataFill:(LXB2CGoodItemModel *)item;

@end

NS_ASSUME_NONNULL_END
