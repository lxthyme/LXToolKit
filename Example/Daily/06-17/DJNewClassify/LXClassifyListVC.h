//
//  LXClassifyListVC.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseVC.h>
#import <JXCategoryView/JXCategoryView.h>

#import "LXClassifyRightVCModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXClassifyListVC : LXBaseVC<JXCategoryListContentViewDelegate> {
}
@property(nonatomic, copy)void (^toggleSkeletonScreenBlock)(BOOL isHidden);

- (void)dataFill:(LXClassifyListModel *)cateogryModel;

@end

NS_ASSUME_NONNULL_END
