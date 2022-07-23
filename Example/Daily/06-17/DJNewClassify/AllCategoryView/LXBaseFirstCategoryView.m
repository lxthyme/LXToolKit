//
//  LXBaseFirstCategoryView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseFirstCategoryView.h"

@interface LXBaseFirstCategoryView()<UICollectionViewDelegate> {
}
@property(nonatomic, strong)NSArray<LXLHCategoryModel *> *dataList;
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)UICollectionViewFlowLayout *flowLayout;
@property(nonatomic, strong)NSIndexPath *_Nullable selectedIndexPath;
// @property(nonatomic, assign)LXFirstCategoryType firstCategoryType;
@end

@implementation LXBaseFirstCategoryView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // self.firstCategoryType = firstCategoryType;

        [self prepareCollectionView];
        [self prepareUI];
    }
    return self;
}
// - (void)updateConstraints {
//     [super updateConstraints];
//     if(CGRectGetWidth(self.frame) > 0.f) {
//         [self masonry];
//     }
// }

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(NSArray<LXLHCategoryModel *> *)categoryList {
    self.dataList = categoryList;
    [self.collectionView reloadData];
    if(self.collectionView.indexPathsForSelectedItems.count <= 0) {
        [self selectItemAtIndex:0];
    }
}

#pragma mark -
#pragma mark - 👀Public Actions
- (void)selectItemAtIndex:(NSInteger)idx {
    NSLog(@"topCategory selectItemAtIndex: %ld", idx);
    if(idx >= self.dataList.count) {
        return;
    }
    UICollectionViewScrollPosition position = UICollectionViewScrollPositionCenteredHorizontally;
    if(self.flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        position = UICollectionViewScrollPositionCenteredVertically;
    }
    NSIndexPath *ip = [NSIndexPath indexPathForRow:idx inSection:0];
    [self.collectionView selectItemAtIndexPath:ip animated:YES scrollPosition:position];
    // [self.collectionView scrollToItemAtIndexPath:ip atScrollPosition:position animated:YES];
}

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark - ✈️UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - ✈️UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self selectItemAtIndex:indexPath.row];
    !self.didSelectRowBlock ?: self.didSelectRowBlock(indexPath.row);
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {}
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark Masonry
- (void)masonry {}

#pragma mark getter / setter
- (NSIndexPath *)selectedIndexPath {
    return self.collectionView.indexPathsForSelectedItems.firstObject;
}

#pragma mark Lazy Property
- (UICollectionViewFlowLayout *)flowLayout {
    if(!_flowLayout){
        CGSize itemSize = CGSizeZero;
        UICollectionViewFlowLayout *v = [[UICollectionViewFlowLayout alloc]init];
        v.itemSize = itemSize;
        v.estimatedItemSize = itemSize;
        v.minimumLineSpacing = 0.f;
        v.minimumInteritemSpacing = 0.f;
        v.scrollDirection = UICollectionViewScrollDirectionVertical;
        v.sectionHeadersPinToVisibleBounds = YES;
        // v.sectionFootersPinToVisibleBounds = YES;
        // v.headerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#HeaderSectionHeight#>);
        // v.footerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#FooterSectionHeight#>);
        v.sectionInset = UIEdgeInsetsZero;
        _flowLayout = v;
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        CGRect collectFrame = CGRectZero;
        UICollectionView *cv = [[UICollectionView alloc]initWithFrame:collectFrame collectionViewLayout:self.flowLayout];
        cv.backgroundColor = [UIColor colorWithHex:0xF9F9F9];
        // cv.pagingEnabled = YES;
        cv.showsHorizontalScrollIndicator = NO;
        cv.showsVerticalScrollIndicator = NO;

        cv.delegate = self;
        cv.dataSource = self;

        _collectionView = cv;
    }
    return _collectionView;
}
@end
