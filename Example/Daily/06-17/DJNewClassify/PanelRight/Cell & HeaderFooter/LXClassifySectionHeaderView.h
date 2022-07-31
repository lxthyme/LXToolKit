//
//  LXClassifySectionHeaderView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseTableViewHeaderFooterView.h>
#import "LXLHCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXClassifySectionHeaderView : LXBaseTableViewHeaderFooterView {
}

- (void)dataFill:(LXClassifyBaseCategoryModel *)model;

@end

NS_ASSUME_NONNULL_END
