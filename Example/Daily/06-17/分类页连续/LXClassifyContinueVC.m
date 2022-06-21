//
//  LXClassifyContinueVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/20.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyContinueVC.h"

#import "LXSectionModel.h"

static const NSInteger kSectionAddNum = 50;
static const NSInteger kSectionCount = 5;

@interface LXClassifyContinueVC()<UITableViewDataSource,UITableViewDelegate> {
}
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy)NSArray<LXSectionModel *> *dataList;

@end

@implementation LXClassifyContinueVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    [self prepareTableView];
    [self prepareUI];
    // [self.tableView.mj_header beginRefreshing];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)loadData:(BOOL)isRefresh {
    if(isRefresh) {
        // NSMutableArray *dataList = [NSMutableArray array];
        // for (NSInteger i = 0; i < 5; i++) {
        //     NSMutableArray *itemList = [NSMutableArray array];
        //     for (NSInteger j = 0; j < 20; j++) {
        //         LXSectionItemModel *item = [[LXSectionItemModel alloc]init];
        //         item.title = [NSString stringWithFormat:@"row: %ld-%ld", i, j];
        //         [itemList addObject:item];
        //     }
        //     LXSectionModel *section = [[LXSectionModel alloc]init];
        //     section.title = [NSString stringWithFormat:@"section: %ld", i];
        //     section.itemList = [itemList copy];
        //     [dataList addObject:section];
        // }
        // self.dataList = [dataList copy];
        // [self.tableView reloadData];
        // [self.tableView.mj_header endRefreshing];
        NSInteger sectionCount = self.dataList.count;
        NSInteger idx = kSectionAddNum + kSectionCount - sectionCount - 1;
        NSMutableArray *itemList = [NSMutableArray array];
        for (NSInteger j = 0; j < 20; j++) {
            LXSectionItemModel *item = [[LXSectionItemModel alloc]init];
            item.title = [NSString stringWithFormat:@"row: %ld-%ld", idx, j];
            [itemList addObject:item];
        }
        LXSectionModel *section = [[LXSectionModel alloc]init];
        section.title = [NSString stringWithFormat:@"section: %ld", idx];
        section.itemList = [itemList copy];

        NSMutableArray *dataList = [NSMutableArray arrayWithArray:self.dataList];
        [dataList insertObject:section atIndex:0];
        self.dataList = [dataList copy];
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        if(idx <= 45) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_header endRefreshingWithCompletionBlock:^{
                self.tableView.mj_header.state = MJRefreshStateNoMoreData;
            }];
        }
    } else {
        NSInteger sectionCount = self.dataList.count;
        NSInteger idx = kSectionAddNum + sectionCount;
        NSMutableArray *itemList = [NSMutableArray array];
        for (NSInteger j = 0; j < 20; j++) {
            LXSectionItemModel *item = [[LXSectionItemModel alloc]init];
            item.title = [NSString stringWithFormat:@"row: %ld-%ld", idx, j];
            [itemList addObject:item];
        }
        LXSectionModel *section = [[LXSectionModel alloc]init];
        section.title = [NSString stringWithFormat:@"section: %ld", idx];
        section.itemList = [itemList copy];

        NSMutableArray *dataList = [NSMutableArray arrayWithArray:self.dataList];
        [dataList addObject:section];
        self.dataList = [dataList copy];
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionCount] withRowAnimation:UITableViewRowAnimationAutomatic];
        if(idx <= 55) {
            [self.tableView.mj_footer endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LXSectionModel *sectionModel = self.dataList[section];
    return sectionModel.itemList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    LXSectionModel *sectionModel = self.dataList[indexPath.section];
    LXSectionItemModel *itemModel = sectionModel.itemList[indexPath.row];
    cell.textLabel.text = itemModel.title;
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80.f;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    LXSectionModel *sectionModel = self.dataList[section];
    return sectionModel.title;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    WEAKSELF(self)
    MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc]init];
    [header setTitle:@"下拉加载上一个分类" forState:MJRefreshStateIdle];
    [header setTitle:@"松开加载上一个分类" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [header setTitle:@"will refresh" forState:MJRefreshStateWillRefresh];
    [header setTitle:@"已经是第一个分类了" forState:MJRefreshStateNoMoreData];
    header.refreshingBlock = ^{
        [weakSelf loadData:YES];
    };
    self.tableView.mj_header = header;
    MJRefreshBackStateFooter *footer = [[MJRefreshBackStateFooter alloc]init];
    [footer setTitle:@"上拉加载下一个分类" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开加载下一个分类" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"will refresh" forState:MJRefreshStateWillRefresh];
    [footer setTitle:@"已经是最后一个分类了" forState:MJRefreshStateNoMoreData];
    footer.refreshingBlock = ^{
        [weakSelf loadData:NO];
    };
    self.tableView.mj_footer = footer;
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;

    [self.view addSubview:self.tableView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (NSArray<LXSectionModel *> *)dataList {
    if(!_dataList){
        NSMutableArray *dataList = [NSMutableArray array];
        for (NSInteger i = 0; i < kSectionCount; i++) {
            NSMutableArray *itemList = [NSMutableArray array];
            for (NSInteger j = 0; j < 20; j++) {
                LXSectionItemModel *item = [[LXSectionItemModel alloc]init];
                item.title = [NSString stringWithFormat:@"row: %ld-%ld", i + kSectionAddNum, j];
                [itemList addObject:item];
            }
            LXSectionModel *section = [[LXSectionModel alloc]init];
            section.title = [NSString stringWithFormat:@"section: %ld", i + kSectionAddNum];
            section.itemList = [itemList copy];
            [dataList addObject:section];
        }
        self.dataList = [dataList copy];
    }
    return _dataList;
}
- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *t = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        t.tableHeaderView = [UIView new];
        t.tableFooterView = [UIView new];
        t.backgroundColor = [UIColor whiteColor];
        t.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        t.indicatorStyle = UIScrollViewIndicatorStyleBlack;
        t.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        t.estimatedRowHeight = 44.0f;
        t.rowHeight = UITableViewAutomaticDimension;
        t.sectionHeaderHeight = 0.f;
        t.sectionFooterHeight = 0.f;
        t.estimatedRowHeight = 0;
        t.estimatedSectionHeaderHeight = 0;
        t.estimatedSectionFooterHeight = 0;
        t.pagingEnabled = YES;

        t.delegate = self;
        t.dataSource = self;

        if (@available(iOS 11.0, *)) {
            t.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if(@available(iOS 13.0, *)) {
            t.automaticallyAdjustsScrollIndicatorInsets = NO;
        }
        if(@available(iOS 15.0, *)) {
            t.sectionHeaderTopPadding = 0.f;
        }
        _tableView = t;
    }
    return _tableView;
}
@end
