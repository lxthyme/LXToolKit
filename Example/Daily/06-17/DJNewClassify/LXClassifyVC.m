//
//  LXClassifyVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyVC.h"

#import <JXCategoryView/JXCategoryView.h>

#import "LXClassifyWrapperVC.h"
#import "LXB2CClassifyWrapperVC.h"

static const CGFloat kCategoryHeight = 44.f;

@interface LXClassifyVC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate> {
    BOOL __navigationBarHidden;
}
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)NSArray *titles;
@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic, strong)UIButton *btnSearch;
@property(nonatomic, strong)UIView *separateLineView;
@end

@implementation LXClassifyVC
#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // NSLog(@"🛠viewWillAppear: %@", NSStringFromClass([self class]));
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    // NSLog(@"🛠viewDidAppear: %@", NSStringFromClass([self class]));
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
    __navigationBarHidden = self.navigationController.navigationBarHidden;
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    // NSLog(@"🛠viewWillDisappear: %@", NSStringFromClass([self class]));
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    // NSLog(@"🛠viewDidDisappear: %@", NSStringFromClass([self class]));
    self.navigationController.navigationBarHidden = __navigationBarHidden;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self prepareUI];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

#pragma mark -
#pragma mark - ✈️JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    [self.listContainerView didClickSelectedItemAtIndex:index];
    // [weakSelf.listContainerView.scrollView setContentOffset:CGPointMake(idx * weakSelf.listContainerView.scrollView.bounds.size.width, 0) animated:YES];
    // self.listContainerView select
}

#pragma mark -
#pragma mark - ✈️JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if(index == 0) {
        LXClassifyWrapperVC *vc = [[LXClassifyWrapperVC alloc]init];
        vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300.f);
        return vc;
    } else {
        LXB2CClassifyWrapperVC *vc = [[LXB2CClassifyWrapperVC alloc]init];
        vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300.f);
        return vc;
    }
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.hidesBackButton = YES;

    self.titles = @[@"即时达配送", @"超市精选"];
    self.categoryView.titles = self.titles;
    // TODO: 「lxthyme」💊
    // self.categoryView.listContainer = self.listContainerView;
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
    // self.categoryView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    // self.navigationItem.titleView = self.categoryView;

    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.separateLineView];
    [self.view addSubview:self.btnSearch];
    [self.view addSubview:self.listContainerView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.categoryView)
    MASViewAttribute *topAttribute = self.view.mas_top;
    if (@available(iOS 11.0, *)) {
        topAttribute = self.view.mas_safeAreaLayoutGuideTop;
    }
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.top.equalTo(self.view);
        make.top.equalTo(topAttribute);
        make.left.right.equalTo(@0.f);
        make.height.equalTo(@(kCategoryHeight));
    }];
    [self.separateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.categoryView);
        make.width.equalTo(@0.5f);
        make.height.equalTo(@(kWPercentage(14.f)));
    }];
    [self.btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(kWPercentage(-15.f)));
        make.centerY.equalTo(self.categoryView);
        make.width.height.equalTo(@(kWPercentage(23.f)));
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom);
        make.left.right.equalTo(@0.f);
        make.bottom.equalTo(@(kWPercentage(-50.f)));
        // make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (JXCategoryTitleView *)categoryView {
    if(!_categoryView){
        JXCategoryTitleView *v = [[JXCategoryTitleView alloc]init];
        v.averageCellSpacingEnabled = YES;
        v.backgroundColor = [UIColor colorWithHex:0xF9F9F9];
        v.titleFont = [UIFont boldSystemFontOfSize:kWPercentage(14.f)];
        v.titleSelectedFont = [UIFont boldSystemFontOfSize:kWPercentage(16.f)];
        v.titleColor = [UIColor colorWithHex:0x666666];
        v.titleSelectedColor = [UIColor colorWithHex:0x333333];
        v.delegate = self;

        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = [UIColor colorWithHex:0xFF774F];
        lineView.indicatorHeight = kWPercentage(3.5f);
        lineView.indicatorCornerRadius = kWPercentage(3.5f / 2.f);
        lineView.indicatorWidthIncrement = -kWPercentage(10.f);
        v.indicators = @[lineView];

        _categoryView = v;
    }
    return _categoryView;
}
- (JXCategoryListContainerView *)listContainerView {
    if(!_listContainerView){
        JXCategoryListContainerView *v = [[JXCategoryListContainerView alloc]initWithDelegate:self];
        v.frame = CGRectMake(0, kCategoryHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kCategoryHeight);
        // TODO: 「lxthyme」💊
        // [[JXCategoryListContainerView alloc]initWithType:JXCategoryListContainerType_CollectionView delegate:self];
        // v.scrollView.scrollEnabled = NO;
        _listContainerView = v;
    }
    return _listContainerView;
}
- (UIButton *)btnSearch {
    if(!_btnSearch){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];

        [btn setBackgroundImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
        _btnSearch = btn;
    }
    return _btnSearch;
}
- (UIView *)separateLineView {
    if(!_separateLineView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xDDDDDD];
        _separateLineView = v;
    }
    return _separateLineView;
}
@end
