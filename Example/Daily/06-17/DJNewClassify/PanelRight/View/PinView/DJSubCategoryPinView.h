//
//  DJSubCategoryPinView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "DJ3rdCategoryView.h"
#import "DJClassifyMacro.h"
#import "DJClassifyBaseCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJSubCategoryPinView : UIView {
}
/// filter 类型
@property(nonatomic, assign)DJSubcategoryFilterType filterType;
@property(nonatomic, assign)BOOL isJiShiDa;
@property (nonatomic, strong, readonly)DJ3rdCategoryView *pinCategoryView;
@property(nonatomic, copy)void (^toggleShowAll)(UIButton *btn);
@property (nonatomic, copy) void(^layoutSubviewsCallback)(CGRect rect);

- (void)dataFill:(NSArray<DJClassifyBaseCategoryModel *> *)categoryListModel shouldShowJiShiDa:(BOOL)shouldShowJiShiDa;

@end

NS_ASSUME_NONNULL_END
