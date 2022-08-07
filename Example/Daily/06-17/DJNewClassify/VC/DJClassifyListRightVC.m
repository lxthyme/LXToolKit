//
//  DJClassifyListRightVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/8/6.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJClassifyListRightVC.h"

#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import <DJBusinessTools/iPhoneX.h>
#import <DJGlobalStoreManager/DJStoreManager.h>

#import "DJClassifyEmptyView.h"
#import "DJClassifyRightSkeletonScreen.h"
#import "DJVerticalTableView.h"
#import "DJClassifyRightCollectionCell.h"
#import "DJClassifySectionHeaderView.h"
#import "DJSectionCategoryHeaderView.h"
#import "DJSubCategoryPinView.h"
#import "DJ3rdCategoryView.h"
#import "DJClassifyListBannerView.h"

@interface DJClassifyListRightVC()<UITableViewDataSource,UITableViewDelegate> {
    UIButton *__btnRotate;
    CGFloat __pinViewHeight;
}
@property(nonatomic, strong)DJClassifyEmptyView *emptyView;
@property (nonatomic, strong)DJClassifyRightSkeletonScreen *skeletonScreen;
@property(nonatomic, strong)DJVerticalTableView *table;
@property (nonatomic, strong)DJSubCategoryPinView *pinView;
@property (nonatomic, strong)UIControl *allMaskView;
@property (nonatomic, strong)DJ3rdCategoryView *allCategoryView;
@property (nonatomic, strong)DJSectionCategoryHeaderView *sectionCategoryHeaderView;
@property (nonatomic, strong)DJClassifyListBannerView *bannerView;
/// 页面状态
@property(nonatomic, assign)DJViewStatus viewStatus;
@property(nonatomic, strong)DJClassifyRightModel *rightModel;
@property(nonatomic, strong)NSArray<DJO2OCategoryListModel *> *t3CategoryList;
@property(nonatomic, assign)CGRect pinCategoryRect;
@property(nonatomic, strong)NSDictionary<NSString *, DJGoodsList *> *allGoodsMap;

@end

