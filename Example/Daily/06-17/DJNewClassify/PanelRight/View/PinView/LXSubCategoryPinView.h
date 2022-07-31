//
//  LXSubCategoryPinView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "LX3rdCategoryView.h"
#import "DJClassifyMacro.h"
#import "LXClassifyBaseCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXSubCategoryPinView : UIView {
}
@property (nonatomic, strong, readonly)LX3rdCategoryView *pinCategoryView;
@property(nonatomic, copy)void (^toggleShowAll)(UIButton *btn);
@property (nonatomic, copy) void(^layoutSubviewsCallback)(CGRect rect);

- (void)dataFill:(NSArray<LXClassifyBaseCategoryModel *> *)categoryListModel shouldShowJiShiDa:(BOOL)shouldShowJiShiDa;

@end

NS_ASSUME_NONNULL_END
