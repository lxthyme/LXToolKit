//
//  LXLHCategoryModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseModel.h"
#import "LXGoodsInfoListModel.h"

typedef NS_ENUM(NSInteger, LXSubCategoryIndexType) {
    LXSubCategoryIndexTypeDefault,
    LXSubCategoryIndexTypeFirst,
    LXSubCategoryIndexTypeLast
};

NS_ASSUME_NONNULL_BEGIN

@interface LXLHCategoryModel: LXBaseModel {
}
@property (nonatomic, assign)NSString *categoryColor;
@property (nonatomic, copy)NSArray<LXLHCategoryModel *> *categorys;
@property (nonatomic, copy)NSString *showModel;
@property (nonatomic, assign)NSInteger bestSelling;
@property (nonatomic, copy)NSString *categoryPicture;
@property (nonatomic, copy)NSString *categoryHot;
@property (nonatomic, copy)NSString *categoryName;
@property (nonatomic, copy)NSString *parentId;
@property (nonatomic, copy)NSArray<NSString *> *urls;
@property (nonatomic, copy)NSString *categoryIcon;
@property (nonatomic, copy)NSArray<NSString *> *urlTypes;
@property (nonatomic, copy)NSString *categoryIconOn;
@property (nonatomic, copy)NSString *lev;
@property (nonatomic, copy)NSString *categoryId;
@property (nonatomic, copy)NSArray<NSString *> *showNames;

/// 三级分类对应的商品列表
@property (nonatomic, strong)LXGoodsInfoListModel *f_goodsList;

@end

NS_ASSUME_NONNULL_END
