//
//  LXNestedListVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "LXNestedListVC.h"
#import "LXNestedListView.h"
#import <JXCategoryView/JXCategoryView.h>

@interface LXNestedListVC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate> {
}
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) UIScrollView *currentListView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@end

@implementation LXNestedListVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self prepareUI];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.categoryView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
    self.listContainerView.frame = CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 50);
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXPagerViewListViewDelegate
- (UIView *)listView {
    return self.view;
}
- (UIScrollView *)listScrollView {
    return self.currentListView;
}
- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}
- (void)listScrollViewWillResetContentOffset {
    //当前的listScrollView需要重置的时候，就把所有列表的contentOffset都重置了
    for (LXNestedListView *view in self.listContainerView.validListDict.allValues) {
        view.tableView.contentOffset = CGPointZero;
    }
}

#pragma mark -
#pragma mark - ✈️JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    LXNestedListView *view = (LXNestedListView *)self.listContainerView.validListDict[@(index)];
    self.currentListView = view.tableView;
}

#pragma mark -
#pragma mark - ✈️JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 3;
}
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    WEAKSELF(self)
    if (index == 0) {
        LXNestedListView *powerListView = [[LXNestedListView alloc] init];
        powerListView.scrollCallback = ^(UIScrollView *scrollView) {
            weakSelf.scrollCallback(scrollView);
        };
        powerListView.dataSource = @[@"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮", @"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮"].mutableCopy;
        self.currentListView = powerListView.tableView;
        return powerListView;
    }else if (index == 1) {
        LXNestedListView *hobbyListView = [[LXNestedListView alloc] init];
        hobbyListView.scrollCallback = ^(UIScrollView *scrollView) {
            weakSelf.scrollCallback(scrollView);
        };
        hobbyListView.dataSource = @[@"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉"].mutableCopy;
        self.currentListView = hobbyListView.tableView;
        return hobbyListView;
    }else {
        LXNestedListView *partnerListView = [[LXNestedListView alloc] init];
        partnerListView.scrollCallback = ^(UIScrollView *scrollView) {
            weakSelf.scrollCallback(scrollView);
        };
        partnerListView.dataSource = @[@"【剑士】罗罗诺亚·索隆", @"【航海士】娜美", @"【狙击手】乌索普", @"【厨师】香吉士", @"【船医】托尼托尼·乔巴", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾"].mutableCopy;
        self.currentListView = partnerListView.tableView;
        return partnerListView;
    }
}


#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    self.contentScrollView = self.listContainerView.scrollView;
    self.categoryView.listContainer = self.listContainerView;
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@50.f);
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom);
        make.left.bottom.right.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (JXCategoryTitleView *)categoryView {
    if(!_categoryView){
        JXCategoryTitleView *v = [[JXCategoryTitleView alloc]init];
        v.titleColorGradientEnabled = YES;
        v.backgroundColor = [UIColor cyanColor];
        v.delegate = self;
        v.titles = @[@"子题一", @"子题二", @"子题三"];
        _categoryView = v;
    }
    return _categoryView;
}
- (JXCategoryListContainerView *)listContainerView {
    if(!_listContainerView){
        JXCategoryListContainerView *v = [[JXCategoryListContainerView alloc]
                                          initWithType:JXCategoryListContainerType_CollectionView
                                          delegate:self];
        _listContainerView = v;
    }
    return _listContainerView;
}
@end
