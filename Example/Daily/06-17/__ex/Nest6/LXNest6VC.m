//
//  LXNest6VC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/18.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXNest6VC.h"

#import <Masonry/Masonry.h>
#import "LXNestCell.h"
#import "LXPageListView.h"

@interface LXNest6VC()<UITableViewDataSource,UITableViewDelegate, JXPageListViewDelegate> {
}
@property(nonatomic, strong)JXPageListView *pageListView;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy)NSArray<NSString *> *dataList;
@property(nonatomic, copy)NSArray<NSString *> *titles;
@property (nonatomic, strong)NSArray<LXPageListView *> *listViewArray;
@end

@implementation LXNest6VC
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

    [self prepareTableView];
    [self prepareUI];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXPageListViewDelegate
- (NSArray<UIView<JXPageListViewListDelegate> *> *)listViewsInPageListView:(JXPageListView *)pageListView {
    return self.listViewArray;
}

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 1) {
        return 1;
    }
    return [self.dataList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        return [self.pageListView listContainerCellForRowAtIndexPath:indexPath];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"row: %ld", indexPath.row];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        return [self.pageListView listContainerCellHeight];
    }
    return 50.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 1) {
        return self.pageListView.pinCategoryViewHeight;
    }
    return 0.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 1) {
        return self.pageListView.pinCategoryView;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - ✈️UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.pageListView mainTableViewDidScroll:scrollView];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareTableView {
    // [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.pageListView.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.titles = @[@"主题一", @"主题二", @"主题三"];
    self.pageListView.pinCategoryView.titles = self.titles;
    self.pageListView.pinCategoryViewHeight = 100.f;
    self.pageListView.mainTableView.delegate = self;
    self.pageListView.mainTableView.dataSource = self;
    [self.view addSubview:self.pageListView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.pageListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (JXPageListView *)pageListView {
    if(!_pageListView){
        JXPageListView *v = [[JXPageListView alloc]initWithDelegate:self];
        _pageListView = v;
    }
    return _pageListView;
}
- (NSArray<LXPageListView *> *)listViewArray {
    if(!_listViewArray){
        LXPageListView *powerListView = [[LXPageListView alloc] init];
        powerListView.isNeedHeader = YES;
        powerListView.dataSource = @[@"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮", @"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮"].mutableCopy;

        LXPageListView *hobbyListView = [[LXPageListView alloc] init];
        hobbyListView.isNeedHeader = YES;
        hobbyListView.dataSource = @[@"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉"].mutableCopy;

        LXPageListView *partnerListView = [[LXPageListView alloc] init];
        partnerListView.isNeedHeader = YES;
        partnerListView.dataSource = @[@"【剑士】罗罗诺亚·索隆", @"【航海士】娜美", @"【狙击手】乌索普", @"【厨师】香吉士", @"【船医】托尼托尼·乔巴", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾"].mutableCopy;

        _listViewArray = @[powerListView, hobbyListView, partnerListView];
    }
    return _listViewArray;
}
- (NSArray<NSString *> *)dataList {
    if(!_dataList){
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = 0; i < 20; i++) {
            [arr addObject:[NSString stringWithFormat:@"%ld", i]];
        }
        _dataList = [arr copy];
    }
    return _dataList;
}
// - (UITableView *)tableView {
//     if(!_tableView) {
//         UITableView *t = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
//         t.tableHeaderView = [UIView new];
//         t.tableFooterView = [UIView new];
//         t.backgroundColor = [UIColor whiteColor];
//         t.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//         t.indicatorStyle = UIScrollViewIndicatorStyleBlack;
//         t.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//         t.estimatedRowHeight = 44.0f;
//         t.rowHeight = UITableViewAutomaticDimension;
//         t.sectionHeaderHeight = 0.f;
//         t.sectionFooterHeight = 0.f;
//         t.estimatedRowHeight = 0;
//         t.estimatedSectionHeaderHeight = 0;
//         t.estimatedSectionFooterHeight = 0;
//
//         t.delegate = self;
//         t.dataSource = self;
//
//         if (@available(iOS 11.0, *)) {
//             t.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//         }
//         if(@available(iOS 13.0, *)) {
//             t.automaticallyAdjustsScrollIndicatorInsets = NO;
//         }
//         if(@available(iOS 15.0, *)) {
//             t.sectionHeaderTopPadding = 0.f;
//         }
//         _tableView = t;
//     }
//     return _tableView;
// }
@end
