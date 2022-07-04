//
//  LXFirstCategoryCell.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseCollectionViewCell.h"

#import "LXSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LXFirstCategoryType) {
    /// 仅一行时的样式
    LXFirstCategoryTypeFold,
    /// 展开后的样式
    LXFirstCategoryTypeUnfold,
};

#define kFirstCategoryCellBorderWidth kWPercentage(1.5f)
#define kFirstCategoryCellFoldImgLogoWidth kWPercentage(36.f)
#define kFirstCategoryCellFoldBorderWidth (kFirstCategoryCellFoldImgLogoWidth + kFirstCategoryCellBorderWidth * 4)
#define kFirstCategoryCellLabelHeight kWPercentage(17.f)

static NSString * const kFirstCategoryCellFoldReuseIdentifier = @"LXFirstCategoryCell.Fold";
static NSString * const kFirstCategoryCellUnfoldReuseIdentifier = @"LXFirstCategoryCell.Unfold";

@interface LXFirstCategoryCell : LXBaseCollectionViewCell {
}

- (void)dataFill:(LXCategoryModel *)categoryModel;

@end

NS_ASSUME_NONNULL_END
