//
//  LXClassifyListRightVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/30.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyListRightVC.h"

#import <JXCategoryView/JXCategoryView.h>
#import <pop/POP.h>
#import <MJRefresh/MJRefresh.h>
#import <DJBusinessTools/iPhoneX.h>

#import "LXClassifyRightCollectionCell.h"
#import "LXClassifySectionHeaderView.h"
#import "LXSectionCategoryHeaderView.h"
#import "LXClassifyListBannerCell.h"
#import "LXMyCollectionView.h"
#import "LXSubCategoryPinView.h"
#import "LX3rdCategoryView.h"
#import "DJClassifyMacro.h"
#import "LXClassifyRightSkeletonScreen.h"
#import "LXClassifyEmptyView.h"
#import "LXVerticalTableView.h"

@interface LXClassifyListRightVC()<JXCategoryViewDelegate, UITableViewDataSource,UITableViewDelegate> {
    // BOOL __shouldRest;
    UIButton *__btnRotate;
    CGFloat __pinViewHeight;
}
@property (nonatomic, strong)LXSubCategoryPinView *pinView;
@property (nonatomic, strong)UIControl *allMaskView;
@property (nonatomic, strong)LX3rdCategoryView *allCategoryView;
@property (nonatomic, strong)LXSectionCategoryHeaderView *sectionCategoryHeaderView;
@property(nonatomic, strong)LXClassifyEmptyView *emptyView;
@property (nonatomic, strong)LXClassifyRightSkeletonScreen *skeletonScreen;
/// 页面状态
@property(nonatomic, assign)LXViewStatus viewStatus;
@property(nonatomic, strong)LXMyCollectionView *collectionView;
@property(nonatomic, strong)LXVerticalTableView *table;
@property(nonatomic, strong)LXClassifyRightModel *rightModel;
@property(nonatomic, strong)NSArray<LXClassifyGoodsInfoModel *> *goodsList;
/// <#label#>
@property(nonatomic, assign)BOOL isAll;
@property (nonatomic, strong) NSArray <NSValue *> *sectionHeaderRectArray;
/// <#label#>
@property(nonatomic, assign)CGRect pinCategoryRect;

@end

