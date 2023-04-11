//
//  DJB2CClassifyWrapperVC.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <DJBusinessTools/LXBaseVC.h>
#import <JXCategoryView/JXCategoryView.h>
#import "DJClassifyVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJB2CClassifyWrapperVC: LXBaseVC<JXCategoryListContentViewDelegate> {
}
@property(nonatomic, strong)DJClassifyVM *b2cVM;
// @property(nonatomic, copy)void (^toggleSkeletonScreenBlock)(BOOL isHidden);

@end

NS_ASSUME_NONNULL_END
