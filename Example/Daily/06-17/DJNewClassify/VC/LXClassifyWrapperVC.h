//
//  LXClassifyWrapperVC.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseVC.h>
#import <JXCategoryView/JXCategoryView.h>
#import "LXB2CClassifyVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXClassifyWrapperVC : LXBaseVC<JXCategoryListContentViewDelegate> {
}
@property(nonatomic, strong)LXB2CClassifyVM *b2cVM;
// @property(nonatomic, copy)void (^toggleSkeletonScreenBlock)(BOOL isHidden);

@end

NS_ASSUME_NONNULL_END
