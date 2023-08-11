//
//  DJCommentChildVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/11.
//
#import "DJCommentChildVC.h"

#import <Masonry/Masonry.h>
#import "DJCommentCell.h"

@interface DJCommentChildVC()<UITableViewDataSource, UITableViewDelegate> {
}
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy)NSArray<NSString *> *dataList;

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
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DJCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:DJCommentCell.xl_identifier forIndexPath:indexPath];
    [cell dataFill];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareTableView {
    [self.tableView xl_registerForCell:[DJCommentCell class]];
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
- (NSArray<NSString *> *)dataList {
    if(!_dataList){
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = 0; i < 20; i++) {
            [arr addObject:[NSString stringWithFormat:@"row: %ld", i]];
        }
        _dataList = [arr copy];
    }
    return _dataList;
}
- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *t = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
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
