//
//  LXB2CClassifyWrapperVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXB2CClassifyWrapperVC.h"

#import <YYText/YYText.h>
#import <YYModel/YYModel.h>
#import <JXCategoryView/JXCategoryView.h>
#import <pop/POP.h>
#import <IBLProgressHud/IBLProgressHud.h>
#import <BLNetworking/CTAPIBaseManager.h>

#import "LXClassifyListVC.h"
#import "LX3rdCategoryView.h"
#import "LXClassifyRightVCModel.h"
#import "LXClassifyEmptyView.h"
#import "DJClassifyMacro.h"
#import "LX1rdAllCategoryWrapperView.h"

#define kB2CCategoryViewHeight kWPercentage(48.5f)
static const CGFloat kLabelAllWidth = 35.f;

@interface LXB2CClassifyWrapperVC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate/**, JXCategoryViewListContainer*/> {
}
@property(nonatomic, strong)YYLabel *labAll;
@property (nonatomic, strong)LX3rdCategoryView *categoryView;
@property (nonatomic, strong)LX3rdCategoryView *allCategoryView;
@property (nonatomic, strong)LX1rdAllCategoryWrapperView *allCategoryWrapperView;
@property(nonatomic, strong)UIImageView *imgViewShadowLeft;
@property(nonatomic, strong)UIImageView *imgViewShadowRight;
@property (nonatomic, strong)UIControl *allMaskView;
@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic, strong)LXClassifyEmptyView *emptyView;
/// 页面状态
@property(nonatomic, assign)LXViewStatus viewStatus;
@property(nonatomic, strong)LXClassifyModel *classifyModel;
@property(nonatomic, strong)NSMutableDictionary<NSNumber *, LXClassifyListVC *> *classifyVCList;

@end

