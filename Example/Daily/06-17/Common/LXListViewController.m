//
//  LXListViewController.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import <Masonry/Masonry.h>

#import <MJRefresh/MJRefresh.h>
#import "UIWindow+JXSafeArea.h"

#import "LXListViewController.h"

@interface LXListViewController()<UITableViewDataSource, UITableViewDelegate> {
}
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);

@end

@implementation LXListViewController
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
    if(!self.isHeaderRefreshed) {
        if(self.isNeedHeader) {
            [self.tableView.mj_header beginRefreshing];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.isHeaderRefreshed = YES;
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
            });
        } else {
            self.isHeaderRefreshed = YES;
            [self.tableView reloadData];
        }
    }
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
    return self.tableView;
}
- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}
- (void)listWillAppear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}
- (void)listDidAppear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}
- (void)listWillDisappear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}
- (void)listDidDisappear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!self.isHeaderRefreshed) {
        return 0;
    }
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.dataSource[indexPath.row];
    NSLog(@"-->: %@", title);
}

#pragma mark -
#pragma mark - ✈️UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    WEAKSELF(self)
    if(self.isNeedHeader) {
        self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.tableView.mj_header endRefreshing];
            });
        }];
    }
    if(self.isNeedFooter) {
        self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.dataSource addObject:@"加载更多成功"];
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_footer endRefreshing];
            });
        }];
    }
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    // [self.<#view#> addSubview:self.<#table#>];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
}

#pragma mark Lazy Property
- (UITableView *)tableView {
    if(!_tableView){
        UITableView *t = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        t.tableFooterView = [UIView new];
        t.estimatedRowHeight = 44.0f;
        t.rowHeight = UITableViewAutomaticDimension;
        t.estimatedRowHeight = 0;
        t.estimatedSectionFooterHeight = 0;
        t.estimatedSectionHeaderHeight = 0;
        if (@available(iOS 11.0, *)) {
            t.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if(@available(iOS 13.0, *)) {
            t.automaticallyAdjustsScrollIndicatorInsets = NO;
        }
        if(@available(iOS 15.0, *)) {
            t.sectionHeaderTopPadding = 0.f;
        }

        [t setDelegate:self];
        [t setDataSource:self];

        [t setBackgroundColor:[UIColor whiteColor]];

        [t setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
        [t setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
        [t setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        t.contentInset = UIEdgeInsetsMake(0, 0, UIApplication.sharedApplication.keyWindow.jx_layoutInsets.bottom, 0);
        
        _tableView = t;
    }
    return _tableView;
}
@end
