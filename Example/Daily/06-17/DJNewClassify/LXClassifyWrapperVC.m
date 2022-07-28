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

#import "LXClassifyListVC.h"
#import "LXFirstCategoryFoldView.h"
#import "LXFirstCategoryUnfoldView.h"
#import "LXClassifyEmptyView.h"
#import "DJClassifyMacro.h"

static const CGFloat kLabelAllWidth = 35.f;

// TODO: 「lxthyme」💊
@interface LXClassifyWrapperVC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate/**, JXCategoryViewListContainer*/> {
}
@property(nonatomic, strong)YYLabel *labAll;
@property (nonatomic, strong)LXFirstCategoryFoldView *categoryView;
@property (nonatomic, strong)LXFirstCategoryUnfoldView *allCategoryView;
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

@implementation LXClassifyWrapperVC
#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    !self.toggleSkeletonScreenBlock ?: self.toggleSkeletonScreenBlock(NO);
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
        [self.categoryView dataFill:x];
        [self.allCategoryView dataFill:x];
        /// 一级级目录数据结构
        NSMutableDictionary<NSString *, LXClassifyListModel *> *classifyListModel = [NSMutableDictionary dictionary];
        [x enumerateObjectsUsingBlock:^(DJO2OCategoryListModel * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            /// 二级级目录数据结构
            NSMutableDictionary<NSString *, LXClassifyRightModel *> *rightListModel = [NSMutableDictionary dictionary];
            [obj1.rywCategorys enumerateObjectsUsingBlock:^(DJO2OCategoryListModel * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                LXClassifyRightModel *tmp = [[LXClassifyRightModel alloc]init];
                if(idx2 == 0) {
                    tmp.f_idxType = LXSubCategoryIndexTypeFirst;
                } else if(idx2 == obj2.rywCategorys.count - 1) {
                    tmp.f_idxType = LXSubCategoryIndexTypeLast;
                }
                tmp.f_categoryId = obj2.categoryId;
                rightListModel[obj2.categoryId] = tmp;
            }];
            LXClassifyListModel *tmp = [[LXClassifyListModel alloc]init];
            tmp.f_categoryId = obj1.categoryId;
            tmp.categorys = obj1.rywCategorys;
            tmp.rightListModel = [rightListModel copy];
            classifyListModel[obj1.categoryId] = tmp;
            !self.toggleSkeletonScreenBlock ?: self.toggleSkeletonScreenBlock(YES);
        }];
        self.classifyModel.categorys = x;
        self.classifyModel.classifyListModel = [classifyListModel copy];
        [self.listContainerView reloadData];
    }];
    [self.b2cVM.shopCategoryErrorSubject subscribeNext:^(CTAPIBaseManager *apiManager) {
        self.viewStatus = LXViewStatusOffline;
        NSLog(@"error_productSearchDoCategoryByLevOneErrorSubject: %@", apiManager);
    }];
    [self.b2cVM.searchGoodsDetailsSubject subscribeNext:^(LXB2CGoodsItemListModel *x) {
        @strongify(self)
        NSLog(@"goodsList: %@", x);
        NSInteger idx = self.categoryView.selectedIndexPath.row;
        LXClassifyListVC *vc = self.classifyVCList[@(idx)];
        [vc updateGoodItem:x];
    }];
    [self.b2cVM.searchGoodsDetailsErrorSubject subscribeNext:^(id x) {
    }];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)showFirstCategoryView {
    if(!self.allMaskView.hidden) {
        [self dismissFirstCategoryView];
        return;
    }
    self.allMaskView.hidden = NO;
    POPSpringAnimation *maskAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    maskAnim.fromValue = @0.f;
    maskAnim.toValue = @1.f;
    [self.allMaskView.layer pop_addAnimation:maskAnim forKey:@"allMaskView.opacity"];
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.fromValue = @(-200.f);
    anim.toValue = @100.f;
    anim.springBounciness = 0.f;
    [self.allCategoryView.layer pop_addAnimation:anim forKey:@"allCategoryView.translation.y"];
}
- (void)dismissFirstCategoryView {
    if(self.allMaskView.hidden) {
        return;
    }
    self.allMaskView.hidden = NO;
    POPSpringAnimation *maskAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    maskAnim.fromValue = @1.f;
    maskAnim.toValue = @0.f;
    [self.allMaskView.layer pop_addAnimation:maskAnim forKey:@"allMaskView.opacity"];
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.fromValue = @100.f;
    anim.toValue = @(-200.f);
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        self.allMaskView.hidden = YES;
    };
    [self.allCategoryView.layer pop_addAnimation:anim forKey:@"allCategoryView.translation.y"];
}

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
- (void)listDidDisappear {
    /// 容器在隐藏时, 隐藏各种弹窗
    [self dismissFirstCategoryView];
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
    return self.classifyModel.categorys.count;
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
    DJO2OCategoryListModel *categoryModel = self.classifyModel.categorys[index];
    LXClassifyListModel *classifyListModel = self.classifyModel.classifyListModel[categoryModel.categoryId];
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
        [self dismissFirstCategoryView];
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
#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.labAll, self.imgViewShadowLeft, self.imgViewShadowRight, self.listContainerView, self.categoryView)
    [self.categoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0.f);
        make.height.equalTo(@(kFirstCategoryFoldHeight));
    }];
    [self.labAll mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.categoryView);
        make.left.equalTo(self.categoryView.mas_right);
        make.right.equalTo(@0.f);
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
            [weakSelf showFirstCategoryView];
        };

        _labAll = lab;
    }
    return _labAll;
}
- (LXFirstCategoryFoldView *)categoryView {
    if(!_categoryView){
        LXFirstCategoryFoldView *v = [[LXFirstCategoryFoldView alloc]init];

        v.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [v.flowLayout prepareLayout];
        v.normalTextColor = [UIColor colorWithHex:0x333333];
        v.selectedTextColor = [UIColor colorWithHex:0xFFFFFF];
        WEAKSELF(self)
        v.didSelectRowBlock = ^(NSInteger idx) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.allCategoryView selectItemAtIndex:idx];
                // [weakSelf.listContainerView didClickSelectedItemAtIndex:idx];
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


- (LXFirstCategoryUnfoldView *)allCategoryView {
    if(!_allCategoryView){
        LXFirstCategoryUnfoldView *v = [[LXFirstCategoryUnfoldView alloc]init];
        v.normalTextColor = [UIColor colorWithHex:0x333333];
        v.selectedTextColor = [UIColor colorWithHex:0xFFFFFF];
        WEAKSELF(self)
        v.didSelectRowBlock = ^(NSInteger idx) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.categoryView selectItemAtIndex:idx];
                // [weakSelf.listContainerView didClickSelectedItemAtIndex:idx];
                [weakSelf dismissFirstCategoryView];
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
@end
