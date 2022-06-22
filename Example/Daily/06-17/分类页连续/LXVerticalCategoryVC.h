//
//  LXVerticalCategoryVC.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/20.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "LXSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXVerticalCategoryVC : LXBaseVC<JXCategoryListContentViewDelegate> {
}

- (void)dataFill:(LXCategoryModel *)subCateogryModel;

@end

NS_ASSUME_NONNULL_END
