//
//  LXPageVC.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "LXSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXPageVC : LXBaseVC<JXCategoryListContentViewDelegate> {
}

- (void)dataFill:(LXCategoryModel *)subCateogryModel;

@end

NS_ASSUME_NONNULL_END