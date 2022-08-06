//
//  DJClassifyRightCollectionCell.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseTableViewCell.h>
#import "DJB2CGoodsItemListModel.h"
#import "DJClassifyMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJClassifyRightCollectionCell : LXBaseTableViewCell {
}

- (void)dataFill:(DJGoodBaseItemModel *)item;
- (void)dataFillWithO2O:(DJO2OGoodItemModel *)item withNum:(NSInteger)num;
- (void)dataFillWithB2C:(DJB2CGoodItemModel *)item withNum:(NSInteger)num;

@end

NS_ASSUME_NONNULL_END
