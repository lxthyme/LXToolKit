//
//  DJNewClassifyVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/8/5.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJNewClassifyVC.h"

#import <Masonry/Masonry.h>
#import <DJGlobalStoreManager/DJStoreManager.h>
#import "DJO2OClassifyVC.h"
#import "DJB2CClassifyVC.h"
#import "DJClassifyVM.h"
#import "DJClassifyHeaderView.h"
#import "TXScrollLabelView.h"

@interface DJNewClassifyVC()<TXScrollLabelViewDelegate> {
    BOOL __navigationBarHidden;
}
@property(nonatomic, strong)UIStackView *containerStackView;
@property(nonatomic, strong)DJClassifyHeaderView *headerView;
/// 「即时达」
@property(nonatomic, strong)TXScrollLabelView *tfSearch;
@property(nonatomic, strong)UIView *panelTopView;
@property(nonatomic, strong)UIView *wrapperView;
@property(nonatomic, strong)UIPageViewController *pageVC;
@property(nonatomic, strong)DJO2OClassifyVC *o2oVC;
@property(nonatomic, strong)DJB2CClassifyVC *b2cVC;

@property(nonatomic, strong)DJClassifyVM *classifyVM;
/// 顶部搜索资源位🔍数据
@property(nonatomic, strong)DJShopResourceModel *searchResourceModel;

@end

