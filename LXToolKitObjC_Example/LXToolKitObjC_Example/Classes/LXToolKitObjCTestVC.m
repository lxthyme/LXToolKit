//
//  LXToolKitObjCTestVC.m
//  LXToolKitObjC
//
//  Created by lxthyme on 05/25/2022.
//  Copyright (c) 2022 lxthyme. All rights reserved.
//

#import "LXToolKitObjCTestVC.h"
#import "LXLoginVC.h"
#import "LX0527VC.h"
#import "DJCommentVC.h"

@interface LXToolKitObjCTestVC ()<UITableViewDataSource,UITableViewDelegate> {
}
@property(nonatomic, strong)UITableView *table;
@property(nonatomic, strong)NSArray *dataList;

@end

@implementation LXToolKitObjCTestVC
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self prepareUI];
    [self gotoRoute:self.autoJumpRoute];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)gotoRoute:(NSString *)route {
    Class cls = NSClassFromString(route);
    if(cls) {
        UIViewController *vc = [[cls alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        // [self.navigationController presentViewController:vc animated:YES completion:nil];
    }
}

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *vcName = self.dataList[indexPath.row];
    [self gotoRoute:vcName];
}
#pragma mark -
#pragma mark - 📌UI Prepare & Masonry
- (void)prepareUI {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"LXToolKitObjC Test VC";

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    // UIView *superView = self.view;
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (NSArray *)dataList {
    if(!_dataList){
        NSArray *list = @[
            @"LXLoginVC",
            @"LX0527VC",
            @"LXCollectionVC",
            @"LXNaHiddenVC",
            // @"LXNestedVC",
            @"LXNested2VC",
            // @"LXPageVC",
            // @"LXNest4VC",
            @"LXNest5VC",
            @"LXTableVC",
            // @"LXNest6VC",
            // @"DJO2OClassifyWrapperVC",
            @"DJO2OClassifyWrapperVC",
            @"DJClassifyVC",
            @"DJNewClassifyVC",
            @"DJB2CClassifyVC",
            @"DJO2OClassifyVC",
            @"LXClassifyContinueVC",
            @"LXVerticalCategoryVC",
            @"DJClassifyListVC",
            @"LXClassifyMainVC",
            @"LXTestModelVC",
            @"LXTestBorderVC",
            @"LXYYZZVC",
            @"LXSubjectTestVC",
            @"LXBannerTestVC",
            @"DJprepareForReuseSignalTestVC",
            @"LXShadowVC",
            @"LXStackViewTestVC",
            @"LXURLCompVC",
            @"LXWebViewTestVC",
            @"LXSwiftOCTestVC",
            @"DJSearchResultVC",
            @"LXUpdateLayoutVC",
            @"LXPopTestVC",
            @"LXNumberFormatterVC",
            @"LXScrollVC",
            @"LXCollectionTestVC",
            @"DJCommentVC",
            @"LXLabelTestVC",
        ];
        _dataList = [[list reverseObjectEnumerator] allObjects];
    }
    return _dataList;
}
- (UITableView *)table {
    if(!_table){
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

        [t setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        [t setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
        [t setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        _table = t;
    }
    return _table;
}
@end
