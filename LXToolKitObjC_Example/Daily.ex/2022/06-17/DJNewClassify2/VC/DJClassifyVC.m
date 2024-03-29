//
//  DJClassifyVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJClassifyVC.h"

#import <JXCategoryView/JXCategoryView.h>

#import "DJO2OClassifyWrapperVC.h"
#import "DJB2CClassifyWrapperVC.h"
#import "DJClassifySkeletonScreen.h"
#import "DJClassifyEmptyView.h"
#import "DJClassifyVM.h"
#import <DJGlobalStoreManager/DJStoreManager.h>
#import "DJClassifyMacro.h"
#import "TXScrollLabelView.h"

#define kCategoryHeight kWPercentage(44.f)

@interface DJClassifyVC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate, TXScrollLabelViewDelegate> {
    BOOL __navigationBarHidden;
}
@property(nonatomic, strong)UIView *panelTopView;
/// 「即时达」
@property(nonatomic, strong)TXScrollLabelView *tfSearch;
/// 「即时达 + 超市精选」
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)NSArray *titles;
/// 「超市精选」
@property(nonatomic, strong)UILabel *labJingXuan;
@property(nonatomic, strong)UIButton *btnSearch;

@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic, strong)UIView *separateLineView;
@property(nonatomic, strong)DJClassifySkeletonScreen *classifySkeletonScreen;
@property(nonatomic, strong)DJClassifyEmptyView *emptyView;
/// 页面状态
@property(nonatomic, assign)DJViewStatus viewStatus;
@property(nonatomic, strong)DJClassifyVM *b2cVM;
/// 顶部搜索资源位🔍数据
@property(nonatomic, strong)DJShopResourceModel *searchResourceModel;
@end

