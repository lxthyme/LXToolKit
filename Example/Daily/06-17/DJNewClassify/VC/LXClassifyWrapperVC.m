//
//  LXClassifyWrapperVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyWrapperVC.h"

#import <YYText/YYText.h>
#import <YYModel/YYModel.h>
#import <JXCategoryView/JXCategoryView.h>
#import <pop/POP.h>
#import <BLNetworking/CTAPIBaseManager.h>

#import "LXClassifyListVC.h"
#import "LX1rdCategoryFoldView.h"
#import "LX1rdCategoryUnfoldView.h"
#import "LXClassifyEmptyView.h"
#import "DJClassifyMacro.h"
#import "LXClassifySkeletonScreen.h"
#import "LX1rdAllCategoryWrapperView.h"

static const CGFloat kLabelAllWidth = 35.f;

// TODO: 「lxthyme」💊
@interface LXClassifyWrapperVC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate/**, JXCategoryViewListContainer*/> {
}
@property(nonatomic, strong)UIStackView *topStackView;
@property(nonatomic, strong)YYLabel *labAll;
@property (nonatomic, strong)LX1rdCategoryFoldView *categoryView;
@property (nonatomic, strong)LX1rdCategoryUnfoldView *allCategoryView;
@property (nonatomic, strong)LX1rdAllCategoryWrapperView *allCategoryWrapperView;
@property(nonatomic, strong)UIImageView *imgViewShadowLeft;
@property(nonatomic, strong)UIImageView *imgViewShadowRight;
@property (nonatomic, strong)UIControl *allMaskView;
@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic, strong)LXClassifyEmptyView *emptyView;
@property(nonatomic, strong)LXClassifySkeletonScreen *classifySkeletonScreen;
/// 页面状态
@property(nonatomic, assign)LXViewStatus viewStatus;

@property(nonatomic, strong)LXClassifyModel *classifyModel;
@property(nonatomic, strong)NSMutableDictionary<NSNumber *, LXClassifyListVC *> *classifyVCList;

@end

