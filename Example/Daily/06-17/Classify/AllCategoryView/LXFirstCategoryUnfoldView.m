//
//  LXFirstCategoryUnfoldView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/4.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXFirstCategoryUnfoldView.h"

#import "LXFirstCategoryUnfoldCell.h"

@interface LXFirstCategoryUnfoldView() {
}
@property(nonatomic, strong)UILabel *labTitle;

@end

@implementation LXFirstCategoryUnfoldView

#pragma mark - ✈️UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXFirstCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXFirstCategoryUnfoldCell" forIndexPath:indexPath];
    cell.normalTextColor = self.normalTextColor;
    cell.selectedTextColor = self.selectedTextColor;
    LXCategoryModel *categoryModel = self.dataList[indexPath.row];
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
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, kWPercentage(5.f), 0, kWPercentage(5.f));
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.collectionView registerClass:[LXFirstCategoryUnfoldCell class] forCellWithReuseIdentifier:@"LXFirstCategoryUnfoldCell"];
}
- (void)prepareUI {
    self.backgroundColor = [UIColor colorWithHex:0xF9F9F9];

    [self addSubview:self.labTitle];
    [self addSubview:self.collectionView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0.f);
        make.left.equalTo(@(kWPercentage(15.f)));
        make.right.equalTo(@(kWPercentage(-15.f)));
        make.height.equalTo(@(kWPercentage(38.5f)));
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"全部分类";
        label.font = [UIFont boldSystemFontOfSize:kWPercentage(13.5f)];
        label.textColor = [UIColor colorWithHex:0x333333];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentLeft;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
@end
