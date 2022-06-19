//
//  LXClassifyListPanelRightView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyListPanelRightView.h"

#import "LXMyCollectionView.h"
#import "LXSectionItemCell.h"
#import "LXClassifySectionHeaderView.h"
#import "LXSectionCategoryHeaderView.h"
#import "LXClassifyListBannerCell.h"

static const CGFloat VerticalListCategoryViewHeight = 60.f;   //悬浮categoryView的高度
static const NSUInteger kBannerSectionIdx = 0;
static const CGFloat kBannerSectionHeight = 80.f;
static const NSUInteger VerticalListPinSectionIndex = 1;    //悬浮固定section的index

@interface LXClassifyListPanelRightView()<JXCategoryViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
}
@property (nonatomic, strong)JXCategoryTitleView *pinCategoryView;
@property (nonatomic, strong)LXSectionCategoryHeaderView *sectionCategoryHeaderView;
@property (nonatomic, strong)NSArray<UICollectionViewLayoutAttributes *> *sectionHeaderAttributes;

@property(nonatomic, strong)LXSectionCategoryHeaderView *sectionHeaderView;
@property(nonatomic, strong)LXMyCollectionView *collectionView;
@property(nonatomic, copy)NSArray<LXSectionModel *> *dataList;

@end

@implementation LXClassifyListPanelRightView
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
- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect frame = self.bounds;
    frame.size.height = VerticalListCategoryViewHeight;
    self.pinCategoryView.frame = frame;
}
#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(NSArray<LXSectionModel *> *)dataList {
    self.dataList = dataList;
    self.pinCategoryView.titles = [[dataList.rac_sequence skip:1]
                                   map:^id _Nullable(LXSectionModel * _Nullable value) {
        return value.sectionTitle;
    }].array;
    [self.pinCategoryView reloadDataWithoutListContainer];
    [self.collectionView reloadData];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)updateSectionHeaderAttributes {
    static NSInteger idx = 1;
    if(idx > 1) {
        return;
    }
    idx += 1;
    // if (self.sectionHeaderAttributes) {
    //     return;
    // }
    // //获取到所有的sectionHeaderAtrributes，用于后续的点击，滚动到指定contentOffset.y使用
    // NSMutableArray *attributes = [NSMutableArray array];
    // UICollectionViewLayoutAttributes *lastHeaderAttri = nil;
    // for (int i = 0; i < self.headerTitles.count; i++) {
    //     UICollectionViewLayoutAttributes *attri = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
    //     if (attri) {
    //         [attributes addObject:attri];
    //     }
    //     if (i == self.headerTitles.count - 1) {
    //         lastHeaderAttri = attri;
    //     }
    // }
    // if (attributes.count == 0) {
    //     return;
    // }
    // self.sectionHeaderAttributes = attributes;

    //如果最后一个section条目太少了，会导致滚动最底部，但是却不能触发categoryView选中最后一个item。而且点击最后一个滚动的contentOffset.y也不好弄。所以添加contentInset，让最后一个section滚到最下面能显示完整个屏幕。
    NSInteger lastSection = self.dataList.count - 1;
    NSInteger lastItem = self.dataList[lastSection].itemList.count - 1;
    NSIndexPath *lastHeaderIp = [NSIndexPath indexPathForRow:0 inSection:lastSection];
    NSIndexPath *lastItemIp = [NSIndexPath indexPathForItem:lastItem inSection:lastSection];
    UICollectionViewLayoutAttributes *lastHeaderAttri = [self.collectionView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:lastHeaderIp];
    UICollectionViewLayoutAttributes *lastItemAttri = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:lastItemIp];

    CGFloat lastSectionHeight = CGRectGetMaxY(lastItemAttri.frame) - CGRectGetMinY(lastHeaderAttri.frame);
    CGFloat value = (self.bounds.size.height - VerticalListCategoryViewHeight) - lastSectionHeight;
    if (value > 0) {
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, value, 0);
    }
}

#pragma mark -
#pragma mark - ✈️JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    // UICollectionViewLayoutAttributes *targetAttri = self.sectionHeaderAttributes[index + VerticalListPinSectionIndex];
    // if (index == 0) {
    //     //选中了第一个，特殊处理一下，滚动到sectionHeaer的最上面
    //     [self.collectionView setContentOffset:CGPointMake(0, targetAttri.frame.origin.y) animated:YES];
    // }else {
    //     //不是第一个，需要滚动到categoryView下面
    //     [self.collectionView setContentOffset:CGPointMake(0, targetAttri.frame.origin.y - VerticalListCategoryViewHeight) animated:YES];
    // }
    if((index + VerticalListPinSectionIndex) < self.dataList.count) {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:index + VerticalListPinSectionIndex];
        UICollectionViewLayoutAttributes *attr = [self.collectionView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:ip];
        CGPoint contentOffset = CGPointMake(0, CGRectGetMinY(attr.frame));
        if(index > 0) {
            contentOffset.y -= VerticalListCategoryViewHeight;
        }
        [self.collectionView setContentOffset:contentOffset animated:YES];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.dataList count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == kBannerSectionIdx) {
        return 1;
    }
    return [self.dataList[section].itemList count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        LXClassifyListBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXClassifyListBannerCell" forIndexPath:indexPath];
        return cell;
    }
    LXSectionItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXSectionItemCell" forIndexPath:indexPath];
    LXSectionModel *sectionModel = self.dataList[indexPath.section];
    LXSectionItemModel *itemModel = sectionModel.itemList[indexPath.row];
    [cell dataFill:itemModel];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if(indexPath.section == VerticalListPinSectionIndex) {
            if(!self.sectionCategoryHeaderView) {
            LXSectionCategoryHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LXSectionCategoryHeaderView" forIndexPath:indexPath];
                self.sectionCategoryHeaderView = header;
            }
            if(!self.pinCategoryView.superview) {
                [self.sectionCategoryHeaderView addSubview:self.pinCategoryView];
            }
            return self.sectionCategoryHeaderView;
        } else {
            LXClassifySectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LXClassifySectionHeaderView" forIndexPath:indexPath];
            LXSectionModel *sectionModel = self.dataList[indexPath.section];
            [header dataFill:sectionModel];
            return header;
        }
    }
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    // UIViewController *vc = [[UIViewController alloc]init];
    // vc.view.backgroundColor = [UIColor whiteColor];
    // [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark - ✈️UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth(collectionView.frame);
    if(indexPath.section == kBannerSectionIdx) {
        return CGSizeMake(width, kBannerSectionHeight);
    }
    CGFloat itemWidth = (width - 10 * 4) / 3.f;
    itemWidth = MAX(0, itemWidth);
    itemWidth = floorf(itemWidth);
    return CGSizeMake(itemWidth, itemWidth);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat width = CGRectGetWidth(collectionView.frame);
    if(section == kBannerSectionIdx) {
        return CGSizeZero;
    } else if(section == VerticalListPinSectionIndex) {
        return CGSizeMake(width, VerticalListCategoryViewHeight);
    }
    return CGSizeMake(width, 40.f);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.f;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10.f, 0, 10.f);
}