@implementation LXB2CClassifyWrapperVC
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
    // [self loadData];
    self.viewStatus = LXViewStatusLoading;
    [self.b2cVM loadProductSearchDoCategoryByLevOne];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)bindVM {
    @weakify(self)
    [self.b2cVM.productSearchDoCategoryByLevOneSubject subscribeNext:^(NSArray<LXLHCategoryModel *> *categoryModelList) {
        @strongify(self)
        if(categoryModelList.count <= 0) {
            self.viewStatus = LXViewStatusNoData;
            return;
        }
        self.viewStatus = LXViewStatusNormal;
        NSLog(@"categoryModelList: %@", categoryModelList);
        [self.categoryView dataFill:categoryModelList];
        [self.allCategoryView dataFill:categoryModelList];
        /// 一级级目录数据结构
        NSMutableDictionary<NSString *, LXClassifyListModel *> *classifyList = [NSMutableDictionary dictionary];
        [categoryModelList enumerateObjectsUsingBlock:^(LXLHCategoryModel * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            /// 二级级目录数据结构
            NSMutableDictionary<NSString *, LXClassifyRightModel *> *rightModelList = [NSMutableDictionary dictionary];
            [obj1.categorys enumerateObjectsUsingBlock:^(LXLHCategoryModel * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                LXClassifyRightModel *rightModel = [[LXClassifyRightModel alloc]init];
                if(idx2 == 0) {
                    rightModel.f_idxType = LXSubCategoryIndexTypeFirst;
                } else if(idx2 == obj1.categorys.count - 1) {
                    rightModel.f_idxType = LXSubCategoryIndexTypeLast;
                }
                rightModel.f_2rdCategoryId = obj2.categoryId;
                rightModel.f_itemType = LXClassifyGoodItemTypeB2C;
                rightModel.f_shouldShowBanner = NO;
                // rightModel.f_shouldShowJiShiDa = NO;
                rightModel.f_categorys = obj1.categorys;
                rightModel.f_b2cCategoryModel = obj2;
                rightModelList[obj2.categoryId] = rightModel;
            }];
            LXClassifyListModel *classifyListModel = [[LXClassifyListModel alloc]init];
            classifyListModel.f_1rdCategoryId = obj1.categoryId;
            classifyListModel.f_categorys = obj1.categorys;
            classifyListModel.f_rightModelList = [rightModelList copy];
            classifyList[obj1.categoryId] = classifyListModel;
            self.viewStatus = LXViewStatusNormal;
            // !self.toggleSkeletonScreenBlock ?: self.toggleSkeletonScreenBlock(YES);
        }];
        self.classifyModel.f_categorys = categoryModelList;
        self.classifyModel.f_classifyList = [classifyList copy];
        [self.listContainerView reloadData];
    }];
    [self.b2cVM.v2SearchForLHApiSubject subscribeNext:^(RACTuple *x) {
        NSString *b2cCategoryId = x.first;
        LXClassifyGoodsInfoModel *goodsInfoList = x.second;
        @strongify(self)
        // NSLog(@"goodsInfoModel: %@", goodsInfoModel);
        NSInteger idx = self.categoryView.selectedIndex;
        LXClassifyListVC *vc = self.classifyVCList[@(idx)];
        [vc updateGoodItem:b2cCategoryId goodsInfoList:goodsInfoList];
    }];
    [self.b2cVM.productSearchDoCategoryByLevOneErrorSubject subscribeNext:^(CTAPIBaseManager *apiManager) {
        self.viewStatus = LXViewStatusOffline;
        NSLog(@"error_productSearchDoCategoryByLevOneErrorSubject: %@", apiManager);
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
    // CGPoint offset = scrollView.contentOffset;
    // CGFloat page = floorf(offset.x / CGRectGetWidth(scrollView.frame));
    // if(self.categoryView.selectedIndexPath.row != page) {
    //     NSIndexPath *ip = [NSIndexPath indexPathForRow:page inSection:0];
    //     [self.categoryView selectItemAtIndex:ip.row];
    //     [self.allCategoryView selectItemAtIndex:ip.row];
    // }
}
#pragma mark -
#pragma mark - ✈️JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
- (void)listDidDisappear {
    /// 容器在隐藏时, 隐藏各种弹窗
    [self.allCategoryWrapperView dismissFirstCategoryView];
    NSInteger idx = self.categoryView.selectedIndex;
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
        vc.classifyType = DJClassifyTypeB2C;
        vc.b2cVM = self.b2cVM;
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
    }];

}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;

    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.labAll];
    [self.view addSubview:self.imgViewShadowLeft];
    [self.view addSubview:self.imgViewShadowRight];
    [self.view addSubview:self.listContainerView];

    [self.allMaskView addSubview:self.allCategoryView];
    [self.view addSubview:self.allMaskView];
    [self.view addSubview:self.emptyView];

    [self masonry];
}
#pragma mark getter / setter
- (void)setViewStatus:(LXViewStatus)viewStatus {
    if(_viewStatus == viewStatus) {
        return;
    }
    _viewStatus = viewStatus;

    self.emptyView.hidden = YES;
    // self.classifySkeletonScreen.hidden = YES;
    switch (viewStatus) {
        case LXViewStatusUnknown:
            break;
        case LXViewStatusNormal:
            break;
        case LXViewStatusLoading:
            // self.classifySkeletonScreen.hidden = NO;
            // !self.toggleSkeletonScreenBlock ?: self.toggleSkeletonScreenBlock(YES);
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
#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.labAll, self.imgViewShadowLeft, self.imgViewShadowRight, self.listContainerView, self.categoryView)
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0.f);
        make.height.equalTo(@(kB2CCategoryViewHeight));
    }];
    [self.labAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.categoryView);
        make.left.equalTo(self.categoryView.mas_right);
        make.right.equalTo(@0.f);
        make.width.equalTo(@(kLabelAllWidth));
    }];
    [self.imgViewShadowLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.categoryView);
        make.left.equalTo(@0.f);
    }];
    [self.imgViewShadowRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.categoryView);
        make.right.equalTo(self.labAll.mas_left);
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
        // make.edges.equalTo(@0.f);
    }];

    [self.allMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_top);
        make.left.right.bottom.equalTo(@0.f);
    }];
    [self.allCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@200.f);
    }];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (NSMutableDictionary<NSNumber *, LXClassifyListVC *> *)classifyVCList {
    if(!_classifyVCList){
        _classifyVCList = [NSMutableDictionary dictionary];
    }
    return _classifyVCList;
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
        WEAKSELF(self)
        lab.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            [weakSelf.allCategoryWrapperView showWithContainerView:self.allCategoryView topConstraint:weakSelf.categoryView.mas_top];
        };

        _labAll = lab;
    }
    return _labAll;
}
- (LX3rdCategoryView *)categoryView {
    if(!_categoryView){
        LX3rdCategoryView *v = [[LX3rdCategoryView alloc]init];
        [v customized1rdCategoryViewStyle];

        v.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [v.flowLayout prepareLayout];
        v.minimumLineSpacing = kWPercentage(5.f);
        v.minimumInteritemSpacing = kWPercentage(5.f);
        v.sectionInset = UIEdgeInsetsMake(kWPercentage(10.f), 0.f, kWPercentage(10.f), 0.f);
        v.itemSize = CGSizeMake((SCREEN_WIDTH - kLabelAllWidth) / 4.5f, kB2CCategoryViewHeight - v.sectionInset.top - v.sectionInset.bottom);
        WEAKSELF(self)
        v.didSelectRowBlock = ^(NSInteger idx) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(idx >= 0 && idx < weakSelf.classifyModel.f_categorys.count) {
                    [weakSelf.allCategoryView selectItemAtIndex:idx];
                    // [weakSelf.listContainerView didClickSelectedItemAtIndex:idx];
                    [weakSelf.listContainerView.scrollView setContentOffset:CGPointMake(idx * weakSelf.listContainerView.scrollView.bounds.size.width, 0) animated:YES];
                }
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
- (LX3rdCategoryView *)allCategoryView {
    if(!_allCategoryView){
        LX3rdCategoryView *v = [[LX3rdCategoryView alloc]init];
        [v customized1rdCategoryViewStyle];

        v.minimumLineSpacing = kWPercentage(7.5f);
        v.minimumInteritemSpacing = kWPercentage(7.5f);
        v.sectionInset = UIEdgeInsetsMake(0, kWPercentage(10.f), kWPercentage(15.f), kWPercentage(10.f));
        v.itemSize = CGSizeMake(kWPercentage(68.f), kB2CCategoryViewHeight - v.sectionInset.top - v.sectionInset.bottom);
        CGFloat itemWidth = SCREEN_WIDTH - (v.sectionInset.left + v.sectionInset.right + v.minimumLineSpacing + v.minimumInteritemSpacing);
        itemWidth /= 3.f;
        v.itemSize = CGSizeMake(floorf(itemWidth), kWPercentage(35.f));
        WEAKSELF(self)
        v.didSelectRowBlock = ^(NSInteger idx) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(idx >= 0 && idx < weakSelf.classifyModel.f_categorys.count) {
                    [weakSelf.allCategoryWrapperView dismissFirstCategoryView];
                    [weakSelf.categoryView selectItemAtIndex:idx];
                    [weakSelf.listContainerView.scrollView setContentOffset:CGPointMake(idx * weakSelf.listContainerView.scrollView.bounds.size.width, 0) animated:YES];
                }
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
        v.frame = CGRectMake(0, kB2CCategoryViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kB2CCategoryViewHeight);
        // [[JXCategoryListContainerView alloc]initWithType:JXCategoryListContainerType_CollectionView delegate:self];
        _listContainerView = v;
    }
    return _listContainerView;
}
- (LXClassifyModel *)classifyModel {
    if(!_classifyModel){
        LXClassifyModel *v = [[LXClassifyModel alloc]init];
        _classifyModel = v;
    }
    return _classifyModel;
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
