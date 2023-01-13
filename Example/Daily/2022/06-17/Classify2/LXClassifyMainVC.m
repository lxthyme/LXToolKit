//
//  LXClassifyMainVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/29.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyMainVC.h"

#import "LXClassifyList2VC.h"

@interface LXClassifyMainVC()<JXPagerViewDelegate,JXCategoryViewDelegate, JXPagerMainTableViewGestureDelegate> {
}
@property(nonatomic, strong)JXCategoryTitleView *categoryView;
@property(nonatomic, strong)JXPagerView *pagerView;
@property (nonatomic, strong) NSArray<NSString *> *titles;

@end

@implementation LXClassifyMainVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // NSLog(@"🛠viewWillAppear: %@", NSStringFromClass([self class]));
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    // NSLog(@"🛠viewDidAppear: %@", NSStringFromClass([self class]));
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    // NSLog(@"🛠viewWillDisappear: %@", NSStringFromClass([self class]));
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    // NSLog(@"🛠viewDidDisappear: %@", NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    [self prepareUI];
    [self dataFill];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.pagerView.frame = self.view.bounds;
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill {
    self.titles = @[@"即时达配送", @"超市精选"];
    self.categoryView.titles = self.titles;
    self.categoryView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    self.navigationItem.titleView = self.categoryView;
    [self.categoryView reloadData];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXPagerViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return [UIView new];
}
- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return 0.f;
}
- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return 0.f;
}
- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return [UIView new];
}
- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.titles.count;
}
- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    LXClassifyList2VC *vc = [[LXClassifyList2VC alloc]init];
    return vc;
}

#pragma mark -
#pragma mark - ✈️JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark -
#pragma mark - ✈️JXPagerMainTableViewGestureDelegate
- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([self checkIsNestContentScrollView:(UIScrollView *)gestureRecognizer.view] || [self checkIsNestContentScrollView:(UIScrollView *)otherGestureRecognizer.view]) {
        //如果交互的是嵌套的contentScrollView，证明在左右滑动，就不允许同时响应
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

- (BOOL)checkIsNestContentScrollView:(UIScrollView *)scrollView {
    for (LXClassifyList2VC *list in self.pagerView.validListDict.allValues) {
        if (list.contentScrollView == scrollView) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = false;
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);

    // TODO: 「lxthyme」💊
    // self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
    [self.view addSubview:self.pagerView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (JXCategoryTitleView *)categoryView {
    if(!_categoryView){
        JXCategoryTitleView *v = [[JXCategoryTitleView alloc]init];
        v.delegate = self;
        v.titleSelectedColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
        v.titleColor = [UIColor blackColor];
        v.titleColorGradientEnabled = YES;
        v.titleLabelZoomEnabled = YES;
        v.titleLabelZoomScale = 1.2;

        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
        lineView.indicatorWidth = 30;
        v.indicators = @[lineView];

        _categoryView = v;
    }
    return _categoryView;
}
- (JXPagerView *)pagerView {
    if(!_pagerView){
        // TODO: 「lxthyme」💊
        JXPagerView *v = [[JXPagerView alloc]initWithDelegate:self];
        // [[JXPagerView alloc]initWithDelegate:self listContainerType:JXPagerListContainerType_CollectionView];
        v.mainTableView.gestureDelegate = self;
        v.mainTableView.bounces = NO;
        _pagerView = v;
    }
    return _pagerView;
}

@end
