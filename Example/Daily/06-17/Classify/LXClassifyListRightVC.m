//
//  LXClassifyListRightVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import "LXClassifyListRightVC.h"

#import "LXClassifyRightCollectionCell.h"
#import "LXClassifySectionHeaderView.h"
#import "LXSectionCategoryHeaderView.h"
#import "LXClassifyListBannerCell.h"
#import "LXMyCollectionView.h"
#import "LXSubCategoryPinView.h"
#import "LXAllCategoryView.h"

static const NSUInteger kBannerSectionIdx = 0;
static const CGFloat kBannerSectionHeight = 80.f;
static const NSUInteger kPinCategoryViewSectionIndex = 1;
#define kPinCategoryViewHeight kWPercentage(44.f)
#define kPinFilterViewHeight kWPercentage(34.f)
#define kPinViewHeight (kPinCategoryViewHeight + kPinFilterViewHeight)

@interface LXClassifyListRightVC ()<JXCategoryViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    BOOL __shouldRest;
}
@property (nonatomic, strong)LXSubCategoryPinView *pinView;
@property (nonatomic, strong)UIControl *allMaskView;
@property (nonatomic, strong)LXAllCategoryView *allCategoryView;
@property (nonatomic, strong)LXSectionCategoryHeaderView *sectionCategoryHeaderView;

@property(nonatomic, strong)LXMyCollectionView *collectionView;
@property(nonatomic, strong)LXSubCategoryModel *subCateogryModel;

@end

@implementation LXClassifyListRightVC
#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareCollectionView];
    [self prepareUI];
    [self prepareVM];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGRect frame = self.view.bounds;
    frame.size.height = kPinViewHeight;
    self.pinView.frame = frame;
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(LXSubCategoryModel *)subCateogryModel {
    self.subCateogryModel = subCateogryModel;
    [self.pinView dataFill:subCateogryModel];
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointZero animated:YES];

    [self.collectionView.mj_footer resetNoMoreData];

    BOOL isFirst = subCateogryModel.idxType == LXSubCategoryIndexTypeFirst;
    MJRefreshDispatchAsyncOnMainQueue(self.collectionView.mj_header.state = isFirst ? MJRefreshStateNoMoreData : MJRefreshStateIdle;)
    if(subCateogryModel.idxType == LXSubCategoryIndexTypeLast) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }

    __shouldRest = YES;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)updateSectionHeaderAttributes {
    // if(!__shouldRest) {
    //     return;
    // }
    // __shouldRest = NO;
    //
    // //如果最后一个section条目太少了，会导致滚动最底部，但是却不能触发categoryView选中最后一个item。而且点击最后一个滚动的contentOffset.y也不好弄。所以添加contentInset，让最后一个section滚到最下面能显示完整个屏幕。
    // NSInteger lastSection = self.subCateogryModel.sectionList.count - 1;
    // NSInteger lastItem = self.subCateogryModel.sectionList[lastSection].itemList.count - 1;
    // NSIndexPath *lastHeaderIp = [NSIndexPath indexPathForRow:0 inSection:lastSection];
    // NSIndexPath *lastItemIp = [NSIndexPath indexPathForItem:lastItem inSection:lastSection];
    // UICollectionViewLayoutAttributes *lastHeaderAttri = [self.collectionView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:lastHeaderIp];
    // UICollectionViewLayoutAttributes *lastItemAttri = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:lastItemIp];
    //
    // CGFloat lastSectionHeight = CGRectGetMaxY(lastItemAttri.frame) - CGRectGetMinY(lastHeaderAttri.frame);
    // CGFloat value = (self.view.bounds.size.height - kPinViewHeight) - lastSectionHeight;
    // if (value > 0) {
    //     self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, value, 0);
    // }
}

