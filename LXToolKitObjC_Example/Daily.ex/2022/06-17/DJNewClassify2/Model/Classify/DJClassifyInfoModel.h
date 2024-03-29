//
//  DJClassifyInfoModel.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/7/23.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseModel.h"
#import "DJB2CCategoryModel.h"
#import "DJO2OCategoryListModel.h"
#import "DJClassifyBaseCategoryModel.h"
#import "DJShopResourceModel.h"

typedef NS_ENUM(NSInteger, DJClassifyRightCellType) {
    DJClassifyRightVCCellTypeBanner = 1,
    DJClassifyRightVCCellTypeGoodsList,
};

NS_ASSUME_NONNULL_BEGIN
// @interface LXO2OGoodsInfoModel: LXBaseModel {
// }
// @property (nonatomic, strong)DJO2OGoodItemModel *f_o2oGoodsList;
// @property (nonatomic, strong)DJO2OCategoryListModel *f_o2oCategoryItem;
//
// @end

@interface DJClassifyGoodsInfoModel: LXBaseModel {
}
/// 商品类型
@property(nonatomic, assign)DJClassifyGoodItemType f_itemType;
/// 对应三级目录的 categoryId
@property(nonatomic, copy)NSString *f_2rdCategoryId;
// /// 对应三级目录的 categoryId
// @property(nonatomic, copy)NSString *f_3rdCategoryId;
/// 「only B2C」三级商品对应的二级分类数据
@property(nonatomic, strong)DJB2CCategoryModel *f_b2cCategoryMdeol;
/// 「only B2C」
/// 「only B2C」三级商品
@property (nonatomic, strong)DJB2CGoodsItemListModel *f_b2CGoodsListModel;
//
// /// 「only O2O」
// @property (nonatomic, strong)NSArray<DJGoodsIdsModel *> *f_o2oIdsList;
/// 「only O2O」三级商品对应的二级分类数据
@property(nonatomic, strong)DJO2OCategoryListModel *f_o2oCategoryMdeol;
// /// 「only O2O」
/// 「only O2O」三级商品
// @property (nonatomic, strong)NSArray<DJGoodsIdsModel *> *f_o2oGoodsInfoList;
@property (nonatomic, strong)DJGoodsIdsModel *f_o2oGoodsInfo;
// /// 「only O2O」
// /// O2O 商品信息("全部"分类)
// // @property (nonatomic, strong)LXO2OGoodsInfoModel *f_allO2OGoodsInfoModel;
// // @property (nonatomic, copy)NSArray<NSArray<DJGoodBaseItemModel *> *> *f_goodsInfoList;
//
// /// 「only O2O」
// /// 是否是全部分类的数据
// // @property(nonatomic, assign)BOOL f_isAll;
// // @property (nonatomic, copy)NSArray<DJO2OGoodItemModel *> *f_o2oGoodsInfo;
//
//
// // @property (nonatomic, strong)NSDictionary<NSString *, NSArray<NSString *> *> *f_o2oIdsListMap;
// // @property (nonatomic, strong)DJO2OCategoryListModel *f_o2oCategoryItemModel;
@end


/// 三级目录数据结构
@interface DJClassifyRightModel: LXBaseModel {
}
/// 对应二级目录的 categoryId
@property(nonatomic, copy)NSString *f_2rdCategoryId;
/// 商品类型
@property(nonatomic, assign)DJClassifyGoodItemType f_itemType;
/// 在二级目录中的次序
@property(nonatomic, assign)DJSubCategoryIndexType f_idxType;
/// 是否展示 banner
@property(nonatomic, assign)BOOL f_shouldShowBanner;
/// 过滤器是否展示"即时达"
@property(nonatomic, assign)BOOL f_shouldShowJiShiDa;
/// showAll
@property(nonatomic, assign)BOOL f_showAll;
/// 当前定位的 section
@property(nonatomic, assign)NSInteger pinIdx;

/// 三级级目录数据
@property (nonatomic, copy)NSArray<DJClassifyBaseCategoryModel *> *f_categorys;
@property (nonatomic, strong)DJB2CCategoryModel *f_b2cCategoryModel;
@property (nonatomic, strong)DJO2OCategoryListModel *f_o2oCategoryModel;
/// 「only O2O」banner 数据
@property(nonatomic, strong)DJShopResourceModel *f_bannerInfo;
/// 「only B2C」商品信息
@property(nonatomic, strong)DJClassifyGoodsInfoModel *f_goodsInfoModel;
/// 「only O2O」all section 商品信息
// @property(nonatomic, strong)DJClassifyGoodsInfoModel *f_o2oAllGoodsInfoModel;
/// 「only O2O」所有分类的商品信息
@property(nonatomic, strong)NSArray<DJClassifyGoodsInfoModel *> *f_o2oGoodsInfoList;
/// 「only B2C」
/// B2C 商品信息
// @property (nonatomic, strong)DJB2CGoodsItemListModel *f_b2CGoodsListModel;
/// 「only O2O」
// @property (nonatomic, strong)NSArray<DJGoodsIdsModel *> *f_o2oIdsList;
/// 「for O2O」三级级目录数据
// @property (nonatomic, copy)NSArray<DJO2OCategoryListModel *> *rywCategorys;
/// 「only for 三级目录」"全部"分类的数据
// @property (nonatomic, strong)DJB2CGoodsItemListModel *f_allGoodsList;
/// 「only for O2O 二级目录」三级分类id集合，默认逗号隔开，无三级分类则为当前二级分类id（仅二级有这个参数）
// @property(nonatomic, strong)DJO2OCategoryListModel *f_o2oCategoryItemModel;
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
/// 「for B2C」二级目录数据
// @property (nonatomic, copy)NSArray<DJO2OCategoryListModel *> *rywCategorys;

@end


/// 一级目录数据结构
@interface DJClassifyModel: LXBaseModel {
}
/// 一级目录id: 二级目录数据源
@property(nonatomic, copy)NSDictionary<NSString *, DJClassifyListModel *> *f_classifyList;
/// 「for O2O」一级目录数据
@property (nonatomic, copy)NSArray<DJClassifyBaseCategoryModel *> *f_categorys;
/// 「for B2C」二级目录数据
// @property (nonatomic, copy)NSArray<DJO2OCategoryListModel *> *rywCategorys;

@end

NS_ASSUME_NONNULL_END
