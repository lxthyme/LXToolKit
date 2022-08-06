//
//  DJClassifyModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/8/5.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseModel.h>
#import "DJB2CCategoryModel.h"
#import "DJO2OCategoryListModel.h"
#import "DJClassifyBaseCategoryModel.h"
#import "DJShopResourceModel.h"
@class DJClassifyListModel;
@class DJClassifyRightModel;
@class DJClassifyGoodsInfoModel;

NS_ASSUME_NONNULL_BEGIN

/// 一级目录数据结构
@interface DJClassifyModel: LXBaseModel {
}
/// 一级目录id: 二级目录数据源
@property(nonatomic, copy)NSDictionary<NSString *, DJClassifyListModel *> *f_classifyList;
/// 「for O2O」一级目录数据
@property (nonatomic, copy)NSArray<DJClassifyBaseCategoryModel *> *f_categorys;

@end

/// 二级目录数据结构
@interface DJClassifyListModel: LXBaseModel {
}
/// 对应一级目录的 categoryId
@property(nonatomic, copy)NSString *f_1rdCategoryId;
///二级目录id: 三级目录数据源
@property(nonatomic, copy)NSDictionary<NSString *, DJClassifyRightModel *> *f_rightModelList;
/// 「for O2O」二级目录数据
@property (nonatomic, copy)NSArray<DJClassifyBaseCategoryModel *> *f_categorys;

@end

/// 三级目录数据结构
@interface DJClassifyRightModel: LXBaseModel {
}
/// 对应二级目录的 categoryId
@property(nonatomic, copy)NSString *f_2rdCategoryId;
/// 在二级目录中的次序
@property(nonatomic, assign)DJSubCategoryIndexType f_idxType;
/// 是否展示 banner
@property(nonatomic, assign)BOOL f_shouldShowBanner;
/// 过滤器是否展示"即时达"
@property(nonatomic, assign)BOOL f_shouldShowJiShiDa;
@property(nonatomic, assign)NSInteger f_pinIdx;

///  所有三级级目录数据
@property (nonatomic, copy)NSArray<DJClassifyBaseCategoryModel *> *f_categorys;

/// 「only O2O」
@property (nonatomic, strong)DJO2OCategoryListModel *f_t2Category;
// @property (nonatomic, copy)NSArray<DJO2OCategoryListModel *> *f_t3o2orywCategorys;
@property (nonatomic, copy)NSDictionary<NSString *, DJGoodsIdsModel *> *idsListMap;
/// 1. "全部"分类的商品信息
@property(nonatomic, strong)DJO2OCategoryListModel *f_allO2OGoodsList;
/// 2. 所有三级分类的商品信息
@property (nonatomic, strong)NSArray<DJO2OCategoryListModel *> *f_allO2OSectionGoodsList;
/// 3. banner 数据
@property(nonatomic, strong)DJShopResourceModel *f_bannerInfo;

/// 「only B2C」分类 & 商品信息
@property (nonatomic, strong)DJB2CCategoryModel *f_b2cCategoryModel;
@end

@interface DJClassifyGoodsInfoModel: LXBaseModel {
}
@property(nonatomic, assign)DJClassifyGoodItemType f_itemType;
@property(nonatomic, strong)DJO2OGoodItemModel *f_o2oGoodItem;
@property(nonatomic, strong)DJB2CGoodItemModel *f_b2cGoodItem;

@end

NS_ASSUME_NONNULL_END
