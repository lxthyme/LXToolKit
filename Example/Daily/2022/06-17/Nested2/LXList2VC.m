//
//  LXList2VC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXList2VC.h"
#import "LXListViewController.h"
#import "LXPageCell.h"

static const NSInteger kSectionCount = 2;

@interface LXList2VC()<UITableViewDataSource, UITableViewDelegate> {
}
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property(nonatomic, strong)LXPageCell *pagerCell;
@property (nonatomic, strong)NSArray<LXListViewController *> *listViewArray;
@property(nonatomic, assign)BOOL canScroll;
@end

@implementation LXList2VC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -
#pragma mark - 🛠Life Cycle
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
    self.canScroll = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mainNotice) name:@"mainNotice" object:nil];
}
// - (void)viewDidLayoutSubviews {
//     [super viewDidLayoutSubviews];
//
//     self.tableView.frame = self.view.bounds;
// }

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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kSectionCount;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!self.isHeaderRefreshed) {
        return 0;
    }
    if(section == kSectionCount - 1) {
        return 1;
    }
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == kSectionCount - 1) {
        if(!self.pagerCell) {
            LXPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXPageCell" forIndexPath:indexPath];
            cell.isNeedHeader = self.isNeedHeader;
            cell.isNeedFooter = self.isNeedFooter;
            self.pagerCell = cell;
        }
        return self.pagerCell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell.Normal" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld: %@", indexPath.section, indexPath.row, self.dataSource[indexPath.row]];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == kSectionCount - 1) {
        return MAX(0, CGRectGetHeight(tableView.frame));
    }
    return 50.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == kSectionCount - 1) {
        return;
    }
    NSString *title = self.dataSource[indexPath.row];
    NSLog(@"-->: %@", title);
}

#pragma mark -
#pragma mark - ✈️UIScrollViewDelegate
- (void)mainNotice {
    self.canScroll = YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
    CGFloat offsetY = scrollView.contentOffset.y;
    // NSLog(@"-->offsetY: %f", offsetY);
    CGFloat HEADER_HEIGHT = CGRectGetHeight([self.tableView rectForSection:0]);
    if(offsetY >= HEADER_HEIGHT) {
        scrollView.contentOffset = CGPointMake(0, HEADER_HEIGHT);
        if(self.canScroll) {
            self.canScroll = NO;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"childNotice" object:nil];
        }
    } else {
        if(!self.canScroll) {
            scrollView.contentOffset = CGPointMake(0, HEADER_HEIGHT);
        }
    }
}
// func scrollViewDidScroll(_ scrollView: UIScrollView) {
//     //如果高度大于等于tableHeaderView的高度的时候
//     if scrollView.contentOffset.y >=  HEADER_HEIGHT{
//         //设置ContentOffsetY的高度为tableHeaderView的高度
//         scrollView.contentOffset = CGPoint(x: 0, y: HEADER_HEIGHT)
//         if self.canScroll {
//             self.canScroll = false//设置是否可以滚动的参数为false
//             //发送通知给子tableView。设置子tableView的可滚动属性为true
//             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChilderNotice"), object: nil)
//         }
//     }else{
//         if !self.canScroll {
//             scrollView.contentOffset = CGPoint(x: 0, y: HEADER_HEIGHT)
//         }
//     }
//         }

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell.Normal"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell.List2VC"];
    [self.tableView registerClass:[LXPageCell class] forCellReuseIdentifier:@"LXPageCell"];
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
- (UITableView *)tableView {
    if(!_tableView){
        LXMyTableView *t = [[LXMyTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        t.tableFooterView = [UIView new];
        t.estimatedRowHeight = 44.0f;
        t.rowHeight = UITableViewAutomaticDimension;
        // t.bounces = NO;
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
// - (NSArray<LXListViewController *> *)listViewArray {
//     if(!_listViewArray){
//         LXListViewController *listVC1 = [[LXListViewController alloc]init];
//         listVC1.title = self.titles[0];
//         listVC1.isNeedHeader = self.isNeedHeader;
//         listVC1.isNeedFooter = self.isNeedFooter;
//         listVC1.dataSource = @[@"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮", @"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮"].mutableCopy;
//
//         LXListViewController *listVC2 = [[LXListViewController alloc]init];
//         listVC2.title = self.titles[1];
//         listVC2.isNeedHeader = self.isNeedHeader;
//         listVC2.isNeedFooter = self.isNeedFooter;
//         listVC2.dataSource = @[@"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉"].mutableCopy;
//
//         LXListViewController *listVC3 = [[LXListViewController alloc]init];
//         listVC3.title = self.titles[2];
//         listVC3.isNeedHeader = self.isNeedHeader;
//         listVC3.isNeedFooter = self.isNeedFooter;
//         listVC3.dataSource = @[@"【剑士】罗罗诺亚·索隆", @"【航海士】娜美", @"【狙击手】乌索普", @"【厨师】香吉士", @"【船医】托尼托尼·乔巴", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾"].mutableCopy;
//
//
//         NSMutableArray *arr = [NSMutableArray array];
//         [arr addObject:listVC1];
//         [arr addObject:listVC2];
//         [arr addObject:listVC3];
//
//         _listViewArray = [arr copy];
//     }
//     return _listViewArray;
// }
@end