@implementation DJClassifyVC
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
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
    self.navigationController.navigationBar.hidden = YES;
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
    self.view.backgroundColor = [UIColor whiteColor];

    [self prepareUI];
    [self bindVM];
    self.viewStatus = DJViewStatusLoading;
    [self.b2cVM loadShopResource];
    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    if (gStore.djModuleType == FIRSTMEDICINE) {
        [self.b2cVM loadO2OSearch];
    }
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)bindVM {
    @weakify(self)
    [self.b2cVM.shopResourseSubject subscribeNext:^(DJShopResourceModel *shopResourceModel) {
        @strongify(self)
        // self.viewStatus = DJViewStatusNormal;
        DJOnlineDeployList *onlineDeployItem = shopResourceModel.onlineDeployList.firstObject;
        NSMutableArray *titleList = [NSMutableArray array];
        DJStoreManager *gStore = [DJStoreManager sharedInstance];
        self.tfSearch.hidden = YES;
        self.categoryView.hidden = YES;
        self.btnSearch.hidden = YES;
        self.labJingXuan.hidden = YES;
        if (gStore.djModuleType == FIRSTMEDICINE) {
            self.tfSearch.hidden = NO;

            NSString *picDesc1 = onlineDeployItem.picDesc1;
            if(isEmptyString(picDesc1)) {
                picDesc1 = @"即时达";
            }
            [titleList addObject:picDesc1];
        }else {
            if (gStore.djHomeStyle == LIANHUA) {
                self.labJingXuan.hidden = NO;
                self.btnSearch.hidden = NO;

                NSString *picDesc2 = onlineDeployItem.picDesc2;
                if(isEmptyString(picDesc2)) {
                    picDesc2 = @"优选市集";
                }
                [titleList addObject:picDesc2];
                self.labJingXuan.text = picDesc2;
            }else {
                self.categoryView.hidden = NO;
                self.btnSearch.hidden = NO;

                NSString *picDesc1 = onlineDeployItem.picDesc1;
                if(isEmptyString(picDesc1)) {
                    picDesc1 = @"即时达";
                }
                [titleList addObject:picDesc1];
                NSString *picDesc2 = onlineDeployItem.picDesc2;
                if(isEmptyString(picDesc2)) {
                    picDesc2 = @"优选市集";
                }
                [titleList addObject:picDesc2];
                self.labJingXuan.text = picDesc2;
            }
        }
        self.titles = [titleList copy];
        self.categoryView.titles = self.titles;
        // if(titleList.count == 1) {
        //     self.categoryView.hidden = YES;
        //     self.tfSearch.hidden = NO;
        // } else {
        //     self.categoryView.hidden = NO;
        //     self.tfSearch.hidden = YES;
        // }
        [self.categoryView reloadData];
        [self.listContainerView reloadData];
        self.viewStatus = DJViewStatusNormal;
    }];
    [self.b2cVM.shopResourseErrorSubject subscribeNext:^(id x) {
        @strongify(self)
        self.viewStatus = DJViewStatusOffline;
    }];
    [self.b2cVM.o2oSearchSubject subscribeNext:^(DJShopResourceModel *x) {
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
        DJO2OClassifyWrapperVC *vc = [[DJO2OClassifyWrapperVC alloc]init];
        vc.b2cVM = self.b2cVM;
        return vc;
    } else {
        DJB2CClassifyWrapperVC *vc = [[DJB2CClassifyWrapperVC alloc]init];
        vc.b2cVM = self.b2cVM;
        // vc.toggleSkeletonScreenBlock = ^(BOOL isHidden) {
        //     @strongify(self)
        //     self.classifySkeletonScreen.hidden = isHidden;
        // };
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

    [self.panelTopView addSubview:self.tfSearch];
    [self.categoryView addSubview:self.separateLineView];
    [self.panelTopView addSubview:self.btnSearch];
    [self.panelTopView addSubview:self.categoryView];
    [self.panelTopView addSubview:self.labJingXuan];
    [self.view addSubview:self.panelTopView];

    [self.view addSubview:self.listContainerView];
    [self.view addSubview:self.classifySkeletonScreen];
    [self.view addSubview:self.emptyView];

    [self masonry];
}
#pragma mark getter / setter
- (void)setViewStatus:(DJViewStatus)viewStatus {
    if(_viewStatus == viewStatus) {
        return;
    }
    _viewStatus = viewStatus;

    self.emptyView.hidden = YES;
    self.classifySkeletonScreen.hidden = YES;
    switch (viewStatus) {
        case DJViewStatusUnknown:
            break;
        case DJViewStatusNormal:
            break;
        case DJViewStatusLoading:
            self.classifySkeletonScreen.hidden = NO;
            break;
        case DJViewStatusNoData:
            self.emptyView.hidden = NO;
            [self.emptyView dataFillEmptyStyle];
            break;
        case DJViewStatusOffline:
            self.emptyView.hidden = NO;
            [self.emptyView dataFillOfflineStyle];
            break;
    }
}
#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.categoryView)
    [self.classifySkeletonScreen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
    [self.panelTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.xl_safeAreaLayoutGuideTop);
        make.left.right.equalTo(@0.f);
        make.height.equalTo(@(kCategoryHeight));
    }];
    [self.tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kWPercentage(15.f)));
        make.right.equalTo(@(kWPercentage(-15.f)));
        make.centerY.equalTo(@0.f);
        make.height.equalTo(@(kWPercentage(32.f)));
    }];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
    [self.separateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.categoryView);
        make.width.equalTo(@0.5f);
        make.height.equalTo(@(kWPercentage(14.f)));
    }];
    [self.btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(kWPercentage(-15.f)));
        make.centerY.equalTo(@0.f);
        make.width.height.equalTo(@(kWPercentage(23.f)));
    }];
    [self.labJingXuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0.f);
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.panelTopView.mas_bottom);
        make.left.right.equalTo(@0.f);
        make.bottom.equalTo(@(kWPercentage(-50.f)));
        // make.edges.equalTo(@0.f);
    }];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UIView *)panelTopView {
    if(!_panelTopView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xF9F9F9];
        _panelTopView = v;
    }
    return _panelTopView;
}
// - (UITextField *)tfSearch {
//     if(!_tfSearch){
//         //<UITextFieldDelegate>
//         UITextField *tf = [[UITextField alloc]init];
//         tf.placeholder = @"牛奶";
//         tf.returnKeyType = UIReturnKeyDone;
//         tf.keyboardType = UIKeyboardTypeDefault;
//         tf.layer.cornerRadius = kWPercentage(16.f);
//         tf.layer.borderColor = [UIColor colorWithHex:0xFF774F].CGColor;
//         tf.layer.borderWidth = 1.f;
//
//         UIImageView *imgView = [[UIImageView alloc]init];
//         imgView.image = [iBLImage imageNamed:@"icon_classify_search"];
//         imgView.frame = CGRectMake(kWPercentage(15.f), kWPercentage(9.f), kWPercentage(14.f), kWPercentage(14.f));
//         UIView *leftView = [[UIView alloc]init];
//         leftView.frame = CGRectMake(0, 0, kWPercentage(39.f), kWPercentage(32.f));
//         [leftView addSubview:imgView];
//         tf.leftView = leftView;
//         tf.leftViewMode = UITextFieldViewModeAlways;
//
//         _tfSearch = tf;
//     }
//     return _tfSearch;
// }
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
        v.delegate = self;

        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.image = [iBLImage imageNamed:@"icon_classify_search"];
        imgView.frame = CGRectMake(kWPercentage(15.f), kWPercentage(9.f), kWPercentage(14.f), kWPercentage(14.f));
        [v addSubview:imgView];

        _tfSearch = v;
    }
    return _tfSearch;
}
- (UILabel *)labJingXuan {
    if(!_labJingXuan){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont boldSystemFontOfSize:kWPercentage(16.f)];
        label.textColor = [UIColor colorWithHex:0x333333];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labJingXuan = label;
    }
    return _labJingXuan;
}
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
        v.hidden = YES;

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
        btn.backgroundColor = [UIColor clearColor];

        [btn setBackgroundImage:[iBLImage imageNamed:@"icon_classify_search"] forState:UIControlStateNormal];
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
- (DJClassifySkeletonScreen *)classifySkeletonScreen {
    if(!_classifySkeletonScreen){
        DJClassifySkeletonScreen *v = [[DJClassifySkeletonScreen alloc]init];
        v.hidden = YES;
        _classifySkeletonScreen = v;
    }
    return _classifySkeletonScreen;
}
- (DJClassifyVM *)b2cVM {
    if(!_b2cVM){
        DJClassifyVM *v = [[DJClassifyVM alloc]init];
        _b2cVM = v;
    }
    return _b2cVM;
}
- (DJClassifyEmptyView *)emptyView {
    if(!_emptyView){
        DJClassifyEmptyView *v = [[DJClassifyEmptyView alloc]init];
        v.hidden = YES;
        _emptyView = v;
    }
    return _emptyView;
}
@end
