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

#import "DJGoodsItemModel.h"
#import "LXClassifyListVC.h"
#import "LXThirdCategoryView.h"
#import "LXB2CClassifyVM.h"
#import "LXClassifyRightVCModel.h"

#define kB2CCategoryViewHeight kWPercentage(48.5f)
static const CGFloat kLabelAllWidth = 35.f;

@interface LXB2CClassifyWrapperVC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate/**, JXCategoryViewListContainer*/> {
}
@property(nonatomic, strong)YYLabel *labAll;
@property (nonatomic, strong)LXThirdCategoryView *categoryView;
@property (nonatomic, strong)LXThirdCategoryView *allCategoryView;
@property(nonatomic, strong)UIImageView *imgViewShadowLeft;
@property(nonatomic, strong)UIImageView *imgViewShadowRight;
@property (nonatomic, strong)UIControl *allMaskView;
@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic, strong)LXClassifyModel *classifyModel;
@property(nonatomic, strong)NSMutableDictionary<NSNumber *, LXClassifyListVC *> *classifyVCList;
@property(nonatomic, strong)LXB2CClassifyVM *b2cVM;

@end

@implementation LXB2CClassifyWrapperVC
#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // NSLog(@"🛠viewWillAppear: %@", NSStringFromClass([self class]));
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    // NSLog(@"🛠viewDidAppear: %@", NSStringFromClass([self class]));
    // self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    // NSLog(@"🛠viewWillDisappear: %@", NSStringFromClass([self class]));
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    // NSLog(@"🛠viewDidDisappear: %@", NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    [self prepareVM];
    [self prepareUI];
    [self bindVM];
    // [self loadData];
    [IBLProgressHud showInView:self.view];
    [self.b2cVM loadProductSearchDoCategoryByLevOne];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)bindVM {
    @weakify(self)
    [self.b2cVM.productSearchDoCategoryByLevOneSubject subscribeNext:^(NSArray<LXLHCategoryModel *> *categoryModelList) {
        @strongify(self)
        NSLog(@"categoryModelList: %@", categoryModelList);
        [self.categoryView dataFill:categoryModelList];
        [self.allCategoryView dataFill:categoryModelList];
        /// 一级级目录数据结构
        NSMutableDictionary<NSString *, LXClassifyListModel *> *classifyListModel = [NSMutableDictionary dictionary];
        [categoryModelList enumerateObjectsUsingBlock:^(LXLHCategoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            /// 二级级目录数据结构
            NSMutableDictionary<NSString *, LXClassifyRightModel *> *rightListModel = [NSMutableDictionary dictionary];
            [obj.categorys enumerateObjectsUsingBlock:^(LXLHCategoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                LXClassifyRightModel *tmp = [[LXClassifyRightModel alloc]init];
                if(idx == 0) {
                    tmp.f_idxType = LXSubCategoryIndexTypeFirst;
                } else if(idx == obj.categorys.count - 1) {
                    tmp.f_idxType = LXSubCategoryIndexTypeLast;
                }
                rightListModel[obj.categoryId] = tmp;
            }];
            LXClassifyListModel *tmp = [[LXClassifyListModel alloc]init];
            tmp.categorys = obj.categorys;
            tmp.rightListModel = [rightListModel copy];
            classifyListModel[obj.categoryId] = tmp;
        }];
        self.classifyModel.categorys = categoryModelList;
        self.classifyModel.classifyListModel = [classifyListModel copy];
        [self.listContainerView reloadData];
        // [self.classifyVCList enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, LXClassifyListVC * _Nonnull obj, BOOL * _Nonnull stop) {
        //     NSInteger idx = [key integerValue];
        //     LXLHCategoryModel *categoryModel = categoryModelList[idx];
        //     [obj dataFill:categoryModel];
        // }];
    } error:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
    [[RACSignal combineLatest:@[
        self.b2cVM.productSearchDoCategoryByLevOneSubject,
        // self.b2cVM.v2SearchForLHApiSubject
    ]]
     subscribeNext:^(id x) {
        @strongify(self)
        NSLog(@"[all]1. subscribeNext: ");
        [IBLProgressHud dismissAllForView:self.view];
    } error:^(NSError *error) {
        @strongify(self)
        NSLog(@"[all]2. 请求报错: %@", error);
        [IBLProgressHud dismissAllForView:self.view];
    } completed:^{
        NSLog(@"[all]3. 请求完成!");
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
    [self dismissFirstCategoryView];
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
    return self.classifyModel.categorys.count;
}
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    LXClassifyListVC *vc = self.classifyVCList[@(index)];
    if(!vc) {
        vc = [[LXClassifyListVC alloc]init];
        vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
        self.classifyVCList[@(index)] = vc;
    }
    LXLHCategoryModel *categoryModel = self.classifyModel.categorys[index];
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

    [self masonry];
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
            [weakSelf showFirstCategoryView];
        };

        _labAll = lab;
    }
    return _labAll;
}
- (LXThirdCategoryView *)categoryView {
    if(!_categoryView){
        LXThirdCategoryView *v = [[LXThirdCategoryView alloc]init];
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
                if(idx >= 0 && idx < weakSelf.classifyModel.categorys.count) {
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


- (LXThirdCategoryView *)allCategoryView {
    if(!_allCategoryView){
        LXThirdCategoryView *v = [[LXThirdCategoryView alloc]init];
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
                if(idx >= 0 && idx < weakSelf.classifyModel.categorys.count) {
                    [weakSelf dismissFirstCategoryView];
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
- (LXB2CClassifyVM *)b2cVM {
    if(!_b2cVM){
        LXB2CClassifyVM *v = [[LXB2CClassifyVM alloc]init];
        _b2cVM = v;
    }
    return _b2cVM;
}
- (LXClassifyModel *)classifyModel {
    if(!_classifyModel){
        LXClassifyModel *v = [[LXClassifyModel alloc]init];
        _classifyModel = v;
    }
    return _classifyModel;
}

@end