#pragma mark -
#pragma mark - ✈️JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self scrollTo:index];
}
- (void)scrollTo:(NSInteger)index {
    NSInteger realIdx = index + kPinCategoryViewSectionIndex;
    if(realIdx < self.subCateogryModel.sectionList.count &&
       realIdx < [self.collectionView numberOfSections] &&
       [self.collectionView numberOfItemsInSection:realIdx] > 0) {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:realIdx];
        UICollectionViewLayoutAttributes *attr = [self.collectionView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:ip];
        CGPoint contentOffset = CGPointMake(0, CGRectGetMinY(attr.frame));
        if(index > 0) {
            contentOffset.y -= kPinViewHeight;
        }
        [self.collectionView setContentOffset:contentOffset animated:YES];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.subCateogryModel.sectionList.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == kBannerSectionIdx) {
        return 1;
    }
    return self.subCateogryModel.sectionList[section].itemList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        LXClassifyListBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXClassifyListBannerCell" forIndexPath:indexPath];
        return cell;
    }
    LXClassifyRightCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXClassifyRightCollectionCell" forIndexPath:indexPath];
    LXSectionModel *sectionModel = self.subCateogryModel.sectionList[indexPath.section];
    LXSectionItemModel *itemModel = sectionModel.itemList[indexPath.row];
    [cell dataFill:itemModel];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if(indexPath.section == kPinCategoryViewSectionIndex) {
            if(!self.sectionCategoryHeaderView) {
            LXSectionCategoryHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LXSectionCategoryHeaderView" forIndexPath:indexPath];
                self.sectionCategoryHeaderView = header;
            }
            if(!self.pinView.superview) {
                [self.sectionCategoryHeaderView addSubview:self.pinView];
            }
            return self.sectionCategoryHeaderView;
        } else {
            LXClassifySectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LXClassifySectionHeaderView" forIndexPath:indexPath];
            LXSectionModel *sectionModel = self.subCateogryModel.sectionList[indexPath.section];
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
        return CGSizeMake(width - 10.f * 2, kBannerSectionHeight);
    }
    CGFloat itemWidth = (width - 10 * 4) / 3.f;
    itemWidth = MAX(CGFLOAT_MIN, itemWidth);
    itemWidth = floorf(itemWidth);
    return CGSizeMake(itemWidth, itemWidth);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat width = CGRectGetWidth(collectionView.frame);
    if(section == kBannerSectionIdx) {
        return CGSizeZero;
    } else if(section == kPinCategoryViewSectionIndex) {
        return CGSizeMake(width, kPinViewHeight);
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
    if([scrollView isEqual:self.collectionView] && [self.collectionView numberOfSections] > 1) {
        UICollectionViewLayoutAttributes *attr = [self.collectionView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:kPinCategoryViewSectionIndex]];
        if(offsetY >= CGRectGetMinY(attr.frame)) {
            if(self.pinView.superview != self.view) {
                [self.view addSubview:self.pinView];
            }
        } else if(self.pinView.superview != self.sectionCategoryHeaderView) {
            [self.sectionCategoryHeaderView addSubview:self.pinView];
        }
        if (self.pinView.pinCategoryView.selectedIndex != 0 && scrollView.contentOffset.y == 0) {
            //点击了状态栏滚动到顶部时的处理
            [self.pinView.pinCategoryView selectItemAtIndex:0];
        }
        if (!(scrollView.isTracking || scrollView.isDecelerating)) {
            //不是用户滚动的，比如setContentOffset等方法，引起的滚动不需要处理。
            return;
        }
        //用户滚动的才处理
        //获取categoryView下面一点的所有布局信息，用于知道，当前最上方是显示的哪个section
        CGRect topRect = CGRectMake(0, scrollView.contentOffset.y + kPinViewHeight + 1, self.collectionView.bounds.size.width, 1);
        UICollectionViewLayoutAttributes *topAttributes = [self.collectionView.collectionViewLayout layoutAttributesForElementsInRect:topRect].firstObject;
        NSUInteger topSection = topAttributes.indexPath.section;
        if (topAttributes != nil && topSection >= kPinCategoryViewSectionIndex) {
            if (self.pinView.pinCategoryView.selectedIndex != topSection - kPinCategoryViewSectionIndex) {
                //不相同才切换
                [self.pinView.pinCategoryView selectItemAtIndex:topSection - kPinCategoryViewSectionIndex];
            }
        }
    }
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.collectionView registerClass:[LXClassifyRightCollectionCell class] forCellWithReuseIdentifier:@"LXClassifyRightCollectionCell"];
    [self.collectionView registerClass:[LXClassifyListBannerCell class] forCellWithReuseIdentifier:@"LXClassifyListBannerCell"];
    [self.collectionView registerClass:[LXClassifySectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LXClassifySectionHeaderView"];
    [self.collectionView registerClass:[LXSectionCategoryHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LXSectionCategoryHeaderView"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];

    WEAKSELF(self)
    MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc]init];
    [header setTitle:@"下拉加载上一个分类" forState:MJRefreshStateIdle];
    [header setTitle:@"松开加载上一个分类" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [header setTitle:@"will refresh" forState:MJRefreshStateWillRefresh];
    [header setTitle:@"已经是第一个分类了" forState:MJRefreshStateNoMoreData];
    header.refreshingBlock = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            !weakSelf.refreshBlock ?: weakSelf.refreshBlock(YES);
            [weakSelf.collectionView.mj_header endRefreshing];
        });
    };
    self.collectionView.mj_header = header;
    MJRefreshBackStateFooter *footer = [[MJRefreshBackStateFooter alloc]init];
    [footer setTitle:@"上拉加载下一个分类" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开加载下一个分类" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"will refresh" forState:MJRefreshStateWillRefresh];
    [footer setTitle:@"已经是最后一个分类了" forState:MJRefreshStateNoMoreData];
    footer.refreshingBlock = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            !weakSelf.refreshBlock ?: weakSelf.refreshBlock(NO);
            [weakSelf.collectionView.mj_footer endRefreshing];
        });
    };
    self.collectionView.mj_footer = footer;
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.collectionView];
    [self.allMaskView addSubview:self.allCategoryView];
    [self.view addSubview:self.allMaskView];

    [self masonry];
}
- (void)prepareVM {
    @weakify(self)
    [[self.allMaskView rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        self.allMaskView.hidden = NO;
        POPSpringAnimation *maskAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        maskAnim.fromValue = @1.f;
        maskAnim.toValue = @0.f;
        [self.allMaskView.layer pop_addAnimation:maskAnim forKey:@"allMaskView.opacity"];
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.pinView.frame), 300.f);
        anim.fromValue = [NSValue valueWithCGRect:frame];
        frame.size.height = 0.f;
        anim.toValue = [NSValue valueWithCGRect:frame];
        anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
            self.allMaskView.hidden = YES;
        };
        [self.allCategoryView.layer pop_addAnimation:anim forKey:@"allCategoryView.translation.y"];


    }];
}
#pragma mark getter/setter
#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(...)
    [self.allMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kBannerSectionHeight + kPinCategoryViewHeight));
        make.left.right.bottom.equalTo(@0.f);
    }];
    [self.allCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@200.f);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (LXSubCategoryPinView *)pinView {
    if(!_pinView){
        LXSubCategoryPinView *v = [[LXSubCategoryPinView alloc]init];
        v.pinCategoryView.delegate = self;
        WEAKSELF(self)
        v.toggleShowAll = ^{
            if(weakSelf.allMaskView.hidden != YES) {
                return;
            }
            weakSelf.allMaskView.hidden = NO;
            POPSpringAnimation *maskAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
            maskAnim.fromValue = @0.f;
            maskAnim.toValue = @1.f;
            [weakSelf.allMaskView.layer pop_addAnimation:maskAnim forKey:@"allMaskView.opacity"];
            POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
            CGRect frame = CGRectMake(0, 0, CGRectGetWidth(weakSelf.pinView.frame), 0);
            anim.fromValue = [NSValue valueWithCGRect:frame];
            frame.size.height = 300;
            anim.toValue = [NSValue valueWithCGRect:frame];
            anim.springBounciness = 0.f;
            [weakSelf.allCategoryView.layer pop_addAnimation:anim forKey:@"allCategoryView.translation.y"];
        };
        _pinView = v;
    }
    return _pinView;
}
- (UIControl *)allMaskView {
    if(!_allMaskView){
        UIControl *v = [[UIControl alloc]init];
        v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        v.hidden = YES;
        _allMaskView = v;
    }
    return _allMaskView;
}
- (LXAllCategoryView *)allCategoryView {
    if(!_allCategoryView){
        LXAllCategoryView *v = [[LXAllCategoryView alloc]init];
        WEAKSELF(self)
        v.didSelectRowBlock = ^(NSIndexPath *ip) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // [weakSelf.pinCategoryView selectItemAtIndexPath:ip];
                // [weakSelf.listContainerView didClickSelectedItemAtIndex:ip.row];
                // [weakSelf.listContainerView.contentScrollView setContentOffset:CGPointMake(ip.row * weakSelf.listContainerView.contentScrollView.bounds.size.width, 0) animated:YES];
            });
        };
        _allCategoryView = v;
    }
    return _allCategoryView;
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
