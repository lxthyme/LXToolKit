//
//  DJClassifyListVC.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseVC.h>
#import <JXCategoryView/JXCategoryView.h>
#import "DJClassifyVM.h"
#import "DJClassifyInfoModel.h"
#import "DJClassifyMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJClassifyListVC : LXBaseVC<JXCategoryListContentViewDelegate> {
}
@property(nonatomic, assign)DJClassifyType classifyType;
@property(nonatomic, strong)DJClassifyVM *b2cVM;
// @property(nonatomic, copy)void (^toggleSkeletonScreenBlock)(BOOL isHidden);

- (void)dataFill:(DJClassifyListModel *)cateogryModel;
- (void)dataFillWithBannerInfo:(DJShopResourceModel *)bannerInfo categoryId:(NSString *)categoryId;
- (void)updateGoodItem:(NSString *)categoryId
         goodsInfoList:(NSArray<DJClassifyGoodsInfoModel *> *)goodsInfoList;
- (void)updateGoodItemOnlyAll:(NSString *)categoryId
                goodsInfoList:(NSArray<DJClassifyGoodsInfoModel *> *)goodsInfoList;
- (void)updateGoodItemAllSection:(NSString *)categoryId
                   goodsInfoList:(NSArray<DJClassifyGoodsInfoModel *> *)goodsInfoList;

@end

NS_ASSUME_NONNULL_END
