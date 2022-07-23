//
//  LXSubCategoryPinView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "LXThirdCategoryView.h"
#import "DJClassifyMacro.h"
#import "LXLHCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXSubCategoryPinView : UIView {
}
@property (nonatomic, strong, readonly)LXThirdCategoryView *pinCategoryView;
@property(nonatomic, copy)void (^toggleShowAll)(UIButton *btn);

- (void)dataFill:(NSArray<LXLHCategoryModel *> *)categoryListModel;

@end

NS_ASSUME_NONNULL_END