@implementation DJClassifyListRightVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.bannerView) {
        [self.bannerView.bannerView adjustWhenControllerViewWillAppera];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    self.viewStatus = DJViewStatusLoading;
    [self prepareUI];
    [self prepareVM];
    [self prepareCollectionView];
    [self bindVM];

    @weakify(self)
    // self.queryCartDisposable = [RACSubject subject];
    [self.b2cVM.shopCartVM.queryCartSubject
      // takeUntil:self.queryCartDisposable]
     // takeUntil:self.queryCartDisposable]
     subscribeNext:^(DJQueryCartModel *x) {
        @strongify(self)
        NSMutableDictionary *allGoodsMap = [NSMutableDictionary dictionary];
        [x.goodsGroupDtoList enumerateObjectsUsingBlock:^(DJGoodsGroupDtoList * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            [obj1.goodsGroupList enumerateObjectsUsingBlock:^(DJGoodsGroupList * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                [obj2.goodsList enumerateObjectsUsingBlock:^(DJGoodsList * _Nonnull obj3, NSUInteger idx3, BOOL * _Nonnull stop3) {
                    allGoodsMap[obj3.goodsId] = obj3;
                }];
            }];
        }];
        self.allGoodsMap = [allGoodsMap copy];
        [self.table reloadData];
    }];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)bindVM {
    @weakify(self)
    [self.b2cVM.searchGoodsDetailsSubject subscribeNext:^(DJO2OCategoryListModel *x) {
        @strongify(self)
        if([self.rightModel.f_t2Category isEqual:x]) {
            [self dataFill:self.rightModel];
        }
        
    }];
    [self.b2cVM.o2oBannerSubject subscribeNext:^(DJO2OCategoryListModel *x) {
        if([self.rightModel.f_t2Category isEqual:x]) {
            [self dataFillWithBannerInfo];
        }
    }];
}
- (void)dataFillWithBannerInfo {
    CGFloat width = SCREEN_WIDTH - kLeftTableWidth;
    if(self.rightModel.f_t2Category.f_bannerResource) {
        NSArray *onlineDeployList = self.rightModel.f_t2Category.f_bannerResource.onlineDeployList;
        if(onlineDeployList.count > 0) {
            self.table.tableHeaderView = nil;
            DJClassifyListBannerView *banner = [[DJClassifyListBannerView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DJClassifyListBannerView"];
            // banner.f_itemType = DJClassifyGoodItemTypeBanner;
            banner.frame = CGRectMake(kWPercentage(10.f), kWPercentage(10.f), width - kWPercentage(10.f * 2), kBannerSectionHeight);
            [banner dataFill:self.rightModel.f_t2Category.f_bannerResource];
            UIView *tableHeaderView = [[UIView alloc]init];
            tableHeaderView.frame = CGRectMake(0, 0, width, kBannerSectionHeight + kWPercentage(10.f));
            [tableHeaderView addSubview:banner];
            self.table.tableHeaderView = tableHeaderView;
        } else if(self.rightModel.f_t2Category.f_bannerResource) {
            UIView *bannerView = [[UIView alloc]init];
            bannerView.frame = CGRectMake(0, 0, width, CGFLOAT_MIN);
            self.table.tableHeaderView = bannerView;
        }
        // [self.table reloadData];
    } else {
        [self.b2cVM loadO2OBannerWith:self.rightModel.f_t2Category];

        UIView *bannerView = [[UIView alloc]init];
        bannerView.frame = CGRectMake(0, 0, width, CGFLOAT_MIN);
        self.table.tableHeaderView = bannerView;
    }
}
- (void)dataFill:(DJClassifyRightModel *)rightModel {
    self.rightModel = rightModel;
    /// 1. banner
    [self dataFillWithBannerInfo];
    /// 2. refresh 状态
    if(rightModel.f_idxType == DJSubCategoryIndexTypeFirst) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.table.mj_header.state = MJRefreshStateNoMoreData;
        });
    } else if(rightModel.f_idxType == DJSubCategoryIndexTypeLast) {
        [self.table.mj_footer endRefreshingWithNoMoreData];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.table.mj_header.state = MJRefreshStateIdle;
        });
    }
    /// 3. 商品数据
    __block BOOL showAll = NO;
    [rightModel.f_t2Category.rywCategorys enumerateObjectsUsingBlock:^(DJO2OCategoryListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.cateType == DJO2OCategoryCateTypeAll) {
            showAll = YES;
            *stop = YES;
            return;
        }
    }];
    rightModel.f_t2Category.f_showAll = showAll;

    NSInteger t3Idx = rightModel.f_pinIdx;
    DJO2OCategoryListModel *t3Category;
    if(rightModel.f_t2Category.rywCategorys.count <= 0 && t3Idx == 0) {
        t3Category = rightModel.f_t2Category.f_t2AllCategory;
    } else if(t3Idx < rightModel.f_t2Category.rywCategorys.count) {
        t3Category = rightModel.f_t2Category.rywCategorys[t3Idx];
    }
    if(t3Category.f_goodsList) {

        CGFloat h = 0.f;
        h += kPinFilterViewHeight;
        // if(rightModel.f_shouldShowBanner) {
        //     h += kBannerSectionHeight;
        // }
        if(self.rightModel.f_t2Category.rywCategorys.count > 0) {
            h += kPinCategoryViewHeight;
        }
        __pinViewHeight = h;
        self.pinView.pinCategoryView.hidden = self.rightModel.f_t2Category.rywCategorys.count <= 0;
        [self.pinView dataFill:self.rightModel.f_t2Category.rywCategorys shouldShowJiShiDa:YES];
        [self.pinView.pinCategoryView selectItemAtIndex:rightModel.f_pinIdx];
        [self.allCategoryView dataFill:self.rightModel.f_t2Category.rywCategorys];

        DJO2OCategoryListModel *pinCategory = [[DJO2OCategoryListModel alloc]init];
        pinCategory.f_categoryType = DJClassifyCategoryTypePinView;
        if(t3Category.cateType == DJO2OCategoryCateTypeAll) {
            self.t3CategoryList = @[pinCategory, rightModel.f_t2Category.f_t2AllCategory];
        } else {
            NSArray *categoryList = [rightModel.f_t2Category.rywCategorys.rac_sequence filter:^BOOL(DJO2OCategoryListModel *value) {
                return value.cateType != DJO2OCategoryCateTypeAll;
            }].array;
            NSMutableArray *tmp = [NSMutableArray array];
            [tmp addObject:pinCategory];
            [tmp addObjectsFromArray:categoryList];
            self.t3CategoryList = [tmp copy];
        }
        __block BOOL isEmpty = YES;
        [self.t3CategoryList enumerateObjectsUsingBlock:^(DJO2OCategoryListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(obj.f_goodsList.count > 0) {
                isEmpty = NO;
                *stop = YES;
                return;
            }
        }];
        self.viewStatus = isEmpty ? DJViewStatusNoData : DJViewStatusNormal;
        [self.table reloadData];

        if(t3Idx == 0) {
            [self.table setContentOffset:CGPointZero animated:YES];
        } else {
            __block BOOL __hadAll = NO;
            [self.rightModel.f_t2Category.rywCategorys enumerateObjectsUsingBlock:^(DJO2OCategoryListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if(obj.cateType == DJO2OCategoryCateTypeAll) {
                    __hadAll = YES;
                    *stop = YES;
                    return;
                }
            }];

            NSInteger realIdx = t3Idx;
            if(!__hadAll && t3Idx >= 0) {
                realIdx += 1;
            }
            if(realIdx < [self.table numberOfSections]) {
                CGRect rect = [self.table rectForSection:realIdx];
                CGPoint offset = CGPointMake(0, CGRectGetMinY(rect));
                offset.y -= __pinViewHeight;
                offset.y = MAX(0, offset.y);
                [self.table setContentOffset:offset animated:YES];
            } else {
                [self.table setContentOffset:CGPointZero animated:YES];
            }
        }
    } else {
        switch (t3Category.cateType) {
            case DJO2OCategoryCateTypeAll: {
                [self.b2cVM loadSearchGoodsDetailsWith:rightModel.f_t2Category
                                                 isAll:YES
                                            filterType:self.pinView.filterType
                                             isJiShiDa:self.pinView.isJiShiDa];
            }
                break;
            case DJO2OCategoryCateTypePromotion: {
                [self.b2cVM loadSearchGoodsDetailsWith:rightModel.f_t2Category
                                                 isAll:NO
                                            filterType:self.pinView.filterType
                                             isJiShiDa:self.pinView.isJiShiDa];
            }
                break;
            case DJO2OCategoryCateTypeNormal: {
                [self.b2cVM loadSearchGoodsDetailsWith:rightModel.f_t2Category
                                                 isAll:NO
                                            filterType:self.pinView.filterType
                                             isJiShiDa:self.pinView.isJiShiDa];
            }
                break;
        }
    }
}
- (void)selectCategoryAtIndex:(NSInteger)idx {
    if(idx < 0 || idx >= self.rightModel.f_t2Category.rywCategorys.count) {
        return;
    }
    self.rightModel.f_pinIdx = idx;
    [self dataFill:self.rightModel];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)dismissAllCategoryViewWithoutAnimation {
    if(self.allMaskView.hidden) {
        return;
    }
    self.allMaskView.hidden = YES;
}
- (void)dismissAllCategoryView {
    if(self.allMaskView.hidden) {
        return;
    }
    self.table.userInteractionEnabled = YES;
    if(__btnRotate) {
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
        anim.toValue = @(0);
        [__btnRotate.imageView.layer pop_addAnimation:anim forKey:@"btnAll.Rotation"];
    }
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
}
- (void)showAllCategoryView {
    if(!self.allMaskView.hidden) {
        [self dismissAllCategoryView];
        return;
    }
    self.table.userInteractionEnabled = NO;
    if(__btnRotate) {
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
        anim.toValue = @(M_PI);
        [__btnRotate.imageView.layer pop_addAnimation:anim forKey:@"btnAll.Rotation"];
    }
    CGRect pinViewFrame = [self.view convertRect:self.pinView.frame fromView:self.pinView];
    CGRect maskFrame = self.allMaskView.frame;
    // maskFrame.origin.y = CGRectGetMaxY(pinViewFrame) - kPinFilterViewHeight;
    // self.allMaskView.frame = maskFrame;
    [self.allMaskView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(CGRectGetMaxY(pinViewFrame) - kPinFilterViewHeight));
        make.left.right.bottom.equalTo(@0.f);
    }];
    NSLog(@"pinViewFrame: %@", NSStringFromCGRect(maskFrame));
    [self.view bringSubviewToFront:self.allMaskView];
    self.allMaskView.hidden = NO;
    POPSpringAnimation *maskAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    maskAnim.fromValue = @0.f;
    maskAnim.toValue = @1.f;
    [self.allMaskView.layer pop_addAnimation:maskAnim forKey:@"allMaskView.opacity"];
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.pinView.frame), 0);
    anim.fromValue = [NSValue valueWithCGRect:frame];
    frame.size.height = 300;
    anim.toValue = [NSValue valueWithCGRect:frame];
    anim.springBounciness = 0.f;
    [self.allCategoryView.layer pop_addAnimation:anim forKey:@"allCategoryView.translation.y"];
}

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.viewStatus == DJViewStatusOffline ||
       self.viewStatus == DJViewStatusNoData) {
        return 1;
    }
    return self.t3CategoryList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.viewStatus == DJViewStatusOffline ||
       self.viewStatus == DJViewStatusNoData) {
        return 1;
    }
    DJO2OCategoryListModel *t3Category = self.t3CategoryList[section];
    return t3Category.f_goodsList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.viewStatus == DJViewStatusOffline ||
       self.viewStatus == DJViewStatusNoData) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        DJClassifyEmptyView *emptyView = [[DJClassifyEmptyView alloc]init];
        [cell addSubview:emptyView];
        if(self.viewStatus == DJViewStatusOffline) {
            [emptyView dataFillOfflineStyle];
        } else if(self.viewStatus == DJViewStatusNoData) {
            [emptyView dataFillEmptyStyle];
        }
        [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0.f);
        }];
        return cell;
    }
    DJClassifyRightCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DJClassifyRightCollectionCell" forIndexPath:indexPath];
    DJO2OCategoryListModel *t3Category = self.t3CategoryList[indexPath.section];
    DJO2OGoodItemModel *goodItem = t3Category.f_goodsList[indexPath.row];
    DJGoodsList *shopItem;
    if(!isEmptyString(goodItem.goodsId)) {
        shopItem = self.allGoodsMap[goodItem.goodsId];
    }
    [cell dataFillWithO2O:goodItem withNum:shopItem.goodsNumber];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.viewStatus == DJViewStatusOffline ||
       self.viewStatus == DJViewStatusNoData) {
        CGFloat h = CGRectGetHeight(tableView.frame);
        h -= __pinViewHeight;
        if(self.rightModel.f_t2Category.f_bannerResource) {
            NSArray *onlineDeployList = self.rightModel.f_t2Category.f_bannerResource.onlineDeployList;
            if(onlineDeployList.count > 0) {
                h -= kBannerSectionHeight + kWPercentage(10.f);
            }
        }
        return MAX(0, h);
    }
    return kT3RightCellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    DJO2OCategoryListModel *t3Category = self.t3CategoryList[section];
    switch (t3Category.f_categoryType) {
        case DJClassifyCategoryTypePinView: {
            return __pinViewHeight;
        }
            break;
        case DJClassifyCategoryTypeSection: {
            if(t3Category.cateType == DJO2OCategoryCateTypeAll) {
                return CGFLOAT_MIN;
            } else {
                return kWPercentage(44.f);
            }
        }
            break;
        case DJClassifyCategoryTypeRepair2rd:
            return CGFLOAT_MIN;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DJO2OCategoryListModel *t3Category = self.t3CategoryList[section];
    switch (t3Category.f_categoryType) {
        case DJClassifyCategoryTypePinView: {
            DJSectionCategoryHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DJSectionCategoryHeaderView"];
            self.sectionCategoryHeaderView = header;
            if(!self.pinView.superview) {
                // 首次使用 DJSectionCategoryHeaderView 的时候，把pinCategoryView添加到它上面。
                self.pinView.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), __pinViewHeight);
                [header addSubview:self.pinView];
            }
            return header;
        }
            break;
        case DJClassifyCategoryTypeSection: {
            if(t3Category.cateType != DJO2OCategoryCateTypeAll) {
                DJClassifySectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DJClassifySectionHeaderView"];
                [header dataFill:t3Category];
                return header;
            }
        }
        case DJClassifyCategoryTypeRepair2rd:break;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.viewStatus == DJViewStatusOffline ||
       self.viewStatus == DJViewStatusNoData) {
        return;
    }
    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    NSDictionary *params = @{
        @"isByShopingCar": @(NO),
        @"goodsId": @""
    };
    DJO2OCategoryListModel *t3Category = self.t3CategoryList[indexPath.section];
    DJO2OGoodItemModel *goodItem = t3Category.f_goodsList[indexPath.row];
    // DJGoodDetailViewController *vc = [[DJGoodDetailViewController alloc]init];
    // vc.params = params;
    // vc.goodsId = itemModel.goodsId;
    // vc.merchantId = gStore.merchantId;
    // vc.shopId = gStore.shopId;
    // vc.shopType = gStore.shopType;
    // vc.districtCode = gStore.districtCode;
    // vc.channelSign = @"";
    // vc.tdType = @"1";
    // [[self topViewController].navigationController pushViewController:vc animated:YES];

}

