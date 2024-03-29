//
//  LXTable202403VC.m
//  LXToolKit_Example
//
//  Created by lxthyme on 2024/3/7.
//
#import "LXTable202403VC.h"

#import <Masonry/Masonry.h>
#import "LXTable202403HeaderView.h"
#import "LXTable202403SectionView.h"
#import <MJRefresh/MJRefresh.h>

#define kDJClassifyQuicklyPinHeight 88.f

@interface LXTable202403VC()<UITableViewDataSource, UITableViewDelegate> {
}
@property(nonatomic, strong)LXTable202403SectionView *tableHeaderView;
@property(nonatomic, strong)UITableView *table;

@end

@implementation LXTable202403VC
- (void)dealloc {
    NSLog(@"🎷DEALLOC: %@", NSStringFromClass([self class]));
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

    [self prepareTableView];
    [self prepareUI];
    [self dataFill];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill {
    self.tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kDJClassifyQuicklyPinHeight);
    UIView *header = [[UIView alloc]init];
    header.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, kDJClassifyQuicklyPinHeight);
    // header.backgroundColor = [UIColor redColor];
    [header addSubview:self.tableHeaderView];
    self.table.tableHeaderView = header;
    // header.layer.zPosition = 1;
    // [self.table bringSubviewToFront:header];
    // self.table.tableHeaderView = self.tableHeaderView;

    // [self.view addSubview:self.tableHeaderView];
    // self.table.contentInset = UIEdgeInsetsMake(kDJClassifyQuicklyPinHeight + 64, 0, 0, 0);
    self.table.mj_header.ignoredScrollViewContentInsetTop = -kDJClassifyQuicklyPinHeight;// - 54;
    // self.table.bounces = YES;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.xl_identifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.row];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
// - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//     return [NSString stringWithFormat:@"section - %ld", section];
// }
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LXTable202403HeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LXTable202403HeaderView.xl_identifier];
    NSString *title = [NSString stringWithFormat:@"section - %ld", section];
    [header dataFill:title];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}
// - (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//     [self.table bringSubviewToFront:self.tableHeaderView];
// }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - ✈️UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // [NSObject cancelPreviousPerformRequestsWithTarget:self];
    // [self performSelector:@selector(scrollViewDidEndDecelerating:) withObject:scrollView];
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"-->offsetY: %f", offsetY);
    if(offsetY <= 0) {
        self.tableHeaderView.frame = CGRectMake(0, offsetY, SCREEN_WIDTH, kDJClassifyQuicklyPinHeight);
    } else {
        self.tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kDJClassifyQuicklyPinHeight);
    }
}
// - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//     CGFloat offsetY = scrollView.contentOffset.y;
//     // CGRect rect = [self.view convertRect:self.table.tableHeaderView.frame fromView:self.table];
//     CGRect rect = self.tableHeaderView.frame;
//     CGFloat rectY = rect.origin.y;
//     CGFloat pinOffset = 0;
//     if(offsetY >= pinOffset) {
//         rect.origin.y = offsetY - pinOffset;
//     } else {
//         rect.origin.y = 0;
//     }
//     NSLog(@"-->[%.2f]: %.2f -> %.2f", offsetY, rectY, rect.origin.y);
//     self.tableHeaderView.frame = rect;
// }

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareTableView {
    // self.table.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    [self.table xl_registerForCell:[UITableViewCell class]];
    [self.table xl_registerForHeaderFooterView:[LXTable202403HeaderView class]];

    WEAKSELF(self)
    MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc]init];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.arrowView.image = nil;
    header.stateLabel.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
    header.stateLabel.textColor = [UIColor colorWithHex:0x888888];
    [header setTitle:@"下拉至上一个分类" forState:MJRefreshStateIdle];
    [header setTitle:@"松开至上一个分类" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [header setTitle:@"will refresh" forState:MJRefreshStateWillRefresh];
    // [header setTitle:@"已经是第一个分类了" forState:MJRefreshStateNoMoreData];
    [header setTitle:@"" forState:MJRefreshStateNoMoreData];
    header.refreshingBlock = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // !weakSelf.refreshBlock ?: weakSelf.refreshBlock(YES);
            [weakSelf.table.mj_header endRefreshing];
        });
    };
    MJRefreshBackStateFooter *footer = [[MJRefreshBackStateFooter alloc]init];
    footer.ignoredScrollViewContentInsetBottom = LXiPhoneX.xl_safeareaInsets.bottom;
    footer.stateLabel.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
    footer.stateLabel.textColor = [UIColor colorWithHex:0x888888];
    [footer setTitle:@"上拉至下一个分类" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开至下一个分类" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"will refresh" forState:MJRefreshStateWillRefresh];
    // [footer setTitle:@"已经是最后一个分类了" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    footer.refreshingBlock = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // !weakSelf.refreshBlock ?: weakSelf.refreshBlock(NO);
            [weakSelf.table.mj_footer endRefreshing];
        });
    };

    self.table.mj_header = header;
    self.table.mj_footer = footer;
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    // navigationItem.title = @"";

    [self.view addSubview:self.table];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.edges.equalTo(@0.f);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.equalTo(@0.f);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark Lazy Property
- (LXTable202403SectionView *)tableHeaderView {
    if(!_tableHeaderView){
        LXTable202403SectionView *v = [[LXTable202403SectionView alloc]init];
        _tableHeaderView = v;
    }
    return _tableHeaderView;
}
- (UITableView *)table {
    if(!_table) {
        UITableView *t = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        t.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        t.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        t.backgroundColor = [UIColor whiteColor];
        t.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        t.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        t.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        t.estimatedRowHeight = UITableViewAutomaticDimension;
        t.rowHeight = 44.f;
        t.sectionHeaderHeight = 0.f;
        t.sectionFooterHeight = 0.f;
        t.estimatedSectionHeaderHeight = 0;
        t.estimatedSectionFooterHeight = 0;
        t.showsHorizontalScrollIndicator = NO;
        t.showsVerticalScrollIndicator = NO;

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
        _table = t;
    }
    return _table;
}
@end
