//
//  DJB2CCategoryModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseModel.h"
#import "DJB2CGoodsItemListModel.h"
#import "DJClassifyBaseCategoryModel.h"

typedef NS_ENUM(NSInteger, DJSubCategoryIndexType) {
    /// 二级目录中间次序
    DJSubCategoryIndexTypeDefault,
    /// 二级目录第一个
    DJSubCategoryIndexTypeFirst,
    /// 二级目录最后一个
    DJSubCategoryIndexTypeLast
};

NS_ASSUME_NONNULL_BEGIN

@interface DJB2CCategoryModel: DJClassifyBaseCategoryModel {
}
@property (nonatomic, assign)NSString *categoryColor;
@property (nonatomic, copy)NSArray<DJB2CCategoryModel *> *categorys;
@property (nonatomic, copy)NSString *showModel;
@property (nonatomic, assign)NSInteger bestSelling;
@property (nonatomic, copy)NSString *categoryPicture;
@property (nonatomic, copy)NSString *categoryHot;
// @property (nonatomic, copy)NSString *categoryName;
@property (nonatomic, copy)NSString *parentId;
@property (nonatomic, copy)NSArray<NSString *> *urls;
@property (nonatomic, copy)NSString *categoryIcon;
@property (nonatomic, copy)NSArray<NSString *> *urlTypes;
@property (nonatomic, copy)NSString *categoryIconOn;
@property (nonatomic, copy)NSString *lev;
// @property (nonatomic, copy)NSString *categoryId;
@property (nonatomic, copy)NSArray<NSString *> *showNames;

/// 三级分类对应的商品列表
@property (nonatomic, strong)DJB2CGoodsItemListModel *_Nullable f_goodsList;
@property(nonatomic, assign)DJT3DataLoadedStatus f_loadStatus;

@end

NS_ASSUME_NONNULL_END
