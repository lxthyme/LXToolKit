//
//  LXClassifyRightCollectionCell.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseCollectionViewCell.h>
#import "LXGoodsInfoListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXClassifyRightCollectionCell : LXBaseCollectionViewCell {
}

- (void)dataFill:(LXGoodsInfoModel *)item;

@end

NS_ASSUME_NONNULL_END
