//
//  LXTableVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXTableVC.h"

#import <Masonry/Masonry.h>
#import "LXTableHeaderView.h"

@interface LXTableVC()<UITableViewDataSource,UITableViewDelegate> {
}
@property(nonatomic, strong)UITableView *table;
@property(nonatomic, strong)LXTableHeaderView *header0;
@property(nonatomic, strong)LXTableHeaderView *header1;
@property(nonatomic, strong)LXTableHeaderView *header2;
@property(nonatomic, strong)LXTableHeaderView *header3;
@property(nonatomic, strong)LXTableHeaderView *header4;

@end

@implementation LXTableVC
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

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0 || section == 1) {
        return 0;
    }
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"row: %ld", indexPath.row];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // if(section == 0) {
    //     if(!self.header0) {
    //         LXTableHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LXTableHeaderView.Header0"];
    //         header.contentView.backgroundColor = [UIColor magentaColor];
    //         [header dataFill:@"Section 0"];
    //         self.header0 = header;
    //     }
    //     return self.header0;
    // } else if(section == 1) {
    //     if(!self.header1) {
    //         LXTableHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LXTableHeaderView.Header1"];
    //         header.contentView.backgroundColor = [UIColor magentaColor];
    //         [header dataFill:@"Section 1"];
    //         self.header1 = header;
    //     }
    //     return self.header1;
    // } else if(section == 2) {
    //     if(!self.header2) {
    //         LXTableHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LXTableHeaderView.Header2"];
    //         header.contentView.backgroundColor = [UIColor magentaColor];
    //         [header dataFill:@"Section 2"];
    //         self.header2 = header;
    //     }
    //     return self.header2;
    // } else if(section == 3) {
    //     if(!self.header3) {
    //         LXTableHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LXTableHeaderView.Header3"];
    //         header.contentView.backgroundColor = [UIColor magentaColor];
    //         [header dataFill:@"Section 3"];
    //         self.header3 = header;
    //     }
    //     return self.header3;
    // } else {
        LXTableHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LXTableHeaderView.Header"];
        header.contentView.backgroundColor = [UIColor magentaColor];
        [header dataFill:[NSString stringWithFormat:@"Section %ld", section]];
        return header;
    // }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LXTableHeaderView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LXTableHeaderView.Footer"];
    footer.contentView.backgroundColor = [UIColor cyanColor];
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - ✈️UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // CGRect f = [self.table rectForHeaderInSection:1];
    // CGRect frame1 = self.header1.frame;
    // frame1.origin.x = 120.f;
    // self.header1.frame = frame1;
    // NSLog(@"frame1: %@", NSStringFromCGRect(frame1));
    // CGRect frame2 = self.header2.frame;
    // frame2.origin.x = 250.f;
    // self.header2.frame = frame2;
    // NSLog(@"frame2: %@", NSStringFromCGRect(frame2));
    // CGRect frame3 = self.header3.frame;
    // frame3.origin.x = 280.f;
    // self.header3.frame = frame3;
    // NSLog(@"frame3: %@", NSStringFromCGRect(frame3));
    // CGFloat sectionHeaderHeight = 30;
    // if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
    //     scrollView.contentInset = UIEdgeInsetsMake(scrollView.contentOffset.y, 0, 0, 0);
    // } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
    //     scrollView.contentInset = UIEdgeInsetsMake(sectionHeaderHeight, 0, 0, 0);
    // }


    CGRect frame0 = [self.table rectForHeaderInSection:0];
    // NSLog(@"frame0: %@", NSStringFromCGRect(frame0));
    CGRect frame1 = [self.table rectForHeaderInSection:1];
    // NSLog(@"frame1: %@", NSStringFromCGRect(frame1));
    CGRect frame2 = [self.table rectForHeaderInSection:2];
    // NSLog(@"frame2: %@", NSStringFromCGRect(frame2));
    CGRect frame3 = [self.table rectForHeaderInSection:3];
    // NSLog(@"frame3: %@", NSStringFromCGRect(frame3));
    CGRect frame4 = [self.table rectForHeaderInSection:4];

    CGFloat offsetY = scrollView.contentOffset.y;
    // NSLog(@"offsetY: %f", offsetY);
    if(offsetY > CGRectGetMinY(frame0)) {
        frame0.origin.y = 30.f * 0;
        self.header0.frame = frame0;
        self.header0.hidden = NO;
        self.header0.opaque = (CGRectGetMinY(frame0) - offsetY) / CGRectGetWidth(frame0);
    } else {
        self.header0.hidden = YES;
    }
    if(offsetY > CGRectGetMinY(frame1) - 30.f * 1) {
        frame1.origin.y = 30.f * 1;
        self.header1.frame = frame1;
        self.header1.hidden = NO;
    } else {
        self.header1.hidden = YES;
    }
    if(offsetY > CGRectGetMinY(frame2) - 30.f * 2) {
        frame2.origin.y = 30.f * 2;
        self.header2.frame = frame2;
        self.header2.hidden = NO;
    } else {
        self.header2.hidden = YES;
    }
    if(offsetY > CGRectGetMinY(frame3) - 30.f * 3) {
        frame3.origin.y = 30.f * 3;
        self.header3.frame = frame3;
        self.header3.hidden = NO;
    } else {
        self.header3.hidden = YES;
    }
    if(offsetY > CGRectGetMinY(frame4) - 30.f * 4) {
        frame4.origin.y = 30.f * 4;
        self.header4.frame = frame4;
        self.header4.hidden = NO;
    } else {
        self.header4.hidden = YES;
    }

}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareTableView {
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.table registerClass:[LXTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"LXTableHeaderView.Header"];
    [self.table registerClass:[LXTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"LXTableHeaderView.Header0"];
    [self.table registerClass:[LXTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"LXTableHeaderView.Header1"];
    [self.table registerClass:[LXTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"LXTableHeaderView.Header2"];
    [self.table registerClass:[LXTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"LXTableHeaderView.Header3"];
    [self.table registerClass:[LXTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"LXTableHeaderView.Footer"];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = false;

    [self.view addSubview:self.table];
    [self.view addSubview:self.header0];
    [self.view addSubview:self.header1];
    [self.view addSubview:self.header2];
    [self.view addSubview:self.header3];
    [self.view addSubview:self.header4];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UITableView *)table {
    if(!_table){
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
- (LXTableHeaderView *)header0 {
    if(!_header0){
        LXTableHeaderView *v = [[LXTableHeaderView alloc]init];
        v.contentView.backgroundColor = [UIColor magentaColor];
        [v dataFill:@"Section 0"];
        _header0 = v;
    }
    return _header0;
}
- (LXTableHeaderView *)header1 {
    if(!_header1){
        LXTableHeaderView *v = [[LXTableHeaderView alloc]init];
        v.contentView.backgroundColor = [UIColor magentaColor];
        [v dataFill:@"Section 1"];
        _header1 = v;
    }
    return _header1;
}
- (LXTableHeaderView *)header2 {
    if(!_header2){
        LXTableHeaderView *v = [[LXTableHeaderView alloc]init];
        v.contentView.backgroundColor = [UIColor magentaColor];
        [v dataFill:@"Section 2"];
        _header2 = v;
    }
    return _header2;
}
- (LXTableHeaderView *)header3 {
    if(!_header3){
        LXTableHeaderView *v = [[LXTableHeaderView alloc]init];
        v.contentView.backgroundColor = [UIColor magentaColor];
        [v dataFill:@"Section 3"];
        _header3 = v;
    }
    return _header3;
}
- (LXTableHeaderView *)header4 {
    if(!_header4){
        LXTableHeaderView *v = [[LXTableHeaderView alloc]init];
        v.contentView.backgroundColor = [UIColor magentaColor];
        [v dataFill:@"Section 4"];
        _header4 = v;
    }
    return _header4;
}
@end
