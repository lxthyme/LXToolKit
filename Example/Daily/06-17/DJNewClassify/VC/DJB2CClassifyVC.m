//
//  DJB2CClassifyVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/8/5.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJB2CClassifyVC.h"
#import <YYModel/YYModel.h>
#import <YYText/YYText.h>
#import "DJ3rdCategoryView.h"
#import "DJClassifyListLeftView.h"
#import "DJ1rdAllCategoryWrapperView.h"
#import "DJClassifyB2CRightVC.h"

@interface DJB2CClassifyVC() {
}
@property(nonatomic, strong)UIStackView *topStackView;
@property(nonatomic, strong)YYLabel *labAll;
@property (nonatomic, strong)DJ3rdCategoryView *categoryView;
@property (nonatomic, strong)DJ3rdCategoryView *allCategoryView;
@property (nonatomic, strong)DJ1rdAllCategoryWrapperView *allCategoryWrapperView;
@property(nonatomic, strong)UIImageView *imgViewShadowLeft;
@property(nonatomic, strong)UIImageView *imgViewShadowRight;
@property (nonatomic, strong)UIControl *allMaskView;

@property(nonatomic, strong)UIImageView *imgViewLeftCorner;
@property(nonatomic, strong)UIImageView *imgViewRightCorner;
@property(nonatomic, strong)DJClassifyListLeftView *panelLeftView;
@property(nonatomic, strong)UIPageViewController *pageVC;

@property (nonatomic, strong)NSArray *titles;
@property(nonatomic, strong)DJClassifyModel *classifyModel;
@property(nonatomic, strong)NSMutableDictionary<NSNumber *, DJClassifyB2CRightVC *> *rightVCList;
/// 当前选中的二级目录的 index
@property(nonatomic, assign)NSInteger currentT2Idx;

@end

