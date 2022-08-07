//
//  DJO2OCategoryListModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJClassifyBaseCategoryModel.h"
#import "DJClassifyMacro.h"
#import "DJO2OGoodItemModel.h"
#import "DJGoodsIdsModel.h"
#import "DJShopResourceModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DJO2OCategoryCateType) {
    /// 0: 普通
    DJO2OCategoryCateTypeNormal = 0,
    /// 1: 全部
    DJO2OCategoryCateTypeAll = 1,
    /// 2: 促销
    DJO2OCategoryCateTypePromotion = 2
};

/// [O2O 分类](http://192.168.29.26:8080/workspace/myWorkspace.do?projectId=494#11582)
@interface DJO2OCategoryListModel: DJClassifyBaseCategoryModel {
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
/// 三级分类类型
@property (nonatomic, copy)NSArray<DJO2OCategoryListModel *> *rywCategorys;
/// 「only 二级目录」是否展示全部 1是 0否
// @property (nonatomic, assign)NSInteger showAll;
@property (nonatomic, assign)DJO2OCategoryCateType cateType;
/// 「only 二级目录」目录图标
@property (nonatomic, copy)NSString *categoryIcon;
/// 「only 二级目录」三级分类id集合，默认逗号隔开，无三级分类则为当前二级分类id（仅二级有这个参数）
@property (nonatomic, copy)NSString *endCateIds;

// @property(nonatomic, assign)DJClassifyGoodItemType f_itemType;
/// 二级分类
// @property (nonatomic, copy)NSArray<DJO2OCategoryListModel *> *f_rywCategorys;

@property(nonatomic, assign)BOOL f_showAll;
@property(nonatomic, assign)DJClassifyCategoryType f_categoryType;
@property (nonatomic, strong)DJGoodsIdsModel *f_idsList;
/// 三级分类对应的商品列表
@property (nonatomic, strong)NSArray<DJO2OGoodItemModel *> *f_goodsList;
/// banner resource
@property(nonatomic, assign)DJT3DataLoadedStatus f_bannerStatus;
@property(nonatomic, strong)DJShopResourceModel *f_bannerResource;
/// 数据加载状态
// @property(nonatomic, assign)DJT3DataLoadedStatus f_dataLoadedStatus;
@property (nonatomic, strong)DJO2OCategoryListModel *f_t2AllCategory;
@end

NS_ASSUME_NONNULL_END
