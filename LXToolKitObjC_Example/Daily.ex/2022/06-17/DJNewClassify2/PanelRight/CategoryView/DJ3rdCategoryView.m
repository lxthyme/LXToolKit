//
//  DJ3rdCategoryView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/29.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJ3rdCategoryView.h"

#import "DJ3rdCategoryCell.h"
#import "DJClassifyMacro.h"

@interface DJ3rdCategoryView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
}
@property(nonatomic, strong)NSArray<NSString *> *dataList;
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)UICollectionViewFlowLayout *flowLayout;

@end

@implementation DJ3rdCategoryView
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
#pragma mark - 🌎LoadData
- (void)dataFill:(NSArray<DJClassifyBaseCategoryModel *> *)categoryListModel {
    // self.subCateogryModel = subCateogryModel;
    self.dataList = [categoryListModel.rac_sequence map:^id _Nullable(DJB2CCategoryModel * _Nullable value) {
        return value.categoryName;
    }].array;
    self.collectionView.hidden = NO;
    [self.collectionView reloadData];
    if(self.dataList.count > 0 && self.collectionView.indexPathsForSelectedItems.count <= 0) {
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]
                                          animated:YES
                                    scrollPosition:UICollectionViewScrollPositionTop];
    }
}

#pragma mark -
#pragma mark - 👀Public Actions
- (void)selectItemAtIndex:(NSInteger)idx {
    NSLog(@"subCategory selectItemAtIndex: %ld", idx);
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

- (void)customized1rdCategoryViewStyle {
    self.bgColor = [UIColor colorWithHex:0xF9F9F9];

    self.textBGNormalColor = [UIColor colorWithHex:0xF9F9F9];
    self.textBGSelectedColor = [UIColor colorWithHex:0xF9F9F9];

    self.textNormalColor = [UIColor colorWithHex:0x666666];
    self.textSelectedColor = [UIColor colorWithHex:0xFF774F];

    self.textNormalFont = kPingFangSCMedium(kWPercentage(13.f));
    self.textSelectedFont = kPingFangSCSemibold(kWPercentage(15.f));
}

- (void)customized3rdCategoryViewStyle {
    self.bgColor = [UIColor whiteColor];

    self.textBGNormalColor = [UIColor colorWithHex:0xF6F6F6];
    self.textBGSelectedColor = [UIColor colorWithHex:0xFF774F alpha:0.1];

    self.textNormalColor = [UIColor colorWithHex:0x666666];
    self.textSelectedColor = [UIColor colorWithHex:0xFF774F];

    self.textNormalFont = [UIFont systemFontOfSize:kWPercentage(12.f)];
    self.textSelectedFont = [UIFont systemFontOfSize:kWPercentage(12.f)];

    self.cellCornerRadius = kWPercentage(4.f);
}

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark - ✈️UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DJ3rdCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DJ3rdCategoryCell" forIndexPath:indexPath];
    cell.bgColor = self.bgColor;
    cell.textBGNormalColor = self.textBGNormalColor;
    cell.textBGSelectedColor = self.textBGSelectedColor;
    cell.textNormalColor = self.textNormalColor;
    cell.textSelectedColor = self.textSelectedColor;
    cell.textNormalFont = self.textNormalFont;
    cell.textSelectedFont = self.textSelectedFont;
    cell.contentView.layer.cornerRadius = self.cellCornerRadius;
    [cell dataFill:self.dataList[indexPath.row]];
    return cell;
}
#pragma mark -
#pragma mark - ✈️UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.itemSize;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumInteritemSpacing;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.sectionInset;
}

#pragma mark - ✈️UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self selectItemAtIndex:indexPath.row];
    !self.didSelectRowBlock ?: self.didSelectRowBlock(indexPath.row);
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.collectionView registerClass:[DJ3rdCategoryCell class] forCellWithReuseIdentifier:@"DJ3rdCategoryCell"];
}
- (void)prepareUI {
    [self addSubview:self.collectionView];

    [self masonry];
}
#pragma mark getter / setter
- (void)setBgColor:(UIColor *)bgColor {
    if([_bgColor isEqual:bgColor]) {
        return;
    }
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
    self.collectionView.backgroundColor = bgColor;
}
#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.collectionView)
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}
#pragma mark getter / setter
- (NSInteger)selectedIndex {
    NSIndexPath *ip = self.collectionView.indexPathsForSelectedItems.firstObject;
    if(!ip) {
        return 0;
    }
    return ip.row;
}
#pragma mark Lazy Property
- (UICollectionViewFlowLayout *)flowLayout {
    if(!_flowLayout){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.estimatedItemSize = CGSizeZero;
        flowLayout.itemSize = CGSizeZero;
        flowLayout.minimumLineSpacing = 0.f;
        flowLayout.minimumInteritemSpacing = 0.f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // flowLayout.sectionHeadersPinToVisibleBounds = YES;
        // flowLayout.sectionFootersPinToVisibleBounds = YES;
        // flowLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#HeaderSectionHeight#>);
        // flowLayout.footerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#FooterSectionHeight#>);
        flowLayout.sectionInset = UIEdgeInsetsZero;
        _flowLayout = flowLayout;
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        CGRect collectFrame = CGRectZero;
        UICollectionView *cv = [[UICollectionView alloc]initWithFrame:collectFrame collectionViewLayout:self.flowLayout];
        cv.backgroundColor = [UIColor clearColor];
        cv.showsHorizontalScrollIndicator = NO;
        cv.showsVerticalScrollIndicator = NO;
        // cv.pagingEnabled = YES;
        cv.hidden = YES;

        cv.delegate = self;
        cv.dataSource = self;

        _collectionView = cv;
    }
    return _collectionView;
}
@end