@implementation DJB2CClassifyVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    [self prepareUI];
    [self bindVM];
    [self.classifyVM loadProductSearchDoCategoryByLevOne];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)bindVM {
    @weakify(self)
    [self.classifyVM.productSearchDoCategoryByLevOneSubject subscribeNext:^(NSArray<DJB2CCategoryModel *> *x) {
        @strongify(self)
        self.labAll.hidden = x.count <= 5;
        CGFloat width = 0.f;
        if(self.labAll.hidden) {
            width = SCREEN_WIDTH;
        } else {
            width = SCREEN_WIDTH - kLabelAllWidth;
        }
        self.categoryView.frame = CGRectMake(0, 0, width, kB2CCategoryViewHeight);
        [self.categoryView dataFill:x];
        [self.allCategoryView dataFill:x];
        /// 一级级目录数据结构
        NSMutableDictionary<NSString *, DJClassifyListModel *> *classifyList = [NSMutableDictionary dictionary];
        [x enumerateObjectsUsingBlock:^(DJB2CCategoryModel * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            /// 二级级目录数据结构
            NSMutableDictionary<NSString *, DJClassifyRightModel *> *rightModelList = [NSMutableDictionary dictionary];
            [obj1.categorys enumerateObjectsUsingBlock:^(DJB2CCategoryModel * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                DJClassifyRightModel *rightModel = [[DJClassifyRightModel alloc]init];
                if(idx2 == 0) {
                    rightModel.f_idxType = DJSubCategoryIndexTypeFirst;
                } else if(idx2 == obj2.categorys.count - 1) {
                    rightModel.f_idxType = DJSubCategoryIndexTypeLast;
                }
                rightModel.f_t2B2CCategory = obj2;
                rightModelList[obj2.categoryId] = rightModel;
            }];
            DJClassifyListModel *classifyListModel = [[DJClassifyListModel alloc]init];
            classifyListModel.f_categorys = obj1.categorys;
            classifyListModel.f_rightModelList = [rightModelList copy];
            classifyList[obj1.categoryId] = classifyListModel;
        }];
        self.classifyModel.f_categorys = x;
        self.classifyModel.f_classifyList = [classifyList copy];
        [self.categoryView dataFill:x];
        [self.panelLeftView dataFill:x.firstObject.categorys];
    }];
    [self.classifyVM.v2SearchForLHApiSubject subscribeNext:^(DJB2CCategoryModel *x) {
        @strongify(self)
        [self dataFillRightVCAtIdx:self.panelLeftView.currentIdx];
    }];
}
- (void)dataFillRightVCAtIdx:(NSInteger)t2Idx {
    DJClassifyRightModel *rightModel = [self getRightModelAtIdx:t2Idx];
    if(!rightModel) {
        return;
    }
    DJClassifyB2CRightVC *rightVC = [self vcAtIdx:t2Idx];
    [rightVC dataFill:rightModel];

    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    if(self.currentT2Idx > t2Idx) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    self.currentT2Idx = t2Idx;
    [self.pageVC setViewControllers:@[rightVC]
                          direction:direction
                           animated:YES completion:nil];
}
- (DJClassifyRightModel *)getRightModelAtIdx:(NSInteger)t2Idx {
    NSInteger t1Idx = self.categoryView.selectedIndex;
    if(t1Idx < 0 || t1Idx >= self.classifyModel.f_categorys.count) {
        return nil;
    }
    DJClassifyBaseCategoryModel *t1CategoryModel = self.classifyModel.f_categorys[t1Idx];
    DJClassifyListModel *t2ClassifyModel = self.classifyModel.f_classifyList[t1CategoryModel.categoryId];
    if(t2Idx < 0 || t2Idx >= t2ClassifyModel.f_categorys.count) {
        return nil;
    }
    DJClassifyBaseCategoryModel *t2CategoryModel = t2ClassifyModel.f_categorys[t2Idx];
    DJClassifyRightModel *rightModel = t2ClassifyModel.f_rightModelList[t2CategoryModel.categoryId];
    return rightModel;
}
#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - ✈️UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    /// 1. 隐藏当前 VC
    DJClassifyB2CRightVC *tmp_beforeVC = (DJClassifyB2CRightVC *)viewController;
    /// 2. 切换到当前 VC
    NSInteger idx = viewController.view.tag;
    if(idx <= 0) {
        return nil;
    }
    self.currentT2Idx = idx - 1;
    DJClassifyB2CRightVC *vc = [self vcAtIdx:idx - 1];
    return vc;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    /// 1. 隐藏当前 VC
    DJClassifyB2CRightVC *tmp_afterVC = (DJClassifyB2CRightVC *)viewController;
    /// 2. 切换到当前 VC
    NSInteger idx = viewController.view.tag;
    if(idx >= self.classifyModel.f_categorys.count - 1) {
        return nil;
    }
    self.currentT2Idx = idx + 1;
    DJClassifyB2CRightVC *vc = [self vcAtIdx:idx + 1];
    return vc;
}

#pragma mark -
#pragma mark - ✈️UIPageViewControllerDelegate