#pragma mark -
#pragma mark - ✈️UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // CGFloat offsetY = scrollView.contentOffset.y;
    // NSLog(@"-->offsetY: %f", offsetY);
    if(self.viewStatus == DJViewStatusNoData) {
        return;
    }
    CGRect sectionHeaderRect = [self.table rectForHeaderInSection:kPinCategoryViewSectionIndex];
    if (scrollView.contentOffset.y >= sectionHeaderRect.origin.y) {
        //当滚动的contentOffset.y大于了指定sectionHeader的y值，且还没有被添加到self.view上的时候，就需要切换superView
        if (self.pinView.superview != self.view) {
            [self.view addSubview:self.pinView];
        }
    }else if (self.pinView.superview != self.sectionCategoryHeaderView) {
        //当滚动的contentOffset.y小于了指定sectionHeader的y值，且还没有被添加到sectionCategoryHeaderView上的时候，就需要切换superView
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
    if(self.rightModel.f_t2Category.f_showAll && self.rightModel.f_pinIdx == 0) {
        return;
    }
    //用户滚动的才处理
    //获取categoryView下面一点的所有布局信息，用于知道，当前最上方是显示的哪个section
    NSArray<NSIndexPath *>*topIndexPaths = [self.table indexPathsForRowsInRect:CGRectMake(0, scrollView.contentOffset.y + __pinViewHeight + 1, self.table.bounds.size.width, 200)];
    NSIndexPath *topIndexPath = topIndexPaths.firstObject;
    NSUInteger topSection = topIndexPath.section;
    if (topIndexPath != nil && topSection >= kPinCategoryViewSectionIndex) {
        if (self.pinView.pinCategoryView.selectedIndex != topSection - kPinCategoryViewSectionIndex) {
            //不相同才切换
            [self.pinView.pinCategoryView selectItemAtIndex:topSection - kPinCategoryViewSectionIndex];
        }
    }
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.table registerClass:[DJClassifyRightCollectionCell class] forCellReuseIdentifier:@"DJClassifyRightCollectionCell"];
    // [self.table registerClass:[DJClassifyListBannerView class] forCellReuseIdentifier:@"DJClassifyListBannerView"];
    [self.table registerClass:[DJClassifySectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"DJClassifySectionHeaderView"];
    [self.table registerClass:[DJSectionCategoryHeaderView class] forHeaderFooterViewReuseIdentifier:@"DJSectionCategoryHeaderView"];

    WEAKSELF(self)
    MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc]init];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉加载上一个分类" forState:MJRefreshStateIdle];
    [header setTitle:@"松开加载上一个分类" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [header setTitle:@"will refresh" forState:MJRefreshStateWillRefresh];
    [header setTitle:@"已经是第一个分类了" forState:MJRefreshStateNoMoreData];
    header.refreshingBlock = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            !weakSelf.refreshBlock ?: weakSelf.refreshBlock(YES);
            [weakSelf.table.mj_header endRefreshing];
        });
    };
    self.table.mj_header = header;
    MJRefreshBackStateFooter *footer = [[MJRefreshBackStateFooter alloc]init];
    footer.ignoredScrollViewContentInsetBottom = iPhoneX.xl_safeareaInsets.bottom;
    [footer setTitle:@"上拉加载下一个分类" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开加载下一个分类" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"will refresh" forState:MJRefreshStateWillRefresh];
    [footer setTitle:@"已经是最后一个分类了" forState:MJRefreshStateNoMoreData];
    footer.refreshingBlock = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            !weakSelf.refreshBlock ?: weakSelf.refreshBlock(NO);
            [weakSelf.table.mj_footer endRefreshing];
        });
    };
    self.table.mj_footer = footer;
}
- (void)prepareVM {
    @weakify(self)
    [[self.allMaskView rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self dismissAllCategoryView];
    }];
    [[[RACObserve(self.pinView, isJiShiDa)
                distinctUntilChanged]
            throttle:0.1]
    subscribeNext:^(NSNumber *x) {
        @strongify(self)
        if(!self.rightModel) {
            return;
        }
        self.rightModel.f_t2Category.f_t2AllCategory.f_allStatus = DJT3DataLoadedStatusNotYet;
        self.rightModel.f_t2Category.f_t2AllCategory.f_goodsList = nil;
        [self.rightModel.f_t2Category.rywCategorys enumerateObjectsUsingBlock:^(DJO2OCategoryListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.f_notAllStatus = DJT3DataLoadedStatusNotYet;
            obj.f_goodsList = nil;
        }];
        [self dataFill:self.rightModel];
    }];
    [[[RACObserve(self.pinView, filterType)
             distinctUntilChanged]
            throttle:0.1]
    subscribeNext:^(NSNumber *x) {
        @strongify(self)
        if(!self.rightModel) {
            return;
        }
        self.rightModel.f_t2Category.f_t2AllCategory.f_allStatus = DJT3DataLoadedStatusNotYet;
        self.rightModel.f_t2Category.f_t2AllCategory.f_goodsList = nil;
        [self.rightModel.f_t2Category.rywCategorys enumerateObjectsUsingBlock:^(DJO2OCategoryListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.f_notAllStatus = DJT3DataLoadedStatusNotYet;
            obj.f_goodsList = nil;
        }];
        [self dataFill:self.rightModel];
        NSLog(@"-->filterType: %ld", [x integerValue]);
    }];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.table];
    [self.allMaskView addSubview:self.allCategoryView];
    [self.view addSubview:self.allMaskView];
    [self.view addSubview:self.skeletonScreen];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.skeletonScreen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
    [self.allMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
    [self.allCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@200.f);
    }];
}

