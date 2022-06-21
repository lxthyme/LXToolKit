//
//  LXClassifyListRightView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "LXSectionModel.h"
#import "LXMyCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXClassifyListRightView : UIView {
}
@property (nonatomic, strong, readonly)JXCategoryTitleView *pinCategoryView;
@property(nonatomic, strong, readonly)LXMyCollectionView *collectionView;

- (void)dataFill:(NSArray<LXSectionModel *> *)dataList;

@end

NS_ASSUME_NONNULL_END