#pragma mark -
#pragma mark - 🔐Private Actions
- (NSInteger)idxOfVC:(DJClassifyB2CRightVC *)vc {
    /// <RACTuple<NSNumber *, DJClassifyB2CRightVC *> *>
    /// <NSNumber *, DJClassifyB2CRightVC *>
    RACSequence *seq = [self.rightVCList.rac_sequence filter:^BOOL(RACTuple *_Nullable value) {
        return [value.second isEqual:vc];
    }];
    if(seq.head == nil) {
        return NSNotFound;
    }
    if([seq.head isKindOfClass:[RACTuple class]]) {
        RACTuple *headTuple = seq.head;
        return [headTuple.first integerValue];
    }
    return NSNotFound;
}
- (DJClassifyB2CRightVC *)vcAtIdx:(NSInteger)idx {
    DJClassifyB2CRightVC *vc = self.rightVCList[@(idx)];
    if(!vc) {
        vc = [[DJClassifyB2CRightVC alloc]init];
        // vc.classifyType = self.classifyType;
        vc.b2cVM = self.classifyVM;
        vc.view.tag = idx;
        WEAKSELF(self)
        vc.refreshBlock = ^(BOOL isRefresh) {
            if(isRefresh) {
                [weakSelf pageVCScrollToIdx:idx - 1];
            } else {
                [weakSelf pageVCScrollToIdx:idx + 1];
            }
        };
        self.rightVCList[@(idx)] = vc;
    }
    return vc;
}
- (void)pageVCScrollToIdx:(NSInteger)idx {
    if(idx < 0 || idx >= self.classifyModel.f_categorys.count) {
        return;
    }
    /// 1. 隐藏当前 VC
    DJClassifyB2CRightVC *tmp_beforeVC = (DJClassifyB2CRightVC *)self.pageVC.viewControllers.firstObject;
    /// 2. 切换到下一个 VC
    DJClassifyB2CRightVC *vc = [self vcAtIdx:idx];
    if(idx >= 0 && idx < self.classifyModel.f_categorys.count) {
        DJClassifyRightModel *rightModel = [self getRightModelAtIdx:idx];
        rightModel.f_pinIdx = 0;
        [self dataFillRightVCAtIdx:idx];
    }

    NSInteger previousIdx = [self idxOfVC:self.pageVC.viewControllers.firstObject];
    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    if(previousIdx > idx) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    // [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [self.panelLeftView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
    [self.pageVC setViewControllers:@[vc]
                          direction: direction
                           animated:YES
                         completion:nil];
}
#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.hidesBackButton = YES;

    [self addChildViewController:self.pageVC];
    DJClassifyB2CRightVC *vc = [self vcAtIdx:0];
    [self.pageVC setViewControllers:@[vc]
                          direction:UIPageViewControllerNavigationDirectionReverse
                           animated:NO
                         completion:nil];

    [self.topStackView addArrangedSubview:self.categoryView];
    [self.topStackView addArrangedSubview:self.labAll];
    [self.topStackView addSubview:self.imgViewShadowLeft];
    [self.topStackView addSubview:self.imgViewShadowRight];
    [self.view addSubview:self.topStackView];
    [self.view addSubview:self.panelLeftView];
    [self.view addSubview:self.pageVC.view];
    [self.view addSubview:self.imgViewLeftCorner];
    [self.view addSubview:self.imgViewRightCorner];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.panelLeftView, self.pageVC.view, self.imgViewLeftCorner, self.imgViewRightCorner)
    [self.topStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@(kB2CCategoryViewHeight));
    }];
    [self.labAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kLabelAllWidth));
    }];
    [self.imgViewShadowLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(@0.f);
    }];
    [self.imgViewShadowRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0.f);
        make.right.equalTo(self.labAll.mas_left);
    }];
    [self.panelLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topStackView.mas_bottom);
        make.left.bottom.equalTo(@0.f);
        make.width.equalTo(@(kLeftTableWidth));
    }];
    [self.pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.panelLeftView);
        make.left.equalTo(self.panelLeftView.mas_right);
        make.right.equalTo(@0.f);
    }];
    [self.imgViewLeftCorner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.panelLeftView);
        make.width.equalTo(@(kWPercentage(10.f)));
    }];
    [self.imgViewRightCorner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.pageVC.view);
        make.width.equalTo(self.imgViewLeftCorner);
    }];
}

