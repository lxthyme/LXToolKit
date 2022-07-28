//
//  DJO2OCategoryListModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyBaseCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

/// O2O 分类
@interface DJO2OCategoryListModel: LXClassifyBaseCategoryModel {
}
/// 分类ID
// @property (nonatomic, copy)NSString *categoryId;
/// 分类名称
// @property (nonatomic, copy)NSString *categoryName;
/// 分类图片
@property (nonatomic, copy)NSString *categoryPicture;
@property (nonatomic, strong)NSNumber *showProm;
@property (nonatomic, copy)NSString *resourceId;
@property (nonatomic, copy)NSString *promText;
/// 二级分类
@property (nonatomic, copy)NSArray<DJO2OCategoryListModel *> *rywCategorys;
/// 「only 二级目录」是否展示全部 1是 0否
@property (nonatomic, strong)NSNumber *showAll;
/// 「only 二级目录」目录图标
@property (nonatomic, copy)NSString *categoryIcon;
/// 「only 二级目录」三级分类id集合，默认逗号隔开，无三级分类则为当前二级分类id（仅二级有这个参数）
@property (nonatomic, copy)NSString *endCateIds;

@end

NS_ASSUME_NONNULL_END
