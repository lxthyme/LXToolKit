//
//  LXAllCategoryView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXAllCategoryView.h"

#import "LXAllCategoryCell.h"

@interface LXAllCategoryView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
}
@property(nonatomic, strong)NSArray<NSString *> *dataList;
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)UICollectionViewFlowLayout *flowLayout;

@end

@implementation LXAllCategoryView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareCollectionView];
        [self prepareUI];
    }
    return self;
}

#pragma mark -
#pragma mark - 👀Public Actions
- (void)selectItemAtIndexPath:(NSIndexPath *)ip {
    UICollectionViewScrollPosition position = UICollectionViewScrollPositionCenteredHorizontally;
    if(self.flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        position = UICollectionViewScrollPositionCenteredVertically;
    }
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
    LXAllCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXAllCategoryCell" forIndexPath:indexPath];
    [cell dataFill];
    return cell;
}
#pragma mark -
#pragma mark - ✈️UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth(collectionView.frame);
    CGFloat itemWidth = floor(width / 5.f);
    return CGSizeMake(itemWidth, 67.5f);
}

#pragma mark - ✈️UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self selectItemAtIndexPath:indexPath];
    !self.didSelectRowBlock ?: self.didSelectRowBlock(indexPath);
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.collectionView registerClass:[LXAllCategoryCell class] forCellWithReuseIdentifier:@"LXAllCategoryCell"];
}
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.collectionView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (NSArray<NSString *> *)dataList {
    if(!_dataList){
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = 0; i < 20; i++) {
            [arr addObject:[NSString stringWithFormat:@"row: %ld", i]];
        }
        _dataList = [arr copy];
    }
    return _dataList;
}
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

        cv.delegate = self;
        cv.dataSource = self;

        _collectionView = cv;
    }
    return _collectionView;
}
@end