#pragma mark Lazy Property
- (NSMutableDictionary<NSNumber *, DJClassifyB2CRightVC *> *)rightVCList {
    if(!_rightVCList){
        _rightVCList = [NSMutableDictionary dictionary];
    }
    return _rightVCList;
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
- (DJ3rdCategoryView *)categoryView {
    if(!_categoryView){
        DJ3rdCategoryView *v = [[DJ3rdCategoryView alloc]init];
        v.headerType = DJNewClassifyHeaderTypeB2C;
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
                weakSelf.navigationController.interactivePopGestureRecognizer.enabled = (idx == 0);
                [weakSelf.allCategoryView selectItemAtIndex:idx];
                if(idx >= 0 && idx < self.classifyModel.f_categorys.count) {
                    DJB2CCategoryModel *t1Category = weakSelf.classifyModel.f_categorys[idx];
                    [weakSelf.rightVCList removeAllObjects];
                    [weakSelf.panelLeftView dataFill:t1Category.categorys];
                }
                // [weakSelf.listContainerView didClickSelectedItemAtIndex:idx];
                // [weakSelf.listContainerView.scrollView setContentOffset:CGPointMake(idx * weakSelf.listContainerView.scrollView.bounds.size.width, 0) animated:YES];
            });
        };

        _categoryView = v;
    }
    return _categoryView;
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
- (DJ3rdCategoryView *)allCategoryView {
    if(!_allCategoryView){
        DJ3rdCategoryView *v = [[DJ3rdCategoryView alloc]init];
        v.headerType = DJNewClassifyHeaderTypeB2C;
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
                weakSelf.navigationController.interactivePopGestureRecognizer.enabled = (idx == 0);
                [weakSelf.categoryView selectItemAtIndex:idx];
                if(idx >= 0 && idx < self.classifyModel.f_categorys.count) {
                    DJB2CCategoryModel *t1Category = weakSelf.classifyModel.f_categorys[idx];
                    [weakSelf.rightVCList removeAllObjects];
                    [weakSelf.panelLeftView dataFill:t1Category.categorys];
                }
                [weakSelf.allCategoryWrapperView dismissFirstCategoryView];
                // [weakSelf.listContainerView didClickSelectedItemAtIndex:idx];
                // [weakSelf.listContainerView.scrollView setContentOffset:CGPointMake(idx * weakSelf.listContainerView.scrollView.bounds.size.width, 0) animated:YES];
            });
        };
        _allCategoryView = v;
    }
    return _allCategoryView;
}
- (DJ1rdAllCategoryWrapperView *)allCategoryWrapperView {
    if(!_allCategoryWrapperView){
        DJ1rdAllCategoryWrapperView *v = [[DJ1rdAllCategoryWrapperView alloc]init];
        _allCategoryWrapperView = v;
    }
    return _allCategoryWrapperView;
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
- (UIControl *)allMaskView {
    if(!_allMaskView){
        UIControl *v = [[UIControl alloc]init];
        v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        v.hidden = YES;
        _allMaskView = v;
    }
    return _allMaskView;
}
- (UIImageView *)imgViewLeftCorner {
    if(!_imgViewLeftCorner){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [iBLImage imageNamed:@"icon_left_corner"];
        _imgViewLeftCorner = iv;
    }
    return _imgViewLeftCorner;
}
- (UIImageView *)imgViewRightCorner {
    if(!_imgViewRightCorner){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [iBLImage imageNamed:@"icon_right_corner"];
        _imgViewRightCorner = iv;
    }
    return _imgViewRightCorner;
}
- (DJClassifyListLeftView *)panelLeftView {
    if(!_panelLeftView){
        DJClassifyListLeftView *v = [[DJClassifyListLeftView alloc]init];
        v.headerType = DJNewClassifyHeaderTypeB2C;
        WEAKSELF(self)
        v.didSelectRowBlock = ^(NSInteger idx) {
            // [weakSelf pageVCScrollToIdx:idx];
            DJClassifyRightModel *rightModel = [weakSelf getRightModelAtIdx:idx];
            rightModel.f_pinIdx = 0;
            [weakSelf dataFillRightVCAtIdx:idx];
        };
        _panelLeftView = v;
    }
    return _panelLeftView;
}
- (UIPageViewController *)pageVC {
    if(!_pageVC){
        UIPageViewController *v = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:@{
            UIPageViewControllerOptionInterPageSpacingKey: @0.f
        }];
        v.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
        v.delegate = self;
        // v.dataSource = self;
        _pageVC = v;
    }
    return _pageVC;
}
- (DJClassifyModel *)classifyModel {
    if(!_classifyModel){
        DJClassifyModel *v = [[DJClassifyModel alloc]init];
        _classifyModel = v;
    }
    return _classifyModel;
}

@end
