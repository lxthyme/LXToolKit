//
//  DJ1rdCategoryUnfoldView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/4.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJ1rdCategoryUnfoldView.h"

#import "DJ1rdCategoryUnfoldCell.h"

@interface DJ1rdCategoryUnfoldView() {
}

@end

@implementation DJ1rdCategoryUnfoldView

#pragma mark - ✈️UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DJ1rdCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DJ1rdCategoryUnfoldCell" forIndexPath:indexPath];
    cell.normalTextColor = self.normalTextColor;
    cell.selectedTextColor = self.selectedTextColor;
    DJO2OCategoryListModel *categoryModel = self.dataList[indexPath.row];
    [cell dataFill:categoryModel];
    return cell;
}
#pragma mark -
#pragma mark - ✈️UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth(collectionView.frame) - kWPercentage(5.f) * 2;
    CGFloat itemWidth = floor(width / 5.f);
    return CGSizeMake(itemWidth, kFirstCategoryUnfoldHeight);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kWPercentage(20.f);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, kWPercentage(5.f), 0, kWPercentage(5.f));
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.collectionView registerClass:[DJ1rdCategoryUnfoldCell class] forCellWithReuseIdentifier:@"DJ1rdCategoryUnfoldCell"];
}
- (void)prepareUI {
    self.backgroundColor = [UIColor colorWithHex:0xF9F9F9];

    [self addSubview:self.collectionView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.bottom.equalTo(@(kWPercentage(-10.f)));
    }];
}

#pragma mark Lazy Property
@end
