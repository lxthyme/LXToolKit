//
//  LXClassifyRightVCModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/23.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseModel.h"
#import "LXLHCategoryModel.h"

typedef NS_ENUM(NSInteger, LXClassifyRightCellType) {
    LXClassifyRightVCCellTypeBanner = 1,
    LXClassifyRightVCCellTypeGoodsList,
};

NS_ASSUME_NONNULL_BEGIN

@interface LXClassifyRightModel: LXBaseModel {
}
/// 三级目录数据源
@property(nonatomic, assign)BOOL f_shouldShowBanner;
/// 三级分类对应的商品列表
@property (nonatomic, strong)LXGoodsInfoListModel *f_goodsList;
/// 在二级目录中的顺序
@property(nonatomic, assign)LXSubCategoryIndexType f_idxType;
/// 三级级目录数据
@property (nonatomic, copy)NSArray<LXLHCategoryModel *> *categorys;

@end

@interface LXClassifyListModel: LXBaseModel {
}
///二级目录id: 三级目录数据源
@property(nonatomic, copy)NSDictionary<NSString *, LXClassifyRightModel *> *rightListModel;
/// 二级目录数据
@property (nonatomic, copy)NSArray<LXLHCategoryModel *> *categorys;

@end

@interface LXClassifyModel: LXBaseModel {
}
/// 一级目录id: 二级目录数据源
@property(nonatomic, copy)NSDictionary<NSString *, LXClassifyListModel *> *classifyListModel;
/// 一级目录数据
@property (nonatomic, copy)NSArray<LXLHCategoryModel *> *categorys;

@end

NS_ASSUME_NONNULL_END
