//
//  LXNaHiddenVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXNaHiddenVC.h"

#import <Masonry/Masonry.h>
#import "UIWindow+JXSafeArea.h"
#import <MJRefresh/MJRefresh.h>


@interface LXNaHiddenVC() {
}
@property(nonatomic, strong)UIView *navBgView;
@property(nonatomic, strong)UILabel *labTitle;
@property(nonatomic, strong)UIButton *btnBack;

@end

@implementation LXNaHiddenVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
- (void)btnBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - ✈️JXPagerViewDelegate
- (void)pagerView:(JXPagerView *)pagerView mainTableViewDidScroll:(UIScrollView *)scrollView {
    // CGFloat thresholdDistance = 100;
    // CGFloat percent = scrollView.contentOffset.y / thresholdDistance;
    // percent = MAX(0, MIN(1, percent));
    // self.navBgView.alpha = percent;
    self.navBgView.alpha = 1;
    self.navBgView.hidden = scrollView.contentOffset.y < 40;
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat navHeight = [UIApplication.sharedApplication.keyWindow jx_navigationHeight];
    self.pagerView.pinSectionHeaderVerticalOffset = navHeight;
    WEAKSELF(self)
    self.pagerView.mainTableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.categoryView.titles = @[@"高级能力", @"高级爱好", @"高级队友"];
            self.categoryView.defaultSelectedIndex = 0;
            [self.categoryView reloadData];
            [self.pagerView reloadData];
            [weakSelf.pagerView.mainTableView.mj_header endRefreshing];
        });
    }];

    [self.navBgView addSubview:self.labTitle];
    [self.navBgView addSubview:self.btnBack];
    [self.view addSubview:self.navBgView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    UIEdgeInsets safeMargin = [UIApplication.sharedApplication.keyWindow jx_layoutInsets];
    CGFloat navHeight = [UIApplication.sharedApplication.keyWindow jx_navigationHeight];
    [self.navBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@(navHeight));
    }];
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(safeMargin.top));
        make.centerX.equalTo(@0.f);
        make.height.equalTo(@44.f);
    }];
    [self.btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(safeMargin.top));
        make.left.equalTo(@12.f);
        make.width.height.equalTo(@44.f);
    }];
}

#pragma mark Lazy Property
- (UIView *)navBgView {
    if(!_navBgView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        v.alpha = 0;
        _navBgView = v;
    }
    return _navBgView;
}
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"导航栏隐藏";
        label.textColor = [UIColor blackColor];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        _labTitle = label;
    }
    return _labTitle;
}
- (UIButton *)btnBack {
    if(!_btnBack){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];

        [btn setTitle:@"返回" forState:UIControlStateNormal];

        [btn addTarget:self action:@selector(btnBackClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnBack = btn;
    }
    return _btnBack;
}
@end
