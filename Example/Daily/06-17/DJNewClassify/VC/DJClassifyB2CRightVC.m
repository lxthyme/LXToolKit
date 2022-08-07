//
//  DJClassifyB2CRightVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/8/6.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJClassifyB2CRightVC.h"

#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import <DJBusinessTools/iPhoneX.h>
#import <DJGlobalStoreManager/DJStoreManager.h>
#import <BLBusinessCategoryRouterCenter/BLBusinessCategoryRouterCenter.h>

#import "DJClassifyEmptyView.h"
#import "DJClassifyRightSkeletonScreen.h"
#import "DJVerticalTableView.h"
#import "DJClassifyRightCollectionCell.h"
#import "DJClassifySectionHeaderView.h"
#import "DJSectionCategoryHeaderView.h"
#import "DJSubCategoryPinView.h"
#import "DJ3rdCategoryView.h"
#import "DJClassifyListBannerView.h"

@interface DJClassifyB2CRightVC()<UITableViewDataSource,UITableViewDelegate> {
}
@property(nonatomic, strong)DJClassifyEmptyView *emptyView;
@property (nonatomic, strong)DJClassifyRightSkeletonScreen *skeletonScreen;
@property(nonatomic, strong)DJVerticalTableView *table;
@property (nonatomic, strong)DJSubCategoryPinView *pinView;
/// 页面状态
@property(nonatomic, assign)DJViewStatus viewStatus;
@property(nonatomic, strong)DJClassifyRightModel *rightModel;
@property(nonatomic, strong)NSDictionary<NSString *, DJGoodsList *> *allGoodsMap;

@end

@implementation DJClassifyB2CRightVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
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
    [self.b2cVM.v2SearchForLHApiSubject subscribeNext:^(DJB2CCategoryModel *x) {
        @strongify(self)
        if([self.rightModel.f_t2B2CCategory isEqual:x]) {
            [self dataFill:self.rightModel];
        }
    }];
    [self.b2cVM.v2SearchForLHApiErrorSubject subscribeNext:^(CTAPIBaseManager *x) {
        if(self.rightModel.f_t2B2CCategory.f_goodsList.goodsInfoList <= 0) {
            self.viewStatus = DJViewStatusNoData;
            [self.table reloadData];
        }
    }];
}
- (void)dataFill:(DJClassifyRightModel *)rightModel {
    self.rightModel = rightModel;
    /// 1. refresh 状态
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

    if(rightModel.f_t2B2CCategory.f_goodsList) {
        self.pinView.pinCategoryView.hidden = YES;
        [self.pinView dataFill:@[] shouldShowJiShiDa:NO];

        self.viewStatus = (rightModel.f_t2B2CCategory.f_goodsList.goodsInfoList.count <= 0) ? DJViewStatusNoData : DJViewStatusNormal;

        [self.table reloadData];
        [self.table setContentOffset:CGPointZero animated:NO];
    } else {
        [self.b2cVM loadV2SearchForLHApi:rightModel.f_t2B2CCategory filterType:self.pinView.filterType];
    }
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.viewStatus == DJViewStatusOffline ||
       self.viewStatus == DJViewStatusNoData) {
        return 1;
    }
    return self.rightModel.f_t2B2CCategory.f_goodsList.goodsInfoList.count;
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
    DJB2CGoodItemModel *goodItem = self.rightModel.f_t2B2CCategory.f_goodsList.goodsInfoList[indexPath.row];
    WEAKSELF(self)
    cell.addCartBlock = ^{
        [weakSelf.b2cVM.shopCartVM addCartWithB2C:goodItem];
    };
    DJGoodsList *shopItem;
    NSString *goodsId = [NSString stringWithFormat:@"%ld", goodItem.sid];
    if(!isEmptyString(goodsId)) {
        shopItem = self.allGoodsMap[goodsId];
    }
    [cell dataFillWithB2C:goodItem withNum:shopItem.goodsNumber];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.viewStatus == DJViewStatusOffline ||
       self.viewStatus == DJViewStatusNoData) {
        CGFloat h = CGRectGetHeight(tableView.frame);
        h -= kPinFilterViewHeight;
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
    return kPinFilterViewHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DJSectionCategoryHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DJSectionCategoryHeaderView"];
    if(!self.pinView.superview) {
        // 首次使用 DJSectionCategoryHeaderView 的时候，把pinCategoryView添加到它上面。
        self.pinView.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), kPinFilterViewHeight);
        [header addSubview:self.pinView];
    }
    return header;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.viewStatus == DJViewStatusOffline ||
       self.viewStatus == DJViewStatusNoData) {
        return;
    }
    DJB2CGoodItemModel *goodItem = self.rightModel.f_t2B2CCategory.f_goodsList.goodsInfoList[indexPath.row];
    if ([goodItem.type isEqualToString:@"LH"]) {
        NSString *goodId = [NSString stringWithFormat:@"%ld", goodItem.sid];
        [[BLMediator sharedInstance] BLGoodsDetail_goodsDetailViewControllerWithGoodsId:goodId];
    }

}

#pragma mark -
#pragma mark - ✈️UIScrollViewDelegate

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.table registerClass:[DJClassifyRightCollectionCell class] forCellReuseIdentifier:@"DJClassifyRightCollectionCell"];
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
    [[[RACObserve(self.pinView, filterType)
             distinctUntilChanged]
            throttle:0.1]
    subscribeNext:^(NSNumber *x) {
        @strongify(self)
        if(!self.rightModel) {
            return;
        }
        self.rightModel.f_t2B2CCategory.f_loadStatus = DJT3DataLoadedStatusNotYet;
        self.rightModel.f_t2B2CCategory.f_goodsList= nil;
        [self dataFill:self.rightModel];
        NSLog(@"-->filterType: %ld", [x integerValue]);
    }];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.table];
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
        DJVerticalTableView *t = [[DJVerticalTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
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
        _pinView = v;
    }
    return _pinView;
}
@end