@implementation LXClassifyWrapperVC
#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    // !self.toggleSkeletonScreenBlock ?: self.toggleSkeletonScreenBlock(NO);
    self.viewStatus = LXViewStatusLoading;
    [self prepareVM];
    [self prepareUI];
    [self bindVM];
    [self.b2cVM loadShopCategory];
}
#pragma mark -
#pragma mark - 🌎LoadData
- (void)bindVM {
    @weakify(self)
    [self.b2cVM.shopCategorySubject subscribeNext:^(NSArray<DJO2OCategoryListModel *> *x) {
        @strongify(self)
        if(x.count <= 0) {
            self.viewStatus = LXViewStatusNoData;
            return;
        }
        self.viewStatus = LXViewStatusNormal;
        NSLog(@"categoryModelList: %@", x);
        self.labAll.hidden = x.count <= 5;
        CGFloat width = 0.f;
        if(self.labAll.hidden) {
            width = SCREEN_WIDTH;
        } else {
            width = SCREEN_WIDTH - kLabelAllWidth;
        }
        self.categoryView.collectionView.frame = CGRectMake(0, 0, width, kFirstCategoryFoldHeight);
        [self.categoryView dataFill:x];
        [self.allCategoryView dataFill:x];
        /// 一级级目录数据结构
        NSMutableDictionary<NSString *, LXClassifyListModel *> *classifyList = [NSMutableDictionary dictionary];
        [x enumerateObjectsUsingBlock:^(DJO2OCategoryListModel * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            /// 二级级目录数据结构
            NSMutableDictionary<NSString *, LXClassifyRightModel *> *rightModelList = [NSMutableDictionary dictionary];
            [obj1.rywCategorys enumerateObjectsUsingBlock:^(DJO2OCategoryListModel * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                /// section 0
                // NSMutableArray *f_rywCategorys = [NSMutableArray array];
                // DJO2OCategoryListModel *item = [[DJO2OCategoryListModel alloc]init];
                // item.f_itemType = LXClassifyGoodItemTypeBanner;
                // [f_rywCategorys addObject:item];
                // [obj2.rywCategorys enumerateObjectsUsingBlock:^(DJO2OCategoryListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //     // obj.f_itemType = LXClassifyGoodItemTypeO2O;
                // }];
                // [f_rywCategorys addObjectsFromArray:obj2.rywCategorys];
                // obj2.f_rywCategorys = [f_rywCategorys copy];

                LXClassifyRightModel *rightModel = [[LXClassifyRightModel alloc]init];
                if(idx2 == 0) {
                    rightModel.f_idxType = LXSubCategoryIndexTypeFirst;
                } else if(idx2 == obj1.rywCategorys.count - 1) {
                    rightModel.f_idxType = LXSubCategoryIndexTypeLast;
                }
                rightModel.f_2rdCategoryId = obj2.categoryId;
                rightModel.f_itemType = LXClassifyGoodItemTypeO2O;
                rightModel.f_shouldShowBanner = YES;
                // rightModel.f_shouldShowJiShiDa = YES;
                rightModel.f_showAll = obj2.showAll == 1;
                rightModel.f_categorys = obj2.rywCategorys;
                rightModel.f_o2oCategoryModel = obj2;
                rightModelList[obj2.categoryId] = rightModel;
            }];
            LXClassifyListModel *classifyListModel = [[LXClassifyListModel alloc]init];
            classifyListModel.f_1rdCategoryId = obj1.categoryId;
            classifyListModel.f_categorys = obj1.rywCategorys;
            classifyListModel.f_rightModelList = [rightModelList copy];
            classifyList[obj1.categoryId] = classifyListModel;
        }];
        self.classifyModel.f_categorys = x;
        self.classifyModel.f_classifyList = [classifyList copy];
        [self.listContainerView reloadData];
    }];
    [self.b2cVM.shopCategoryErrorSubject subscribeNext:^(CTAPIBaseManager *apiManager) {
        self.viewStatus = LXViewStatusOffline;
        NSLog(@"error_productSearchDoCategoryByLevOneErrorSubject: %@", apiManager);
    }];
    [self.b2cVM.searchGoodsDetailsSubject subscribeNext:^(RACTuple *x) {
        NSString *o2oCategoryId = x.first;
        BOOL isAll = [x.second boolValue];
        NSArray<LXClassifyGoodsInfoModel *> *goodsInfoList = x.third;
        @strongify(self)
        NSLog(@"goodsList: %@", x);
        NSInteger idx = self.categoryView.selectedIndexPath.row;
        LXClassifyListVC *vc = self.classifyVCList[@(idx)];
        if(isAll) {
            [vc updateGoodItemOnlyAll:o2oCategoryId goodsInfoList:goodsInfoList];
        } else {
            [vc updateGoodItemAllSection:o2oCategoryId goodsInfoList:goodsInfoList];
        }
    }];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXCategoryViewListContainer
- (void)listContainerViewDidScroll:(UIScrollView *)scrollView {
    if (!(scrollView.isTracking || scrollView.isDecelerating)) {
        //不是用户滚动的，比如setContentOffset等方法，引起的滚动不需要处理。
        return;
    }
    CGPoint offset = scrollView.contentOffset;
    CGFloat page = floorf(offset.x / CGRectGetWidth(scrollView.frame));
    if(self.categoryView.selectedIndexPath.row != page) {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:page inSection:0];
        [self.categoryView selectItemAtIndex:ip.row];
        [self.allCategoryView selectItemAtIndex:ip.row];
    }
}
#pragma mark -
#pragma mark - ✈️JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
// - (void)listDidAppear {
//     NSInteger idx = self.categoryView.selectedIndexPath.row;
//     LXClassifyListVC *vc = self.classifyVCList[@(idx)];
//     if(vc) {
//         LXClassifyBaseCategoryModel *categoryModel = self.classifyModel.f_categorys[idx];
//         LXClassifyListModel *classifyListModel = self.classifyModel.f_classifyList[categoryModel.categoryId];
//         [vc dataFill:classifyListModel];
//     }
// }
- (void)listDidDisappear {
    /// 容器在隐藏时, 隐藏各种弹窗
    [self.allCategoryWrapperView dismissFirstCategoryView];
    NSInteger idx = self.categoryView.selectedIndexPath.row;
    LXClassifyListVC *vc = self.classifyVCList[@(idx)];
    if(vc) {
        [vc listDidDisappear];
    }
}

