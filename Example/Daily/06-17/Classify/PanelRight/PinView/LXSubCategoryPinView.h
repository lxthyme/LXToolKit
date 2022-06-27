//
//  LXSubCategoryPinView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "JXCategoryTitleBackgroundView.h"
#import "LXSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXSubCategoryPinView : UIView {
}
@property (nonatomic, strong, readonly)JXCategoryTitleBackgroundView *pinCategoryView;
@property(nonatomic, copy)void (^toggleShowAll)(void);

- (void)dataFill:(LXSubCategoryModel *)subCateogryModel;

@end

NS_ASSUME_NONNULL_END