@implementation LXClassifyListRightVC
#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.
    [self prepareCollectionView];
    [self prepareUI];
    [self prepareVM];
    [self bindVM];
    self.viewStatus = LXViewStatusLoading;
}
// - (void)viewDidLayoutSubviews {
//     [super viewDidLayoutSubviews];
//
//     CGRect frame = self.view.bounds;
//     frame.size.height = __pinViewHeight;
//     self.pinView.frame = frame;
// }
#pragma mark -
#pragma mark - 🌎LoadData
- (void)bindVM {
    [self.b2cVM.searchGoodsDetailsErrorSubject subscribeNext:^(CTAPIBaseManager *apiManager) {
        self.viewStatus = LXViewStatusNoData;
        NSLog(@"searchGoodsDetailsErrorSubject: %@", apiManager);
    }];
    [self.b2cVM.v2SearchForLHApiErrorSubject subscribeNext:^(CTAPIBaseManager *apiManager) {
        self.viewStatus = LXViewStatusNoData;
        NSLog(@"v2SearchForLHApiErrorSubject: %@", apiManager);
    }];
}
- (void)dataFill:(LXClassifyRightModel *)rightModel showAll:(BOOL)showAll {
    self.rightModel = rightModel;
    [self.pinView dataFill:rightModel.f_categorys shouldShowJiShiDa:rightModel.f_shouldShowJiShiDa];
    [self.allCategoryView dataFill:rightModel.f_categorys];

    CGFloat h = 0.f;
    h += kPinFilterViewHeight;
    // if(rightModel.f_shouldShowBanner) {
    //     h += kBannerSectionHeight;
    // }
    if(rightModel.f_categorys.count > 0) {
        h += kPinCategoryViewHeight;
    }
    __pinViewHeight = h;

    [self formatGoodsList:showAll];
}
- (void)formatGoodsList:(BOOL)showAll {
    BOOL __shouldRefresh = NO;
    NSMutableArray *goodsList = [NSMutableArray array];
    if(self.classifyType == DJClassifyTypeB2C) {
        self.table.tableHeaderView = [[UIView alloc]init];
        __shouldRefresh = YES;
        [goodsList addObject:self.rightModel.f_goodsInfoModel];
    } else if(self.classifyType == DJClassifyTypeO2O) {
        if(self.rightModel.f_shouldShowBanner) {
            LXClassifyListBannerCell *banner = [[LXClassifyListBannerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LXClassifyListBannerCell"];
            // banner.f_itemType = LXClassifyGoodItemTypeBanner;
            banner.frame = CGRectMake(0, 0, CGRectGetWidth(self.table.frame), kBannerSectionHeight);
            self.table.tableHeaderView = banner;

            // self.pinView.frame = CGRectMake(0, 0, SCREEN_WIDTH - kLeftTableWidth, __pinViewHeight);
            // self.table.tableHeaderView = self.pinView;
        } else {
            self.table.tableHeaderView = [[UIView alloc]init];
        }
        if(self.rightModel.f_categorys.count > 0) {
            LXClassifyGoodsInfoModel *goodsInfoModel = [[LXClassifyGoodsInfoModel alloc]init];
            goodsInfoModel.f_itemType = LXClassifyGoodItemTypePinCategoryView;
            [goodsList addObject:goodsInfoModel];
        }
        if(showAll && self.rightModel.f_showAll) {
            if(self.rightModel.f_goodsInfoModel) {
                NSLog(@"-->1. 切换到\"全部\"模式");
                self.isAll = YES;
                __shouldRefresh = YES;
                [goodsList addObject:self.rightModel.f_goodsInfoModel];
            } else {
                NSLog(@"-->1.1 开始请求 \"全部\" 数据");
                DJO2OCategoryListModel *t2rdCategory = self.rightModel.f_o2oCategoryModel;
                [self.b2cVM loadSearchGoodsDetailsWith:self.rightModel.f_2rdCategoryId
                                            endCateIds:t2rdCategory.endCateIds
                                                 isAll:NO];
            }
        } else {
            if(self.rightModel.f_o2oGoodsInfoList) {
                self.isAll = NO;
                __shouldRefresh = YES;
                [goodsList addObjectsFromArray:self.rightModel.f_o2oGoodsInfoList];
                NSLog(@"-->2. 切换到\"分类\"模式");
            } else {
                NSLog(@"-->1.1 开始请求 \"分类\" 数据");
                DJO2OCategoryListModel *t2rdCategory = self.rightModel.f_o2oCategoryModel;
                [self.b2cVM loadSearchGoodsDetailsWith:self.rightModel.f_2rdCategoryId
                                            endCateIds:t2rdCategory.endCateIds
                                                 isAll:NO];
            }
        }
    }
    if(__shouldRefresh) {
        self.goodsList = [goodsList copy];
        __block BOOL __isEmpty = YES;
        [self.goodsList enumerateObjectsUsingBlock:^(LXClassifyGoodsInfoModel * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            switch (obj1.f_itemType) {
                case LXClassifyGoodItemTypeO2O: {
                    [obj1.f_o2oGoodsInfo.f_goodsList enumerateObjectsUsingBlock:^(LXO2OGoodItemModel * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                        if(obj2.f_itemType == LXClassifyGoodItemTypeO2O) {
                            __isEmpty = NO;
                            *stop2 = YES;
                            return;
                        }
                    }];
                    if(!__isEmpty) {
                        *stop1 = YES;
                        return;
                    }
                }
                case LXClassifyGoodItemTypeB2C: {
                    if(obj1.f_b2CGoodsListModel.goodsInfoList.count > 0) {
                        __isEmpty = NO;
                        *stop1 = YES;
                        return;
                    }
                }
                case LXClassifyGoodItemTypePinCategoryView:
                case LXClassifyGoodItemTypeEmpty:
                    break;
            }
        }];
        if(__isEmpty) {
            self.viewStatus = LXViewStatusNoData;
        } else {
            self.viewStatus = LXViewStatusNormal;
        }

        [self.table reloadData];
        // __shouldRest = YES;
        if(self.rightModel.f_showAll) {
            if(showAll) {
                /// 此时展示的是"全部"数据
                [self.table setContentOffset:CGPointZero animated:YES];
                [self.pinView.pinCategoryView selectItemAtIndex:0];
            } else {
                /// 此时有"全部", 但是要展示的是分类数据
                // [self.table selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] animated:YES scrollPosition:UITableViewScrollPositionTop];
                CGRect sectionRect = [self.table rectForSection:1];
                CGPoint offset = CGPointMake(0, CGRectGetMinY(sectionRect) - __pinViewHeight);
                offset.y = MIN(offset.y, self.table.contentSize.height - CGRectGetHeight(self.table.frame));
                [self.table setContentOffset:offset animated:YES];
                [self.pinView.pinCategoryView selectItemAtIndex:1];
            }
        } else {
            [self.table setContentOffset:CGPointZero animated:YES];
            [self.pinView.pinCategoryView selectItemAtIndex:0];
        }

        [self.table.mj_footer resetNoMoreData];

        // TODO: 「lxthyme」💊
        // MJRefreshDispatchAsyncOnMainQueue(self.table.mj_header.state = isFirst ? MJRefreshStateNoMoreData : MJRefreshStateIdle;)
        if(self.rightModel.f_idxType == LXSubCategoryIndexTypeFirst) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.table.mj_header.state = MJRefreshStateNoMoreData;
            });
        } else if(self.rightModel.f_idxType == LXSubCategoryIndexTypeLast) {
            [self.table.mj_footer endRefreshingWithNoMoreData];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.table.mj_header.state = MJRefreshStateIdle;
            });
        }

        // __shouldRest = YES;
    }
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)selectItemAtIndex:(NSInteger)idx {
    if(idx == 0 &&
       self.rightModel.f_showAll &&
       !self.isAll) {
        [self formatGoodsList:YES];
    } else if(idx != 0 &&
              self.isAll){
        [self formatGoodsList:NO];
    }
    NSInteger realIdx = idx;
    if(self.classifyType == DJClassifyTypeO2O && !self.rightModel.f_showAll) {
        realIdx += 1;
    }
    if(realIdx >= 0 &&
       realIdx < self.goodsList.count &&
       realIdx < [self.table numberOfSections]) {
        // NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:realIdx];
        // if(ip.section < [self.table numberOfSections] &&
        //    ip.row < [self.table numberOfRowsInSection:ip.section]) {
            // [self.table selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionTop];
            CGRect sectionRect = [self.table rectForSection:realIdx];
            CGPoint offset = CGPointMake(0, CGRectGetMinY(sectionRect) - __pinViewHeight);
            offset.y = MIN(offset.y, self.table.contentSize.height - CGRectGetHeight(self.table.frame));
            [self.table setContentOffset:offset animated:YES];
        } else {
            NSLog(@"-->3. ip invalid: (%ld)", realIdx);
        }
    // }
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
- (void)updateSectionHeaderAttributes {
    // if(!__shouldRest) {
    //     return;
    // }
    // __shouldRest = NO;
    if(self.classifyType == DJClassifyTypeO2O && self.rightModel.f_categorys.count > 0) {
        //获取到所有的sectionHeaderRect，用于后续的点击，滚动到指定contentOffset.y使用
        NSMutableArray *rects = [NSMutableArray array];
        CGRect lastHeaderRect = CGRectZero;
        for (int i = 0; i < self.goodsList.count; i++) {
            CGRect rect = [self.table rectForHeaderInSection:i];
            [rects addObject:[NSValue valueWithCGRect:rect]];
            if (i == self.goodsList.count - 1) {
                lastHeaderRect = rect;
            }
        }
        if (rects.count == 0) {
            return;
        }
        self.sectionHeaderRectArray = rects;

        //如果最后一个section条目太少了，会导致滚动最底部，但是却不能触发categoryView选中最后一个item。而且点击最后一个滚动的contentOffset.y也不好弄。所以添加contentInset，让最后一个section滚到最下面能显示完整个屏幕。
        NSInteger lastSection = 0, lastRow = 0;
        switch (self.classifyType) {
            case DJClassifyTypeO2O: {
                if(self.goodsList.count > 0) {
                    lastSection = self.goodsList.count - 1;
                    DJGoodsIdsModel *o2oItem = self.goodsList.lastObject.f_o2oGoodsInfo;
                    if(o2oItem.f_goodsList.count > 0) {
                        lastRow = o2oItem.f_goodsList.count - 1;
                    }
                }
            }
                break;
            case DJClassifyTypeB2C: {
                if(self.goodsList.count > 0) {
                    lastSection = self.goodsList.count - 1;
                    LXB2CGoodsItemListModel *b2cItem = self.goodsList.lastObject.f_b2CGoodsListModel;
                    if(b2cItem.goodsInfoList.count > 0) {
                        lastRow = b2cItem.goodsInfoList.count - 1;
                    }
                }
            }
                break;
        }
        // NSIndexPath *lastIndexPath = nil;
        // if(lastSection >= 0 && lastRow >= 0) {
        //     lastIndexPath = [NSIndexPath indexPathForRow:lastRow inSection:lastSection];
        // }
        // if(lastIndexPath && lastIndexPath.section < [self.table numberOfSections] &&
        //    lastIndexPath.row < [self.table numberOfRowsInSection:lastIndexPath.section]) {
        //     CGRect lastCellRect = [self.table rectForRowAtIndexPath:lastIndexPath];
        //     CGFloat lastSectionHeight = CGRectGetMaxY(lastCellRect) - CGRectGetMinY(lastHeaderRect);
        //     CGFloat value = (self.view.bounds.size.height - __pinViewHeight) - lastSectionHeight;
        //     if (value > 0) {
        //         self.table.contentInset = UIEdgeInsetsMake(0, 0, value, 0);
        //     }
        // }
    }
}

#pragma mark -
#pragma mark - ✈️JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self scrollTo:index];
}
- (void)scrollTo:(NSInteger)index {
    NSInteger realIdx = index + kPinCategoryViewSectionIndex;
    if(realIdx < self.goodsList.count &&
       realIdx < [self.table numberOfSections] &&
       [self.table numberOfRowsInSection:realIdx] > 0) {
        CGRect sectionRect = [self.table rectForSection:realIdx];
        CGPoint contentOffset = CGPointMake(0, CGRectGetMinY(sectionRect));
        [self.table setContentOffset:contentOffset animated:YES];
        [self.allCategoryView selectItemAtIndex:index];
    }
}

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.goodsList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LXClassifyGoodsInfoModel *goodsInfo = self.goodsList[section];
    switch (goodsInfo.f_itemType) {
        case LXClassifyGoodItemTypeB2C:
            return goodsInfo.f_b2CGoodsListModel.goodsInfoList.count;
        case LXClassifyGoodItemTypeO2O:
            return goodsInfo.f_o2oGoodsInfo.f_goodsList.count;
        case LXClassifyGoodItemTypePinCategoryView:
        case LXClassifyGoodItemTypeEmpty:
            return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXClassifyGoodsInfoModel *goodsInfo = self.goodsList[indexPath.section];
    switch (goodsInfo.f_itemType) {
        case LXClassifyGoodItemTypeB2C: {
            LXClassifyRightCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXClassifyRightCollectionCell" forIndexPath:indexPath];
            LXB2CGoodItemModel *itemModel = goodsInfo.f_b2CGoodsListModel.goodsInfoList[indexPath.row];
            [cell dataFill:itemModel];
            return cell;
        }
        case LXClassifyGoodItemTypeO2O: {
            LXO2OGoodItemModel *itemModel = goodsInfo.f_o2oGoodsInfo.f_goodsList[indexPath.row];
            switch (itemModel.f_itemType) {
                case LXClassifyGoodItemTypeO2O: {
                    LXClassifyRightCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXClassifyRightCollectionCell" forIndexPath:indexPath];
                    [cell dataFill:itemModel];
                    return cell;
                }
                case LXClassifyGoodItemTypeB2C:
                case LXClassifyGoodItemTypePinCategoryView:
                case LXClassifyGoodItemTypeEmpty: {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
                    return cell;
                }
            }
        }
        case LXClassifyGoodItemTypePinCategoryView:
        case LXClassifyGoodItemTypeEmpty: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
            return cell;
        }
    }
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXClassifyGoodsInfoModel *goodsInfo = self.goodsList[indexPath.section];
    switch (goodsInfo.f_itemType) {
        case LXClassifyGoodItemTypeB2C: {
            LXB2CGoodItemModel *itemModel = goodsInfo.f_b2CGoodsListModel.goodsInfoList[indexPath.row];
            return itemModel.f_cellHeight;
        }
        case LXClassifyGoodItemTypeO2O: {
            LXO2OGoodItemModel *itemModel = goodsInfo.f_o2oGoodsInfo.f_goodsList[indexPath.row];
            return itemModel.f_cellHeight;
        }
        case LXClassifyGoodItemTypeEmpty:
        case LXClassifyGoodItemTypePinCategoryView:
            return CGFLOAT_MIN;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    LXClassifyGoodsInfoModel *goodsInfo = self.goodsList[section];
    switch (goodsInfo.f_itemType) {
        case LXClassifyGoodItemTypeB2C: {
            return CGFLOAT_MIN;
        }
        case LXClassifyGoodItemTypeO2O: {
            if(goodsInfo.f_o2oCategoryMdeol) {
                return kWPercentage(44.f);
            } else {
                return CGFLOAT_MIN;
            }
        }
        case LXClassifyGoodItemTypePinCategoryView: {
            if(self.rightModel.f_categorys.count > 0) {
                return __pinViewHeight;
            } else {
                return CGFLOAT_MIN;
            }
        }
        case LXClassifyGoodItemTypeEmpty:
            return CGFLOAT_MIN;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LXClassifyGoodsInfoModel *goodsInfo = self.goodsList[section];
    switch (goodsInfo.f_itemType) {
        case LXClassifyGoodItemTypeO2O: {
            if(goodsInfo.f_o2oCategoryMdeol) {
                LXClassifySectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LXClassifySectionHeaderView"];
                LXClassifyBaseCategoryModel *sectionModel = goodsInfo.f_o2oCategoryMdeol;
                [header dataFill:sectionModel];
                return header;
            } else {
                return nil;
            }
        }
        case LXClassifyGoodItemTypePinCategoryView: {
            if(self.rightModel.f_categorys.count > 0) {
                LXSectionCategoryHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LXSectionCategoryHeaderView"];
                self.sectionCategoryHeaderView = header;
                if(!self.pinView.superview) {
                    // 首次使用 LXSectionCategoryHeaderView 的时候，把pinCategoryView添加到它上面。
                    self.pinView.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), __pinViewHeight);
                    [header addSubview:self.pinView];
                }
                return header;
            } else {
                return nil;
            }
        }
        case LXClassifyGoodItemTypeB2C: {
            return nil;
        }
        case LXClassifyGoodItemTypeEmpty:
            return nil;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark - ✈️UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // CGFloat offsetY = scrollView.contentOffset.y;
    // NSLog(@"-->offsetY: %f", offsetY);
    if(self.classifyType == DJClassifyTypeO2O && self.rightModel.f_categorys.count > 0) {
        CGRect sectionHeaderRect = self.sectionHeaderRectArray[kPinCategoryViewSectionIndex].CGRectValue;
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
        //用户滚动的才处理
        //获取categoryView下面一点的所有布局信息，用于知道，当前最上方是显示的哪个section
        NSArray <NSIndexPath *>*topIndexPaths = [self.table indexPathsForRowsInRect:CGRectMake(0, scrollView.contentOffset.y + __pinViewHeight + 1, self.table.bounds.size.width, 200)];
        NSIndexPath *topIndexPath = topIndexPaths.firstObject;
        NSUInteger topSection = topIndexPath.section;
        if(self.isAll && self.rightModel.f_categorys.count > 0) {
            topSection -= 1;
        } else if(!self.rightModel.f_showAll) {
            topSection -= 1;
        }
        if (topIndexPath != nil && topSection >= kPinCategoryViewSectionIndex) {
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
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.table registerClass:[LXClassifyRightCollectionCell class] forCellReuseIdentifier:@"LXClassifyRightCollectionCell"];
    // [self.table registerClass:[LXClassifyListBannerCell class] forCellReuseIdentifier:@"LXClassifyListBannerCell"];
    [self.table registerClass:[LXClassifySectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"LXClassifySectionHeaderView"];
    [self.table registerClass:[LXSectionCategoryHeaderView class] forHeaderFooterViewReuseIdentifier:@"LXSectionCategoryHeaderView"];

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
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.table];
    [self.allMaskView addSubview:self.allCategoryView];
    [self.view addSubview:self.allMaskView];
    [self.view addSubview:self.skeletonScreen];
    [self.view addSubview:self.emptyView];

    [self masonry];
}
- (void)prepareVM {
    @weakify(self)
    [[self.allMaskView rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self dismissAllCategoryView];
    }];
}
#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(...)
    [self.skeletonScreen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
    [self.allMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
        // make.left.right.bottom.equalTo(@0.f);
    }];
    [self.allCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@200.f);
    }];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}