#pragma mark -
#pragma mark - ✈️JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark -
#pragma mark - ✈️JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.classifyModel.f_categorys.count;
}
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    LXClassifyListVC *vc = self.classifyVCList[@(index)];
    if(!vc) {
        vc = [[LXClassifyListVC alloc]init];
        vc.b2cVM = self.b2cVM;
        vc.classifyType = DJClassifyTypeO2O;
        vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
        self.classifyVCList[@(index)] = vc;
    }
    LXClassifyBaseCategoryModel *categoryModel = self.classifyModel.f_categorys[index];
    LXClassifyListModel *classifyListModel = self.classifyModel.f_classifyList[categoryModel.categoryId];
    [vc dataFill:classifyListModel];
    return vc;
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareVM {
    // [[[self.labAll rac_signalForControlEvents:UIControlEventTouchUpInside]
    // takeUntil:self.rac_willDeallocSignal]
    //  subscribeNext:^(__kindof UIControl * _Nullable x) {
    //     NSLog(@"btn: %@", x);
    // }];
    @weakify(self)
    [[self.allMaskView rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.allCategoryWrapperView dismissFirstCategoryView];
    }];
    [[[RACObserve(self.listContainerView.scrollView, contentOffset) distinctUntilChanged]
      throttle:0.3]
     subscribeNext:^(id x) {
        @strongify(self)
        CGPoint contentOffset = [x CGPointValue];
        NSInteger page = floorf(contentOffset.x / SCREEN_WIDTH);
        NSLog(@"LXClassifyWrapperVC_page: %ld", page);
        [self.categoryView selectItemAtIndex:page];
        [self.allCategoryView selectItemAtIndex:page];
        [self.listContainerView didClickSelectedItemAtIndex:page];
        self.navigationController.interactivePopGestureRecognizer.enabled = (page == 0);
    }];

}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;

    [self.topStackView addArrangedSubview:self.categoryView];
    [self.topStackView addArrangedSubview:self.labAll];
    [self.view addSubview:self.topStackView];
    [self.view addSubview:self.imgViewShadowLeft];
    [self.view addSubview:self.imgViewShadowRight];
    [self.view addSubview:self.listContainerView];

    [self.allMaskView addSubview:self.allCategoryView];
    [self.view addSubview:self.allMaskView];
    [self.view addSubview:self.emptyView];
    [self.view addSubview:self.classifySkeletonScreen];

    [self masonry];
}
#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.labAll, self.imgViewShadowLeft, self.imgViewShadowRight, self.listContainerView, self.categoryView)
    [self.topStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@(kFirstCategoryFoldHeight));
    }];
    [self.labAll mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kLabelAllWidth));
    }];
    [self.imgViewShadowLeft mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.categoryView);
        make.left.equalTo(@0.f);
    }];
    [self.imgViewShadowRight mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.categoryView);
        make.right.equalTo(self.labAll.mas_left);
    }];
    [self.listContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
        // make.edges.equalTo(@0.f);
    }];

    [self.allMaskView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_top);
        make.left.right.bottom.equalTo(@0.f);
    }];
    [self.allCategoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@200.f);
    }];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
    [self.classifySkeletonScreen mas_makeConstraints:^(MASConstraintMaker *make) {
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
    self.classifySkeletonScreen.hidden = YES;
    switch (viewStatus) {
        case LXViewStatusUnknown:
            break;
        case LXViewStatusNormal:
            break;
        case LXViewStatusLoading:
            self.classifySkeletonScreen.hidden = NO;
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
- (NSMutableDictionary<NSNumber *, LXClassifyListVC *> *)classifyVCList {
    if(!_classifyVCList){
        _classifyVCList = [NSMutableDictionary dictionary];
    }
    return _classifyVCList;
}
- (LXClassifyModel *)classifyModel {
    if(!_classifyModel){
        LXClassifyModel *v = [[LXClassifyModel alloc]init];
        _classifyModel = v;
    }
    return _classifyModel;
}
- (UIStackView *)topStackView {
    if(!_topStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisHorizontal;
        sv.spacing = 0.f;
        _topStackView = sv;
    }
    return _topStackView;
}
- (YYLabel *)labAll {
    if(!_labAll){
        YYLabel *lab = [[YYLabel alloc]init];
        UIFont *font = [UIFont boldSystemFontOfSize:kWPercentage(11.f)];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
        [attr yy_appendString:@"全 部"];
        attr.yy_font = font;
        attr.yy_color = [UIColor colorWithHex:0x333333];
        UIImage *img = [iBLImage imageNamed:@"icon_unfold"];
        NSMutableAttributedString *attachment = [NSMutableAttributedString
                                                 yy_attachmentStringWithContent:img
                                                 contentMode:UIViewContentModeCenter
                                                 attachmentSize:img.size
                                                 alignToFont:font
                                                 alignment:YYTextVerticalAlignmentCenter];
        [attr yy_appendString:@" "];
        [attr appendAttributedString:attachment];
        lab.attributedText = attr;
        lab.verticalForm = YES;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        lab.exclusionPaths = @[[UIBezierPath bezierPathWithRect:CGRectZero]];
        lab.hidden = YES;
        WEAKSELF(self)
        lab.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            [weakSelf.allCategoryWrapperView showWithContainerView:self.allCategoryView topConstraint:self.categoryView.mas_top];
        };

        _labAll = lab;
    }
    return _labAll;
}
- (LX1rdCategoryFoldView *)categoryView {
    if(!_categoryView){
        LX1rdCategoryFoldView *v = [[LX1rdCategoryFoldView alloc]init];

        v.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [v.flowLayout prepareLayout];
        v.normalTextColor = [UIColor colorWithHex:0x333333];
        v.selectedTextColor = [UIColor colorWithHex:0xFFFFFF];
        WEAKSELF(self)
        v.didSelectRowBlock = ^(NSInteger idx) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.navigationController.interactivePopGestureRecognizer.enabled = (idx == 0);
                [weakSelf.allCategoryView selectItemAtIndex:idx];
                [weakSelf.listContainerView didClickSelectedItemAtIndex:idx];
                [weakSelf.listContainerView.scrollView setContentOffset:CGPointMake(idx * weakSelf.listContainerView.scrollView.bounds.size.width, 0) animated:YES];
            });
        };
        _categoryView = v;
    }
    return _categoryView;
}
- (UIImageView *)imgViewShadowLeft {
    if(!_imgViewShadowLeft){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [iBLImage imageNamed:@"dj_category_shadow_left"];
        _imgViewShadowLeft = iv;
    }
    return _imgViewShadowLeft;
}
- (UIImageView *)imgViewShadowRight {
    if(!_imgViewShadowRight){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [iBLImage imageNamed:@"dj_category_shadow_right"];
        _imgViewShadowRight = iv;
    }
    return _imgViewShadowRight;
}
- (LX1rdAllCategoryWrapperView *)allCategoryWrapperView {
    if(!_allCategoryWrapperView){
        LX1rdAllCategoryWrapperView *v = [[LX1rdAllCategoryWrapperView alloc]init];
        _allCategoryWrapperView = v;
    }
    return _allCategoryWrapperView;
}
- (LX1rdCategoryUnfoldView *)allCategoryView {
    if(!_allCategoryView){
        LX1rdCategoryUnfoldView *v = [[LX1rdCategoryUnfoldView alloc]init];
        v.normalTextColor = [UIColor colorWithHex:0x333333];
        v.selectedTextColor = [UIColor colorWithHex:0xFFFFFF];
        WEAKSELF(self)
        v.didSelectRowBlock = ^(NSInteger idx) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.navigationController.interactivePopGestureRecognizer.enabled = (idx == 0);
                [weakSelf.categoryView selectItemAtIndex:idx];
                [weakSelf.allCategoryWrapperView dismissFirstCategoryView];
                [weakSelf.listContainerView didClickSelectedItemAtIndex:idx];
                [weakSelf.listContainerView.scrollView setContentOffset:CGPointMake(idx * weakSelf.listContainerView.scrollView.bounds.size.width, 0) animated:YES];
            });
        };
        _allCategoryView = v;
    }
    return _allCategoryView;
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
- (JXCategoryListContainerView *)listContainerView {
    if(!_listContainerView){
        // TODO: 「lxthyme」💊
        JXCategoryListContainerView *v = [[JXCategoryListContainerView alloc]initWithDelegate:self];
        v.frame = CGRectMake(0, kFirstCategoryFoldHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kFirstCategoryFoldHeight);
        // [[JXCategoryListContainerView alloc]initWithType:JXCategoryListContainerType_CollectionView delegate:self];
        _listContainerView = v;
    }
    return _listContainerView;
}
- (LXClassifyEmptyView *)emptyView {
    if(!_emptyView){
        LXClassifyEmptyView *v = [[LXClassifyEmptyView alloc]init];
        v.hidden = YES;
        _emptyView = v;
    }
    return _emptyView;
}
- (LXClassifySkeletonScreen *)classifySkeletonScreen {
    if(!_classifySkeletonScreen){
        LXClassifySkeletonScreen *v = [[LXClassifySkeletonScreen alloc]init];
        v.panelTopView.hidden = YES;
        v.hidden = YES;
        _classifySkeletonScreen = v;
    }
    return _classifySkeletonScreen;
}
@end
