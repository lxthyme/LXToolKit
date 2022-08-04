//
//  DJ3rdCategoryView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/29.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseView.h>

#import "DJLHCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJ3rdCategoryView: LXBaseView {
}
@property(nonatomic, assign)CGSize itemSize;
@property(nonatomic, assign)CGFloat minimumLineSpacing;
@property(nonatomic, assign)CGFloat minimumInteritemSpacing;
@property(nonatomic, assign)UIEdgeInsets sectionInset;
@property(nonatomic, strong)UIColor *bgColor;
@property(nonatomic, strong)UIColor *textBGNormalColor;
@property(nonatomic, strong)UIColor *textBGSelectedColor;
@property(nonatomic, strong)UIColor *textNormalColor;
@property(nonatomic, strong)UIColor *textSelectedColor;
@property(nonatomic, strong)UIFont *textNormalFont;
@property(nonatomic, strong)UIFont *textSelectedFont;
@property(nonatomic, assign)CGFloat cellCornerRadius;
@property(nonatomic, assign)NSInteger selectedIndex;
@property(nonatomic, strong, readonly)UICollectionViewFlowLayout *flowLayout;
@property(nonatomic, copy)void (^didSelectRowBlock)(NSInteger idx);

- (void)dataFill:(NSArray<DJClassifyBaseCategoryModel *> *)categoryListModel;

- (void)selectItemAtIndex:(NSInteger)idx;

- (void)customized1rdCategoryViewStyle;
- (void)customized3rdCategoryViewStyle;

@end

NS_ASSUME_NONNULL_END
