//
//  LXNest4VC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXNest4VC.h"

#import <JXCategoryView/JXCategoryView.h>
#import "LXHotListView.h"
#import "LXRecommendListView.h"

@interface LXNest4VC()<JXCategoryViewDelegate> {
}
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LXHotListView *hotListView;
@property (nonatomic, strong) LXRecommendListView *recommendListView;

@end

@implementation LXNest4VC
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
#pragma mark - ✈️JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"左右分页布局";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // self.navigationController.navigationBar.translucent = NO;

    self.navigationItem.titleView = self.categoryView;
    self.categoryView.contentScrollView = self.scrollView;
    [self.scrollView addSubview:self.hotListView];
    [self.scrollView addSubview:self.recommendListView];
    [self.view addSubview:self.scrollView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
    [self.hotListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(@0.f);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(SCREEN_HEIGHT));
    }];
    [self.recommendListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(@0.f);
        make.left.equalTo(self.hotListView.mas_left);
        make.width.height.equalTo(self.hotListView);
    }];
}

#pragma mark Lazy Property
- (JXCategoryTitleView *)categoryView {
    if(!_categoryView){
        JXCategoryTitleView *v = [[JXCategoryTitleView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        v.delegate = self;
        v.titleSelectedColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
        v.titleColor = [UIColor blackColor];
        v.titleColorGradientEnabled = YES;
        v.titleLabelZoomEnabled = YES;
        v.titles = @[@"热门", @"推荐"];

        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorLineViewColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
        lineView.indicatorLineWidth = 30;
        v.indicators = @[lineView];

        _categoryView = v;
    }
    return _categoryView;
}
- (UIScrollView *)scrollView {
    if(!_scrollView){
        UIScrollView *sv = [[UIScrollView alloc]init];
        [sv setBackgroundColor:[UIColor whiteColor]];
        [sv setPagingEnabled:YES];
        [sv setBounces:NO];
        _scrollView = sv;
    }
    return _scrollView;
}
- (LXHotListView *)hotListView {
    if(!_hotListView){
        LXHotListView *v = [[LXHotListView alloc]init];
        _hotListView = v;
    }
    return _hotListView;
}
- (LXRecommendListView *)recommendListView {
    if(!_recommendListView){
        LXRecommendListView *v = [[LXRecommendListView alloc]init];
        _recommendListView = v;
    }
    return _recommendListView;
}
@end
