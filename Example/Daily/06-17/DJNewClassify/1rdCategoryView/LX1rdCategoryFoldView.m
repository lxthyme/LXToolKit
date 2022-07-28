//
//  LX1rdCategoryFoldView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/5.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LX1rdCategoryFoldView.h"

#import "LX1rdCategoryCell.h"

@interface LX1rdCategoryFoldView() {
}

@end

@implementation LX1rdCategoryFoldView

#pragma mark - ✈️UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LX1rdCategoryCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LX1rdCategoryCell" forIndexPath:indexPath];
    cell.normalTextColor = self.normalTextColor;
    cell.selectedTextColor = self.selectedTextColor;
    DJO2OCategoryListModel *categoryModel = self.dataList[indexPath.row];
    [cell dataFill:categoryModel];
    return cell;
}

#pragma mark -
#pragma mark - ✈️UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth(collectionView.frame) - kWPercentage(20.f);
    CGFloat itemWidth = floor(width / 5.f);
    return CGSizeMake(itemWidth, kFirstCategoryFoldHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, kWPercentage(20.f), 0, 0);
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.collectionView registerClass:[LX1rdCategoryCell class] forCellWithReuseIdentifier:@"LX1rdCategoryCell"];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.collectionView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.collectionView, self)
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}
@end
