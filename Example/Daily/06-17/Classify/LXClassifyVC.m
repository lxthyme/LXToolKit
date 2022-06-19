//
//  LXClassifyVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyVC.h"

#import "LXClassifyWrapperVC.h"

@interface LXClassifyVC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate> {
    BOOL __navigationBarHidden;
}
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)NSArray *titles;
@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;
@end

@implementation LXClassifyVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // NSLog(@"🛠viewWillAppear: %@", NSStringFromClass([self class]));
    __navigationBarHidden = self.navigationController.navigationBarHidden;
    // self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    // NSLog(@"🛠viewDidAppear: %@", NSStringFromClass([self class]));
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
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
}

#pragma mark -
#pragma mark - ✈️JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    LXClassifyWrapperVC *vc = [[LXClassifyWrapperVC alloc]init];
    return vc;
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.hidesBackButton = YES;

    self.titles = @[@"即时达配送", @"超市精选"];
    self.categoryView.titles = self.titles;
    self.categoryView.listContainer = self.listContainerView;
    self.categoryView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    self.navigationItem.titleView = self.categoryView;

    // [self.view addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    // [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
    //     // make.top.equalTo(self.view);
    //     make.top.centerX.equalTo(@0.f);
    //     make.width.equalTo(@200.f);
    //     make.height.equalTo(@44.f);
    // }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.top.equalTo(self.categoryView.mas_bottom);
        // make.left.right.bottom.equalTo(@0.f);
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (JXCategoryTitleView *)categoryView {
    if(!_categoryView){
        JXCategoryTitleView *v = [[JXCategoryTitleView alloc]init];
        v.averageCellSpacingEnabled = YES;
        v.delegate = self;

        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorWidth = 20;
        v.indicators = @[lineView];

        _categoryView = v;
    }
    return _categoryView;
}
- (JXCategoryListContainerView *)listContainerView {
    if(!_listContainerView){
        JXCategoryListContainerView *v = [[JXCategoryListContainerView alloc]initWithType:JXCategoryListContainerType_CollectionView delegate:self];
        _listContainerView = v;
    }
    return _listContainerView;
}
@end