#pragma mark getter / setter
- (void)setViewStatus:(DJViewStatus)viewStatus {
    if(_viewStatus == viewStatus) {
        return;
    }
    _viewStatus = viewStatus;

    self.emptyView.hidden = YES;
    self.skeletonScreen.hidden = YES;
    switch (viewStatus) {
        case DJViewStatusUnknown:
            break;
        case DJViewStatusNormal:
            break;
        case DJViewStatusLoading:
            self.skeletonScreen.hidden = NO;
            break;
        case DJViewStatusNoData:
            self.emptyView.hidden = NO;
            [self.emptyView dataFillEmptyStyle];
            break;
        case DJViewStatusOffline:
            self.emptyView.hidden = NO;
            [self.emptyView dataFillOfflineStyle];
            break;
    }
}
#pragma mark Lazy Property
- (DJClassifyRightSkeletonScreen *)skeletonScreen {
    if(!_skeletonScreen){
        DJClassifyRightSkeletonScreen *v = [[DJClassifyRightSkeletonScreen alloc]init];
        v.hidden = YES;
        _skeletonScreen = v;
    }
    return _skeletonScreen;
}
- (DJClassifyEmptyView *)emptyView {
    if(!_emptyView){
        DJClassifyEmptyView *v = [[DJClassifyEmptyView alloc]init];
        v.hidden = YES;
        _emptyView = v;
    }
    return _emptyView;
}
- (DJVerticalTableView *)table {
    if(!_table) {
        DJVerticalTableView *t = [[DJVerticalTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        t.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];
        t.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];
        t.backgroundColor = [UIColor colorWithHex:0xF9F9F9];
        t.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        t.indicatorStyle = UIScrollViewIndicatorStyleBlack;
        t.separatorStyle = UITableViewCellSeparatorStyleNone;
        t.estimatedRowHeight = kT3RightCellHeight;
        t.rowHeight = kT3RightCellHeight;
        t.sectionHeaderHeight = 0.f;
        t.sectionFooterHeight = 0.f;
        t.estimatedRowHeight = 0;
        t.estimatedSectionHeaderHeight = 0;
        t.estimatedSectionFooterHeight = 0;
        t.scrollsToTop = YES;

        t.delegate = self;
        t.dataSource = self;

        if (@available(iOS 11.0, *)) {
            t.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if(@available(iOS 13.0, *)) {
            t.automaticallyAdjustsScrollIndicatorInsets = NO;
        }
        if(@available(iOS 15.0, *)) {
            t.sectionHeaderTopPadding = 0.f;
        }
        // WEAKSELF(self)
        // t.layoutSubviewsCallback = ^{
        //     [weakSelf updateSectionHeaderAttributes];
        // };
        _table = t;
    }
    return _table;
}
- (DJSubCategoryPinView *)pinView {
    if(!_pinView){
        DJSubCategoryPinView *v = [[DJSubCategoryPinView alloc]init];
        WEAKSELF(self)
        // v.layoutSubviewsCallback = ^(CGRect rect) {
        //     weakSelf.pinCategoryRect = [weakSelf.view convertRect:weakSelf.pinView.pinCategoryView.frame fromView:weakSelf.pinView.pinCategoryView.superview];
        // };
        v.pinCategoryView.didSelectRowBlock = ^(NSInteger idx) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // if(idx >= 0 && idx < weakSelf.goodsList.count) {
                    [weakSelf.allCategoryView selectItemAtIndex:idx];
                    [weakSelf selectCategoryAtIndex:idx];
                    [weakSelf dismissAllCategoryView];
                // }
            });
        };
        v.toggleShowAll = ^(UIButton * _Nonnull btn) {
            __btnRotate = btn;
            [weakSelf.allCategoryView selectItemAtIndex:weakSelf.pinView.pinCategoryView.selectedIndex];
            [weakSelf showAllCategoryView];
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
- (DJ3rdCategoryView *)allCategoryView {
    if(!_allCategoryView){
        DJ3rdCategoryView *v = [[DJ3rdCategoryView alloc]init];
        [v customized3rdCategoryViewStyle];

        v.minimumLineSpacing = kWPercentage(7.5f);
        v.minimumInteritemSpacing = kWPercentage(7.5f);
        v.sectionInset = UIEdgeInsetsMake(0, kWPercentage(10.f), kWPercentage(15.f), kWPercentage(10.f));
        v.itemSize = CGSizeMake(kWPercentage(68.f), kPinCategoryViewHeight - v.sectionInset.top - v.sectionInset.bottom);
        CGFloat itemWidth = SCREEN_WIDTH - kLeftTableWidth - (v.sectionInset.left + v.sectionInset.right + v.minimumLineSpacing + v.minimumInteritemSpacing);
        itemWidth /= 3.f;
        v.itemSize = CGSizeMake(floorf(itemWidth), kWPercentage(35.f));
        WEAKSELF(self)
        v.didSelectRowBlock = ^(NSInteger idx) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // if(idx >= 0 && idx < weakSelf.goodsList.count) {
                    [weakSelf.pinView.pinCategoryView selectItemAtIndex:idx];
                    [weakSelf selectCategoryAtIndex:idx];
                    [weakSelf dismissAllCategoryView];
                // }
            });
        };
        _allCategoryView = v;
    }
    return _allCategoryView;
}
@end
