//
//  LXClassifyRightCollectionCell.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseTableViewCell.h>
#import "LXB2CGoodsItemListModel.h"
#import "DJClassifyMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXClassifyRightCollectionCell : LXBaseTableViewCell {
}

- (void)dataFill:(LXGoodBaseItemModel *)item;

@end

NS_ASSUME_NONNULL_END
