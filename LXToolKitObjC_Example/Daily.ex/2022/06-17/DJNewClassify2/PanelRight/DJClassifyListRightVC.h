//
//  DJClassifyListRightVC.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/7/30.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseVC.h>

#import "DJClassifyMacro.h"
#import "DJClassifyInfoModel.h"
#import "DJClassifyMacro.h"
#import "DJClassifyVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJClassifyListRightVC: LXBaseVC {
}
@property(nonatomic, assign)DJClassifyType classifyType;
@property(nonatomic, strong)DJClassifyVM *b2cVM;
@property(nonatomic, copy)void (^refreshBlock)(BOOL isRefresh);

- (void)dataFillWithBannerInfo:(DJShopResourceModel *)bannerInfo;
- (void)dataFill:(DJClassifyRightModel *)rightModel
         showAll:(BOOL)showAll;

- (void)dismissAllCategoryView;

@end

NS_ASSUME_NONNULL_END
