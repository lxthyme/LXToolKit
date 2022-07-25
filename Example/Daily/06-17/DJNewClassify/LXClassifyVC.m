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
#import "LXClassifySkeletonScreen.h"
#import "LXClassifyEmptyView.h"
#import "LXB2CClassifyVM.h"
#import <DJGlobalStoreManager/DJStoreManager.h>
#import "DJClassifyMacro.h"

static const CGFloat kCategoryHeight = 44.f;

@interface LXClassifyVC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate> {
    BOOL __navigationBarHidden;
}
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)NSArray *titles;
@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic, strong)UIButton *btnSearch;
@property(nonatomic, strong)UIView *separateLineView;
@property(nonatomic, strong)LXClassifySkeletonScreen *classifySkeletonScreen;
@property(nonatomic, strong)LXClassifyEmptyView *emptyView;
/// 页面状态
@property(nonatomic, assign)LXViewStatus viewStatus;
@property(nonatomic, strong)LXB2CClassifyVM *b2cVM;
@end

@implementation LXClassifyVC
#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // NSLog(@"🛠viewWillAppear: %@", NSStringFromClass([self class]));
    __navigationBarHidden = self.navigationController.navigationBarHidden;
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    // NSLog(@"🛠viewDidAppear: %@", NSStringFromClass([self class]));
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
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

    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    gStore.djHomeStyle = DAOJIA;

    [self prepareUI];
    [self bindVM];
    self.viewStatus = LXViewStatusLoading;
    [self.b2cVM loadShopResource];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)bindVM {
    @weakify(self)
    [[self.b2cVM.shopResourseSubject delay:1.f] subscribeNext:^(LXShopResourceModel *shopResourceModel) {
        @strongify(self)
        self.viewStatus = LXViewStatusNormal;
        DJOnlineDeployList *onlineDeployItem = shopResourceModel.onlineDeployList.firstObject;
        NSMutableArray *array = [NSMutableArray array];
        DJStoreManager *gStore = [DJStoreManager sharedInstance];
        if (gStore.djModuleType == FIRSTMEDICINE) {
            NSString *picDesc1 = onlineDeployItem.picDesc1;
            if(isEmptyString(picDesc1)) {
                picDesc1 = @"即时达";
            }
            [array addObject:picDesc1];
        }else {
            if (gStore.djHomeStyle == LIANHUA) {
                NSString *picDesc2 = onlineDeployItem.picDesc2;
                if(isEmptyString(picDesc2)) {
                    picDesc2 = @"优选市集";
                }
                [array addObject:picDesc2];
            }else {
                NSString *picDesc1 = onlineDeployItem.picDesc1;
                if(isEmptyString(picDesc1)) {
                    picDesc1 = @"即时达";
                }
                [array addObject:picDesc1];
                NSString *picDesc2 = onlineDeployItem.picDesc2;
                if(isEmptyString(picDesc2)) {
                    picDesc2 = @"优选市集";
                }
                [array addObject:picDesc2];
            }
        }
        self.titles = [array copy];
        self.categoryView.titles = self.titles;
        [self.categoryView reloadData];
        [self.listContainerView reloadData];
        self.classifySkeletonScreen.hidden = YES;
    } error:^(NSError *error) {
        @strongify(self)
        self.viewStatus = LXViewStatusOffline;
    }];
}

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
    @weakify(self)
    if(index == 0) {
        LXClassifyWrapperVC *vc = [[LXClassifyWrapperVC alloc]init];
        return vc;
    } else {
        LXB2CClassifyWrapperVC *vc = [[LXB2CClassifyWrapperVC alloc]init];
        vc.toggleSkeletonScreenBlock = ^(BOOL isHidden) {
            @strongify(self)
            self.classifySkeletonScreen.hidden = isHidden;
        };
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

    // TODO: 「lxthyme」💊
    // self.categoryView.listContainer = self.listContainerView;
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
    // self.categoryView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    // self.navigationItem.titleView = self.categoryView;

    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.separateLineView];
    [self.view addSubview:self.btnSearch];
    [self.view addSubview:self.listContainerView];
    [self.view addSubview:self.classifySkeletonScreen];
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
#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.categoryView)
    MASViewAttribute *topAttribute = self.view.mas_top;
    if (@available(iOS 11.0, *)) {
        topAttribute = self.view.mas_safeAreaLayoutGuideTop;
    }
    [self.classifySkeletonScreen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
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
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
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
- (LXClassifySkeletonScreen *)classifySkeletonScreen {
    if(!_classifySkeletonScreen){
        LXClassifySkeletonScreen *v = [[LXClassifySkeletonScreen alloc]init];
        v.hidden = YES;
        _classifySkeletonScreen = v;
    }
    return _classifySkeletonScreen;
}
- (LXB2CClassifyVM *)b2cVM {
    if(!_b2cVM){
        LXB2CClassifyVM *v = [[LXB2CClassifyVM alloc]init];
        _b2cVM = v;
    }
    return _b2cVM;
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