#pragma mark getter / setter
- (void)setViewStatus:(LXViewStatus)viewStatus {
    if(_viewStatus == viewStatus) {
        return;
    }
    _viewStatus = viewStatus;

    self.emptyView.hidden = YES;
    self.skeletonScreen.hidden = YES;
    switch (viewStatus) {
        case LXViewStatusUnknown:
            break;
        case LXViewStatusNormal:
            break;
        case LXViewStatusLoading:
            self.skeletonScreen.hidden = NO;
            break;
        case LXViewStatusNoData:
            self.emptyView.hidden = NO;
            [self.emptyView dataFillEmptyStyle];
            break;
        case LXViewStatusOffline:
            self.emptyView.hidden = NO;
            [self.emptyView dataFillOfflineStyle];
            break;
    }
}
#pragma mark Lazy Property
- (LXSubCategoryPinView *)pinView {
    if(!_pinView){
        LXSubCategoryPinView *v = [[LXSubCategoryPinView alloc]init];
        WEAKSELF(self)
        v.layoutSubviewsCallback = ^(CGRect rect) {
            weakSelf.pinCategoryRect = [weakSelf.view convertRect:weakSelf.pinView.pinCategoryView.frame fromView:weakSelf.pinView.pinCategoryView.superview];
        };
        v.pinCategoryView.didSelectRowBlock = ^(NSInteger idx) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(idx >= 0 && idx < weakSelf.goodsList.count) {
                    [weakSelf.allCategoryView selectItemAtIndex:idx];
                    [weakSelf selectItemAtIndex:idx];
                    [weakSelf dismissAllCategoryView];
                    // CGRect sectionRect = [weakSelf.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:idx]].frame;
                    // weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:idx] atScrollPosition:<#(UICollectionViewScrollPosition)#> animated:<#(BOOL)#>
                }
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
- (LX3rdCategoryView *)allCategoryView {
    if(!_allCategoryView){
        LX3rdCategoryView *v = [[LX3rdCategoryView alloc]init];
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
                if(idx >= 0 && idx < weakSelf.goodsList.count) {
                    [weakSelf.pinView.pinCategoryView selectItemAtIndex:idx];
                    [weakSelf selectItemAtIndex:idx];
                    [weakSelf dismissAllCategoryView];
                }
            });
        };
        _allCategoryView = v;
    }
    return _allCategoryView;
}
- (LXVerticalTableView *)table {
    if(!_table) {
        LXVerticalTableView *t = [[LXVerticalTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        t.tableHeaderView = [UIView new];
        t.tableFooterView = [UIView new];
        t.backgroundColor = [UIColor whiteColor];
        t.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        t.indicatorStyle = UIScrollViewIndicatorStyleBlack;
        t.separatorStyle = UITableViewCellSeparatorStyleNone;
        t.estimatedRowHeight = 44.0f;
        t.rowHeight = 44.f;
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
        WEAKSELF(self)
        t.layoutSubviewsCallback = ^{
            [weakSelf updateSectionHeaderAttributes];
        };
        _table = t;
    }
    return _table;
}
- (LXClassifyRightSkeletonScreen *)skeletonScreen {
    if(!_skeletonScreen){
        LXClassifyRightSkeletonScreen *v = [[LXClassifyRightSkeletonScreen alloc]init];
        v.hidden = YES;
        _skeletonScreen = v;
    }
    return _skeletonScreen;
}
- (LXClassifyEmptyView *)emptyView {
    if(!_emptyView){
        LXClassifyEmptyView *v = [[LXClassifyEmptyView alloc]init];
        v.hidden = YES;
        _emptyView = v;
    }
    return _emptyView;
}
@end
