//
//  DJQuickHomeVC.m
//  DJTest
//
//  Created by lxthyme on 2024/1/31.
//
#import "DJQuickHomeVC.h"

#import <JXPageListView/JXPageListView.h>
#import "DJModuleQuickHomeView.h"

@interface DJQuickHomeVC()<UITableViewDelegate, UITableViewDataSource, JXPageListViewDelegate> {
}
@property(nonatomic, strong)JXPageListView *pageListView;
@property(nonatomic, strong)DJModuleQuickHomeView *classifyView;

@end

@implementation DJQuickHomeVC
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
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXPageListViewDelegate
- (NSArray<UIView<JXPageListViewListDelegate> *> *)listViewsInPageListView:(JXPageListView *)pageListView {
    return @[self.classifyView];
}
- (void)pinCategoryView:(JXCategoryBaseView *)pinCategoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2 + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 2) {
        return 1;
    }
    if(section == 0) {
        return 2;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 2) {
        return [self.pageListView listContainerCellForRowAtIndexPath:indexPath];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.xl_identifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Custom cell:%ld-%ld", indexPath.section, indexPath.row];
    if(indexPath.section == 0) {
        cell.textLabel.textColor = [UIColor redColor];
    } else {
        cell.textLabel.textColor = [UIColor blueColor];
    }
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 2) {
        return [self.pageListView listContainerCellHeight];
    }
    if(indexPath.section == 0) {
        return 70;
    }
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - ✈️UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // CGFloat offsetY = scrollView.contentOffset.y;
    // NSLog(@"-->offsetY: %f", offsetY);
    [self.pageListView mainTableViewDidScroll:scrollView];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    // navigationItem.title = @"";

    [self.view addSubview:self.pageListView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.pageListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (JXPageListView *)pageListView {
    if(!_pageListView){
        JXPageListView *v = [[JXPageListView alloc]initWithDelegate:self];
        v.listViewScrollStateSaveEnabled = YES;
        // v.pinCategoryViewVerticalOffset = 200;
        // v.pinCategoryViewHeight = 80;
        // v.pinCategoryView.titles = @[];

        v.mainTableView.dataSource = self;
        v.mainTableView.delegate = self;
        v.mainTableView.scrollsToTop = NO;
        [v.mainTableView xl_registerForCell:[UITableViewCell class]];
        _pageListView = v;
    }
    return _pageListView;
}
- (DJModuleQuickHomeView *)classifyView {
    if(!_classifyView){
        WEAKSELF(self)
        DJModuleQuickHomeView *v = [[DJModuleQuickHomeView alloc]initWithRefreshBlock:^{
            [weakSelf.pageListView reloadWithoutRefreshData];
        }];
        _classifyView = v;
    }
    return _classifyView;
}
@end
