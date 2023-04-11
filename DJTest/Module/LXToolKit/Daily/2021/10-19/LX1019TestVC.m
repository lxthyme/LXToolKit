//
//  LX1019TestVC.m
//  LXToolKit_Exam
//
//  Created by lxthyme on 2021/10/19.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import "LX1019TestVC.h"
#import <Masonry/Masonry.h>

@interface LX1019TestVC()<UITableViewDataSource,UITableViewDelegate> {
}
@property(nonatomic, strong)UITableView *table;
@property(nonatomic, copy)NSArray<NSString *> *dataList;
@end

@implementation LX1019TestVC
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

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.01f, 0.01f)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.01f, 0.01f)];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
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
- (UITableView *)table {
    if(!_table){
        //初始化一个 tableView
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.tableFooterView = [UIView new];
        _table.estimatedRowHeight = 44.0f;
        _table.rowHeight = UITableViewAutomaticDimension;

        [_table setDelegate:self];
        [_table setDataSource:self];

        [_table setBackgroundColor:[UIColor whiteColor]];

        [_table setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
        [_table setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
        [_table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _table;
}
@end
