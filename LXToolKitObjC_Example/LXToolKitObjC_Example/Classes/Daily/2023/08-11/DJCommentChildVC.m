//
//  DJCommentChildVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/11.
//
#import "DJCommentChildVC.h"

#import "DJCommentCell.h"
#import "DJCommentFooterView.h"

@interface DJCommentChildVC()<UITableViewDataSource, UITableViewDelegate> {
}
@property(nonatomic, strong)UITableView *tableView;

@end

@implementation DJCommentChildVC
- (void)dealloc {
    NSLog(@"🎷DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    [self prepareUI];
    [self prepareTableView];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)loadData:(BOOL)isRefresh {
    dlog(@"-->loadData: %d", isRefresh);
    if(!isRefresh) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return DJCommentType18 + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DJCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:DJCommentCell.xl_identifier forIndexPath:indexPath];
    [cell dataFill:indexPath.row];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 44.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    DJCommentFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:DJCommentFooterView.xl_identifier];
    return footer;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareTableView {
    WEAKSELF(self)
    MJRefreshAutoNormalFooter *footer = [ MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadData:NO];
    }];
    footer.stateLabel.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
    footer.stateLabel.textColor = [UIColor colorWithHex:0x999999];
    [footer setTitle:@"—— 到底啦 ——" forState:MJRefreshStateNoMoreData];
    self.tableView.mj_footer = footer;
    [self.tableView xl_registerForCell:[DJCommentCell class]];
    [self.tableView xl_registerForHeaderFooterView:[DJCommentFooterView class]];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    // navigationItem.title = @"";

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
    if(!_tableView) {
        UITableView *t = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        t.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        t.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        // t.backgroundColor = [UIColor <#whiteColor#>];
        t.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        t.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        t.separatorStyle = UITableViewCellSeparatorStyleNone;
        // t.rowHeight = 44.f;
        t.estimatedRowHeight = UITableViewAutomaticDimension;
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
        _tableView = t;
    }
    return _tableView;
}
@end
