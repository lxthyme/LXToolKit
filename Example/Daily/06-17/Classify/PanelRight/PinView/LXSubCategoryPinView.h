//
//  LXSubCategoryPinView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "LXThirdCategoryView.h"
#import "LXSectionModel.h"

#define kPinCategoryViewHeight kWPercentage(44.f)
#define kPinFilterViewHeight kWPercentage(34.f)
#define kPinViewHeight (kPinCategoryViewHeight + kPinFilterViewHeight)

NS_ASSUME_NONNULL_BEGIN

@interface LXSubCategoryPinView : UIView {
}
@property (nonatomic, strong, readonly)LXThirdCategoryView *pinCategoryView;
@property(nonatomic, copy)void (^toggleShowAll)(UIButton *btn);

- (void)dataFill:(LXSubCategoryModel *)subCateogryModel;

@end

NS_ASSUME_NONNULL_END
