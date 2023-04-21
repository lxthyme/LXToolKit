//
//  LXPageVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXPageVC.h"

#import <JXPageListView/JXPageListView.h>
#import "LXPageListView.h"

static const CGFloat JXPageheightForHeaderInSection = 50;

@interface LXPageVC()<JXPageListViewDelegate, UITableViewDataSource, UITableViewDelegate> {
}
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)NSArray <NSString *> *titles;
@property (nonatomic, strong)JXPageListView *pageListView;
@property (nonatomic, strong)NSArray<LXPageListView *> *listViewArray;

@end

@implementation LXPageVC
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
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.pageListView.frame = self.view.bounds;
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)naviRightItemDidClick {
    [self.pageListView.mainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark -
#pragma mark - ✈️JXPageListViewDelegate
- (NSArray<UIView<JXPageListViewListDelegate> *> *)listViewsInPageListView:(JXPageListView *)pageListView {
    return self.listViewArray;
}
- (void)pinCategoryView:(JXCategoryBaseView *)pinCategoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}
#pragma mark - ✈️UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 底部的分类滚动视图需要作为最后一个section
    return 2 + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 2) {
        //Tips:最后一个section（即listContainerCell所在的section）需要返回1
        return 1;
    } else if(section == 0) {
        return 10;
    }
    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 2) {
        //Tips:最后一个section（即listContainerCell所在的section）配置listContainerCell
        return [self.pageListView listContainerCellForRowAtIndexPath:indexPath];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Your custom cell:%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    if (indexPath.section == 0) {
        cell.textLabel.textColor = [UIColor redColor];
    }else {
        cell.textLabel.textColor = [UIColor blueColor];
    }
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 2) {
        //Tips:最后一个section（即listContainerCell所在的section）返回listContainerCell的高度
        return [self.pageListView listContainerCellHeight];
    } else if(indexPath.section == 0) {
        return 70;
    }
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - ✈️UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //Tips:需要传入mainTableView的scrollViewDidScroll事件
    [self.pageListView mainTableViewDidScroll:scrollView];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = false;
    self.title = @"Test";
    self.titles = @[@"能力", @"爱好", @"队友"];
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);

    [self.view addSubview:self.pageListView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
}
#pragma mark getter / setter
- (void)setListViewScrollStateSaveEnabled:(BOOL)listViewScrollStateSaveEnabled {
    if(_listViewScrollStateSaveEnabled == listViewScrollStateSaveEnabled) {
        return;
    }
    _listViewScrollStateSaveEnabled = listViewScrollStateSaveEnabled;
    self.pageListView.listViewScrollStateSaveEnabled = _listViewScrollStateSaveEnabled;
}
- (void)setPinCategoryViewVerticalOffset:(CGFloat)pinCategoryViewVerticalOffset {
    if(_pinCategoryViewVerticalOffset == pinCategoryViewVerticalOffset) {
        return;
    }
    _pinCategoryViewVerticalOffset = pinCategoryViewVerticalOffset;
    self.pageListView.pinCategoryViewVerticalOffset = _pinCategoryViewVerticalOffset;
}
- (void)setIsNeedScrollToBottom:(BOOL)isNeedScrollToBottom {
    if(_isNeedScrollToBottom == isNeedScrollToBottom) {
        return;
    }
    _isNeedScrollToBottom = isNeedScrollToBottom;
    if(_isNeedScrollToBottom) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"滚动到底部" style:UIBarButtonItemStylePlain target:self action:@selector(naviRightItemDidClick)];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}
#pragma mark Lazy Property
- (NSArray<LXPageListView *> *)listViewArray {
    if(!_listViewArray){
        LXPageListView *powerListView = [[LXPageListView alloc] init];
        powerListView.isNeedHeader = self.isNeedHeader;
        powerListView.dataSource = @[@"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮", @"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮"].mutableCopy;

        LXPageListView *hobbyListView = [[LXPageListView alloc] init];
        hobbyListView.isNeedHeader = self.isNeedHeader;
        hobbyListView.dataSource = @[@"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉"].mutableCopy;

        LXPageListView *partnerListView = [[LXPageListView alloc] init];
        partnerListView.isNeedHeader = self.isNeedHeader;
        partnerListView.dataSource = @[@"【剑士】罗罗诺亚·索隆", @"【航海士】娜美", @"【狙击手】乌索普", @"【厨师】香吉士", @"【船医】托尼托尼·乔巴", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾"].mutableCopy;

        _listViewArray = @[powerListView, hobbyListView, partnerListView];
    }
    return _listViewArray;
}
- (JXPageListView *)pageListView {
    if(!_pageListView){
        JXPageListView *v = [[JXPageListView alloc]initWithDelegate:self];
        v.pinCategoryViewHeight = JXPageheightForHeaderInSection;
        v.pinCategoryView.titles = self.titles;

        //添加分割线，这个完全自己配置
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, JXPageheightForHeaderInSection - 1, self.view.bounds.size.width, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [v.pinCategoryView addSubview:lineView];

        v.mainTableView.dataSource = self;
        v.mainTableView.delegate = self;
        v.mainTableView.scrollsToTop = NO;
        [v.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

        _pageListView = v;
    }
    return _pageListView;
}
@end
