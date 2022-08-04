//
//  LXClassifyListVC.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseVC.h>
#import <JXCategoryView/JXCategoryView.h>
#import "LXB2CClassifyVM.h"
#import "LXClassifyRightVCModel.h"
#import "DJClassifyMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXClassifyListVC : LXBaseVC<JXCategoryListContentViewDelegate> {
}
@property(nonatomic, assign)DJClassifyType classifyType;
@property(nonatomic, strong)LXB2CClassifyVM *b2cVM;
// @property(nonatomic, copy)void (^toggleSkeletonScreenBlock)(BOOL isHidden);

- (void)dataFill:(LXClassifyListModel *)cateogryModel;
- (void)dataFillWithBannerInfo:(LXShopResourceModel *)bannerInfo categoryId:(NSString *)categoryId;
- (void)updateGoodItem:(NSString *)categoryId
         goodsInfoList:(NSArray<LXClassifyGoodsInfoModel *> *)goodsInfoList;
- (void)updateGoodItemOnlyAll:(NSString *)categoryId
                goodsInfoList:(NSArray<LXClassifyGoodsInfoModel *> *)goodsInfoList;
- (void)updateGoodItemAllSection:(NSString *)categoryId
                   goodsInfoList:(NSArray<LXClassifyGoodsInfoModel *> *)goodsInfoList;

@end

NS_ASSUME_NONNULL_END