@implementation DJNewClassifyVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // NSLog(@"🛠viewWillAppear: %@", NSStringFromClass([self class]));
    __navigationBarHidden = self.navigationController.navigationBarHidden;
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    // NSLog(@"🛠viewDidAppear: %@", NSStringFromClass([self class]));
    // self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
    self.navigationController.navigationBar.hidden = YES;
    /// 更新购物车数据
    [self.classifyVM.shopCartVM loadQueryCart];
    // DJStoreManager *gStore = [DJStoreManager sharedInstance];
    // if(![self.classifyVM.shopId isEqualToString:gStore.shopId]) {
    //     self.viewStatus = DJViewStatusLoading;
    //     [self.classifyVM loadShopResource];
    //     if (gStore.djModuleType == FIRSTMEDICINE) {
    //         [self.classifyVM loadO2OSearch];
    //     }
    // }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    // NSLog(@"🛠viewWillDisappear: %@", NSStringFromClass([self class]));
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    // self.navigationController.navigationBar.hidden = __navigationBarHidden;
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
    [self prepareVM];
    [self.classifyVM loadShopResource];
    [self bindVM];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)bindVM {
    @weakify(self)
    [self.classifyVM.shopResourseSubject subscribeNext:^(DJShopResourceModel *x) {
        @strongify(self)
        DJStoreManager *gStore = [DJStoreManager sharedInstance];
        DJOnlineDeployList *onlineDeployItem = x.onlineDeployList.firstObject;
        NSString *o2oTitle = @"";
        NSString *b2cTitle = @"";

        self.tfSearch.hidden = YES;
        self.headerView.hidden = YES;
        if (gStore.djModuleType == FIRSTMEDICINE) {
            o2oTitle = onlineDeployItem.picDesc1;
            if(isEmptyString(o2oTitle)) {
                o2oTitle = @"即时达";
            }

            self.tfSearch.hidden = NO;
            [self.classifyVM loadO2OSearch];
        }else {
            if (gStore.djHomeStyle == LIANHUA) {
                b2cTitle = onlineDeployItem.picDesc2;
                if(isEmptyString(b2cTitle)) {
                    b2cTitle = @"优选市集";
                }

                self.headerView.hidden = NO;
            }else {
                o2oTitle = onlineDeployItem.picDesc1;
                if(isEmptyString(o2oTitle)) {
                    o2oTitle = @"即时达";
                }
                b2cTitle = onlineDeployItem.picDesc2;
                if(isEmptyString(b2cTitle)) {
                    b2cTitle = @"优选市集";
                }

                self.headerView.hidden = NO;
            }
        }
        [self.headerView dataFill:o2oTitle b2cTitle:b2cTitle];
        // self.titles = [titleList copy];
    }];
    [self.classifyVM.o2oSearchSubject subscribeNext:^(DJShopResourceModel *x) {
        self.searchResourceModel = x;
        NSArray *titleList = [[x.onlineDeployList.rac_sequence map:^id(DJOnlineDeployList *value) {
            return value.picDesc1;
        }] filter:^BOOL(NSString *value) {
            return !isEmptyString(value);
        }].array;
        if(titleList.count <= 0) {
            titleList = @[@"搜索您想买的商品"];
        }
        [self.tfSearch changeTextArray:titleList
                                  type:TXScrollLabelViewTypeFlipNoRepeat
                              velocity:2
                               options:UIViewAnimationOptionCurveEaseInOut
                                 inset:UIEdgeInsetsMake(kWPercentage(8), kWPercentage(40.f), 0, 0)];
        self.tfSearch.frame = CGRectMake(kWPercentage(15.f), kWPercentage(6.f), SCREEN_WIDTH - kWPercentage(15.f * 2), kWPercentage(32.f));
        if(titleList.count > 1) {
            [self.tfSearch beginScrolling];
        } else {
            [self.tfSearch beginScrolling];
            [self.tfSearch endScrolling];
        }
    }];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️TXScrollLabelViewDelegate
- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index {
    if(index < self.searchResourceModel.onlineDeployList.count) {
        DJOnlineDeployList *deployItem = self.searchResourceModel.onlineDeployList[index];
    }
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareVM {
    @weakify(self)
    [[RACObserve(self.headerView, headerType)
      distinctUntilChanged]
     subscribeNext:^(NSNumber *x) {
        @strongify(self)
        switch ([x integerValue]) {
            case DJNewClassifyHeaderTypeO2O: {
                [self.pageVC setViewControllers:@[self.o2oVC] direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:YES
                                     completion:nil];
            }
                break;
            case DJNewClassifyHeaderTypeB2C: {
                [self.pageVC setViewControllers:@[self.b2cVC] direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
            }
                break;
        }
    }];
    [[[self.headerView.btnSearch rac_signalForControlEvents:UIControlEventTouchUpInside]
            throttle:0.2]
    subscribeNext:^(id x) {
        NSLog(@"x: 搜索");
    }];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self addChildViewController:self.o2oVC];
    [self.pageVC setViewControllers:@[self.o2oVC]
                          direction:UIPageViewControllerNavigationDirectionForward
                           animated:YES
                         completion:nil];

    [self.panelTopView addSubview:self.headerView];
    [self.panelTopView addSubview:self.tfSearch];
    [self.containerStackView addArrangedSubview:self.panelTopView];

    [self.wrapperView addSubview:self.pageVC.view];
    [self.containerStackView addArrangedSubview:self.wrapperView];
    [self.view addSubview:self.containerStackView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.containerStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.xl_safeAreaLayoutGuideTop);
        make.left.right.bottom.equalTo(@0.f);
    }];
    [self.panelTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(kWPercentage(44.f)));
    }];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
    [self.tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kWPercentage(15.f)));
        make.right.equalTo(@(kWPercentage(-15.f)));
        make.centerY.equalTo(@0.f);
        make.height.equalTo(@(kWPercentage(32.f)));
    }];
    [self.pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (DJClassifyVM *)classifyVM {
    if(!_classifyVM){
        DJClassifyVM *v = [[DJClassifyVM alloc]init];
        _classifyVM = v;
    }
    return _classifyVM;
}
- (UIStackView *)containerStackView {
    if(!_containerStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisVertical;
        sv.spacing = 0.f;
        _containerStackView = sv;
    }
    return _containerStackView;
}
- (UIView *)panelTopView {
    if(!_panelTopView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xF9F9F9];
        _panelTopView = v;
    }
    return _panelTopView;
}
- (DJClassifyHeaderView *)headerView {
    if(!_headerView){
        DJClassifyHeaderView *v = [[DJClassifyHeaderView alloc]init];
        v.hidden = YES;
        _headerView = v;
    }
    return _headerView;
}
- (TXScrollLabelView *)tfSearch {
    if(!_tfSearch){
        TXScrollLabelView *v = [[TXScrollLabelView alloc]
                                initWithTitle:@"搜索您想买的商品"
                                type:TXScrollLabelViewTypeFlipNoRepeat
                                velocity:2
                                options:UIViewAnimationOptionCurveEaseInOut
                                inset:UIEdgeInsetsMake(kWPercentage(8), kWPercentage(40.f), 0, 0)];
        v.backgroundColor = [UIColor whiteColor];
        v.layer.cornerRadius = kWPercentage(16.f);
        v.layer.borderColor = [UIColor colorWithHex:0xFF774F].CGColor;
        v.layer.borderWidth = 1.f;
        v.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
        v.scrollTitleColor = [UIColor colorWithHex:0x999999];
        v.hidden = YES;
        v.delegate = self;

        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.image = [iBLImage imageNamed:@"icon_classify_search"];
        imgView.frame = CGRectMake(kWPercentage(15.f), kWPercentage(9.f), kWPercentage(14.f), kWPercentage(14.f));
        [v addSubview:imgView];

        _tfSearch = v;
    }
    return _tfSearch;
}
- (UIView *)wrapperView {
    if(!_wrapperView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        _wrapperView = v;
    }
    return _wrapperView;
}
- (UIPageViewController *)pageVC {
    if(!_pageVC){
        UIPageViewController *v = [[UIPageViewController alloc]
                                   initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                   navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                   options:@{
            UIPageViewControllerOptionInterPageSpacingKey: @0.f
        }];
        v.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
        // v.delegate = self;
        // v.dataSource = self;
        _pageVC = v;
    }
    return _pageVC;
}
- (DJO2OClassifyVC *)o2oVC {
    if(!_o2oVC){
        DJO2OClassifyVC *vc = [[DJO2OClassifyVC alloc]init];
        vc.classifyVM = self.classifyVM;
        _o2oVC = vc;
    }
    return _o2oVC;
}
- (DJB2CClassifyVC *)b2cVC {
    if(!_b2cVC){
        DJB2CClassifyVC *vc = [[DJB2CClassifyVC alloc]init];
        vc.classifyVM = self.classifyVM;
        _b2cVC = vc;
    }
    return _b2cVC;
}
@end
