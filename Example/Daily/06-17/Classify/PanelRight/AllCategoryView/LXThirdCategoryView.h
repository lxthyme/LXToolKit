//
//  LXThirdCategoryView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/29.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "LXSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXThirdCategoryView: UIView {
}
@property(nonatomic, assign)CGSize itemSize;
@property(nonatomic, assign)CGFloat minimumLineSpacing;
@property(nonatomic, assign)CGFloat minimumInteritemSpacing;
@property(nonatomic, assign)UIEdgeInsets sectionInset;
@property(nonatomic, assign)NSInteger selectedIndex;
@property(nonatomic, strong, readonly)UICollectionViewFlowLayout *flowLayout;
@property(nonatomic, copy)void (^didSelectRowBlock)(NSInteger idx);

- (void)dataFill:(LXSubCategoryModel *)subCateogryModel;

- (void)selectItemAtIndex:(NSInteger)idx;

@end

NS_ASSUME_NONNULL_END
