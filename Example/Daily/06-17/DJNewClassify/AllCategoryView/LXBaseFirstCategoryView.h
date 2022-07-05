//
//  LXBaseFirstCategoryView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <LXToolKitObjc/LXBaseView.h>

#import "LXSectionModel.h"

#define kFirstCategoryFoldHeight kWPercentage(67.5f)
#define kFirstCategoryUnfoldHeight kWPercentage(69.5f)

// typedef NS_ENUM(NSInteger, LXFirstCategoryType) {
//     /// 仅一行时的样式
//     LXFirstCategoryTypeFold,
//     /// 展开后的样式
//     LXFirstCategoryTypeUnfold,
// };

NS_ASSUME_NONNULL_BEGIN

@interface LXBaseFirstCategoryView : LXBaseView<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
}
@property(nonatomic, strong, readonly)UICollectionViewFlowLayout *flowLayout;
@property(nonatomic, strong, readonly)UICollectionView *collectionView;
@property(nonatomic, strong, readonly)NSArray<LXCategoryModel *> *dataList;
@property(nonatomic, strong)UIColor *normalTextColor;
@property(nonatomic, strong)UIColor *selectedTextColor;
@property(nonatomic, strong, readonly)NSIndexPath *_Nullable selectedIndexPath;
@property(nonatomic, copy)void (^didSelectRowBlock)(NSInteger idx);

- (void)prepareCollectionView;

- (void)dataFill:(NSArray<LXCategoryModel *> *)categoryList;

- (void)selectItemAtIndex:(NSInteger)idx;

@end

NS_ASSUME_NONNULL_END
