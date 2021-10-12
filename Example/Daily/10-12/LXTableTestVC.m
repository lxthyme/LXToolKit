//
//  LXTableTestVC.m
//  LXToolKit_Exam
//
//  Created by lxthyme on 2021/10/12.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import "LXTableTestVC.h"
#import <Masonry/Masonry.h>

#import "LXSectionHeaderTestView.h"

@interface LXTableTestVC()<UITableViewDataSource,UITableViewDelegate> {
    CGFloat _sectionHeight;
}
@property(nonatomic, strong)UITableView *table;
@property(nonatomic, copy)NSArray *dataList;
@property(nonatomic, strong)LXSectionHeaderTestView *sectionHeader;
@end

@implementation LXTableTestVC
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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;

    // self.navigationController.navigationBar.translucent = YES;
    // [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // self.navigationController.navigationBar.shadowImage = [UIImage new];

    self.navigationController.navigationBar.translucent = false;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    // NSLog(@"🛠viewDidDisappear: %@", NSStringFromClass([self class]));
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;

    // self.navigationController.navigationBar.translucent = YES;
    // [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // self.navigationController.navigationBar.shadowImage = [UIImage new];

    self.navigationController.navigationBar.translucent = false;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.automaticallyAdjustsScrollViewInsets = NO;
    _sectionHeight = 50.f;
    [self prepareUI];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor brownColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _sectionHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(self.sectionHeader != nil) {
        return self.sectionHeader;
    }
    LXSectionHeaderTestView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LXSectionHeaderTestView"];
    self.sectionHeader = header;
    return header;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    static NSInteger idx = 0;
    if(idx % 2 == 0) {
        // self.navigationController.navigationBar.translucent = YES;
        // [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        // self.navigationController.navigationBar.shadowImage = [UIImage new];

        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    } else {
        // self.navigationController.navigationBar.translucent = false;
        // [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        // self.navigationController.navigationBar.shadowImage = nil;

        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.extendedLayoutIncludesOpaqueBars = YES;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }

    idx += 1;
}

#pragma mark -
#pragma mark - ✈️UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect frame = [self.table rectForHeaderInSection:0];
    CGRect rect = [self.view convertRect:frame toView:self.sectionHeader];
    NSLog(@"frame: %@ - %@", NSStringFromCGRect(frame), NSStringFromCGRect(rect));
    static NSInteger currentSectionType = 1;
    if(rect.origin.y >= 20.f && currentSectionType == 1) {
        currentSectionType = 2;
        [self.sectionHeader changeType:2];

    } else if(rect.origin.y < 20.f && currentSectionType == 2) {
        currentSectionType = 1;
        [self.sectionHeader changeType:1];
    }
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.table];
    [self masonry];
}
- (void)masonry {
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark -
#pragma mark - 📌Property Lazy Load
- (NSArray *)dataList {
    if(!_dataList){
        _dataList = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    }
    return _dataList;
}
- (UITableView *)table {
    if(!_table){
        //初始化一个 tableView
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.tableFooterView = [UIView new];
        _table.estimatedRowHeight = 244.0f;
        _table.rowHeight = 244.0f;

        [_table setDelegate:self];
        [_table setDataSource:self];

        if (@available(iOS 11.0, *)) {
            _table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }

        [_table setBackgroundColor:[UIColor magentaColor]];

        [_table setIndicatorStyle:UIScrollViewIndicatorStyleDefault];
        [_table setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
        [_table setSeparatorStyle:UITableViewCellSeparatorStyleNone];

        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_table registerClass:[LXSectionHeaderTestView class] forHeaderFooterViewReuseIdentifier:@"LXSectionHeaderTestView"];
    }
    return _table;
}
@end
