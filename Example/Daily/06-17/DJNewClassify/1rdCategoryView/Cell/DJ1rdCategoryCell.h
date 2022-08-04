//
//  DJ1rdCategoryCell.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseCollectionViewCell.h>

#import "DJO2OCategoryListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJ1rdCategoryCell : LXBaseCollectionViewCell {
}
@property(nonatomic, strong)UIColor *normalTextColor;
@property(nonatomic, strong)UIColor *selectedTextColor;

- (void)dataFill:(DJO2OCategoryListModel *)categoryModel;

/// 预置分类球样式属性
- (void)prepareCategoryConfig;
/// cell 高度
// - (CGFloat)cellHeight;
/// 配置分类球属性
/// @param logoWidth 图标尺寸
/// @param borderWidth 边框宽度
/// @param wrapperSpacing wrapperStackView's spacing
/// @param labelHeight label 选中时的高度
- (void)configCategoryWithLogoWidth:(CGFloat)logoWidth
                        borderWidth:(CGFloat)borderWidth
                     wrapperSpacing:(CGFloat)wrapperSpacing
                        labelHeight:(CGFloat)labelHeight;
@end

NS_ASSUME_NONNULL_END
