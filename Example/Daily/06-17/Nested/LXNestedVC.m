//
//  LXNestedVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXNestedVC.h"

#import <Masonry/Masonry.h>
#import <JXCategoryView/JXCategoryView.h>
#import <JXPagingView/JXPagerListRefreshView.h>
#import "LXHeaderView.h"
#import "LXNestedListVC.h"

static const CGFloat JXTableHeaderViewHeight = 200;
static const CGFloat JXheightForHeaderInSection = 50;

@interface LXNestedVC()<JXCategoryViewDelegate, JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate> {
}
@property (nonatomic, strong)JXPagerListRefreshView *pagerView;
@property (nonatomic, strong)LXHeaderView *headerView;
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)NSArray <NSString *> *titles;

@end

@implementation LXNestedVC
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
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.pagerView.frame = self.view.bounds;
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (BOOL)checkIsNestContentScrollView:(UIScrollView *)scrollView {
    for (LXNestedListVC *list in self.pagerView.validListDict.allValues) {
        if (list.contentScrollView == scrollView) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - ✈️JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}
-(void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {}
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {}

#pragma mark -
#pragma mark - ✈️JXPagerViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.headerView;
}
- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return JXTableHeaderViewHeight;
}
- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return JXheightForHeaderInSection;
}
- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}
- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.titles.count;
}
- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    LXNestedListVC *vc = [[LXNestedListVC alloc]init];
    return vc;
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


#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人中心";
    self.navigationController.navigationBar.translucent = false;
    self.titles = @[@"主题一", @"主题二", @"主题三"];

    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);

    [self.view addSubview:self.pagerView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    // [self.pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.edges.equalTo(@0.f);
    // }];
}

#pragma mark Lazy Property
- (LXHeaderView *)headerView {
    if(!_headerView){
        LXHeaderView *v = [[LXHeaderView alloc]init];
        v.frame = CGRectMake(0, 0, SCREEN_WIDTH, JXTableHeaderViewHeight);
        _headerView = v;
    }
    return _headerView;
}
- (JXCategoryTitleView *)categoryView {
    if(!_categoryView){
        JXCategoryTitleView *v = [[JXCategoryTitleView alloc]init];
        v.frame = CGRectMake(0, 50, SCREEN_WIDTH, 50);
        v.backgroundColor = [UIColor greenColor];
        v.titles = self.titles;
        v.delegate = self;
        v.titleSelectedColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
        v.titleColor = [UIColor blackColor];
        v.titleColorGradientEnabled = YES;
        v.titleLabelZoomEnabled = YES;
        v.titleLabelZoomScale = 1.2f;

        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
        lineView.indicatorWidth = 30;
        v.indicators = @[lineView];

        v.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;

        _categoryView = v;
    }
    return _categoryView;
}
- (JXPagerListRefreshView *)pagerView {
    if(!_pagerView){
        JXPagerListRefreshView *v = [[JXPagerListRefreshView alloc]initWithDelegate:self];
        v.mainTableView.gestureDelegate = self;
        _pagerView = v;
    }
    return _pagerView;
}
@end
