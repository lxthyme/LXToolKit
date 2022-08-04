//
//  DJClassifySectionHeaderView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseTableViewHeaderFooterView.h>
#import "DJLHCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJClassifySectionHeaderView : LXBaseTableViewHeaderFooterView {
}

- (void)dataFill:(DJClassifyBaseCategoryModel *)model;

@end

NS_ASSUME_NONNULL_END