#pragma mark -
#pragma mark - ✈️UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    // NSLog(@"-->offsetY: %f", offsetY);
    if([scrollView isEqual:self.collectionView]) {
        UICollectionViewLayoutAttributes *attr = [self.collectionView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:VerticalListPinSectionIndex]];
        if(offsetY >= CGRectGetMinY(attr.frame)) {
            if(self.pinCategoryView.superview != self) {
                [self addSubview:self.pinCategoryView];
            }
        } else if(self.pinCategoryView.superview != self.sectionCategoryHeaderView) {
            [self.sectionCategoryHeaderView addSubview:self.pinCategoryView];
        }
        if (self.pinCategoryView.selectedIndex != 0 && scrollView.contentOffset.y == 0) {
            //点击了状态栏滚动到顶部时的处理
            [self.pinCategoryView selectItemAtIndex:0];
        }
        if (!(scrollView.isTracking || scrollView.isDecelerating)) {
            //不是用户滚动的，比如setContentOffset等方法，引起的滚动不需要处理。
            return;
        }
        //用户滚动的才处理
        //获取categoryView下面一点的所有布局信息，用于知道，当前最上方是显示的哪个section
        CGRect topRect = CGRectMake(0, scrollView.contentOffset.y + VerticalListCategoryViewHeight + 1, self.collectionView.bounds.size.width, 1);
        UICollectionViewLayoutAttributes *topAttributes = [self.collectionView.collectionViewLayout layoutAttributesForElementsInRect:topRect].firstObject;
        NSUInteger topSection = topAttributes.indexPath.section;
        if (topAttributes != nil && topSection >= VerticalListPinSectionIndex) {
            if (self.pinCategoryView.selectedIndex != topSection - VerticalListPinSectionIndex) {
                //不相同才切换
                [self.pinCategoryView selectItemAtIndex:topSection - VerticalListPinSectionIndex];
            }
        }
    }
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.collectionView registerClass:[LXSectionItemCell class] forCellWithReuseIdentifier:@"LXSectionItemCell"];
    [self.collectionView registerClass:[LXClassifyListBannerCell class] forCellWithReuseIdentifier:@"LXClassifyListBannerCell"];
    [self.collectionView registerClass:[LXClassifySectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LXClassifySectionHeaderView"];
    [self.collectionView registerClass:[LXSectionCategoryHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LXSectionCategoryHeaderView"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
}
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.collectionView];

    [self masonry];
}
#pragma mark getter/setter
#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (JXCategoryTitleView *)pinCategoryView {
    if(!_pinCategoryView){
        JXCategoryTitleView *v = [[JXCategoryTitleView alloc]init];
        v.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        v.delegate = self;

        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.verticalMargin = 15;
        v.indicators = @[lineView];

        _pinCategoryView = v;
    }
    return _pinCategoryView;
}
- (LXMyCollectionView *)collectionView {
    if(!_collectionView) {//
        CGRect collectFrame = CGRectZero;
        CGSize itemSize = CGSizeZero;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = itemSize;
        flowLayout.estimatedItemSize = itemSize;
        flowLayout.minimumLineSpacing = 0.f;
        flowLayout.minimumInteritemSpacing = 0.f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // flowLayout.sectionHeadersPinToVisibleBounds = YES;
        // flowLayout.sectionFootersPinToVisibleBounds = YES;
        // flowLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#HeaderSectionHeight#>);
        // flowLayout.footerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#FooterSectionHeight#>);
        flowLayout.sectionInset = UIEdgeInsetsZero;

        LXMyCollectionView *cv = [[LXMyCollectionView alloc]initWithFrame:collectFrame collectionViewLayout:flowLayout];
        cv.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        // cv.pagingEnabled = YES;
        cv.delegate = self;
        cv.dataSource = self;

        WEAKSELF(self)
        cv.layoutSubviewsCallback = ^{
            [weakSelf updateSectionHeaderAttributes];
        };

        _collectionView = cv;
    }
    return _collectionView;
}
@end
