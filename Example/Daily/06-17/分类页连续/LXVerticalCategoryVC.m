//
//  LXVerticalCategoryVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/20.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXVerticalCategoryVC.h"

#import "LXClassifyListVC.h"
#import "LXVerticalCell.h"

@interface LXVerticalCategoryVC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate, JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate, UITableViewDataSource,UITableViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
}
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong)NSArray *titles;
@property(nonatomic, strong)JXPagerView *pagerView;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UICollectionView *collectionView;
@end

@implementation LXVerticalCategoryVC
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

    [self prepareTableView];
    [self prepareCollectionView];
    [self prepareUI];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXCategoryViewDelegate

#pragma mark -
#pragma mark - ✈️JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    LXClassifyListVC *vc = [[LXClassifyListVC alloc]init];
    return vc;
}

#pragma mark -
#pragma mark - ✈️JXPagerViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return [UIView new];
}
- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return 0.f;
}
- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return 0.f;
}
- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return [UIView new];
}
- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.titles.count;
}
- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    LXClassifyListVC *vc = [[LXClassifyListVC alloc]init];
    return vc;
}

#pragma mark - JXPagerMainTableViewGestureDelegate
- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // if([self.listContainerView.scrollView isKindOfClass:[UICollectionView class]]) {
    //     UICollectionView *collectionView = (UICollectionView *)self.listContainerView.scrollView;
    //     [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    // }
    // [self.listContainerView didClickSelectedItemAtIndex:indexPath.row];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.titles count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXVerticalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXVerticalCell" forIndexPath:indexPath];
    // [cell dataFill];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - ✈️UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}


#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}
- (void)prepareCollectionView {
    [self.collectionView registerClass:[LXVerticalCell class] forCellWithReuseIdentifier:@"LXVerticalCell"];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;

    self.titles = @[@"我的频道", @"超级大IP", @"热门HOT", @"周边衍生", @"影视综", @"游戏集锦", @"搞笑百事", @"lastOne"];
    self.categoryView.titles = self.titles;
    self.categoryView.listContainer = self.listContainerView;
    self.listContainerView.bounces = YES;
    // self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
    if([self.listContainerView.scrollView isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self.listContainerView.scrollView;
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        [layout prepareLayout];
    }
    // self.categoryView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    // self.categoryView.frame = CGRectMake(0, SCREEN_HEIGHT / 2.f, SCREEN_HEIGHT, 100);
    // self.categoryView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.view addSubview:self.tableView];
    // [self.view addSubview:self.categoryView];
    // [self.view addSubview:self.pagerView];
    // [self.view addSubview:self.listContainerView];
    [self.view addSubview:self.collectionView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    // [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.top.left.right.equalTo(@0.f);
    //     make.height.equalTo(@80.f);
    // }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(@0.f);
        make.width.equalTo(@100.f);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(@0.f);
        make.left.equalTo(self.tableView.mas_right);
        // make.top.equalTo(self.categoryView.mas_bottom);
        // make.left.bottom.right.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (JXCategoryTitleView *)categoryView {
    if(!_categoryView){
        JXCategoryTitleView *v = [[JXCategoryTitleView alloc]init];
        v.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        v.delegate = self;

        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.verticalMargin = 15;
        v.indicators = @[lineView];

        _categoryView = v;
    }
    return _categoryView;
}
- (JXCategoryListContainerView *)listContainerView {
    if(!_listContainerView){
        JXCategoryListContainerView *v = [[JXCategoryListContainerView alloc]initWithType:JXCategoryListContainerType_CollectionView delegate:self];
        _listContainerView = v;
    }
    return _listContainerView;
}
- (JXPagerView *)pagerView {
    if(!_pagerView){
        JXPagerView *v = [[JXPagerView alloc]initWithDelegate:self listContainerType:JXPagerListContainerType_CollectionView];
        v.mainTableView.gestureDelegate = self;
        v.isListHorizontalScrollEnabled = NO;
        _pagerView = v;
    }
    return _pagerView;
}
- (UITableView *)tableView {
    if(!_tableView) {
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
        _tableView = t;
    }
    return _tableView;
}
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        CGRect collectFrame = CGRectZero;
        CGSize itemSize = CGSizeZero;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = itemSize;
        flowLayout.estimatedItemSize = itemSize;
        flowLayout.minimumLineSpacing = 0.f;
        flowLayout.minimumInteritemSpacing = 0.f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // flowLayout.sectionHeadersPinToVisibleBounds = YES;
        // flowLayout.sectionFootersPinToVisibleBounds = YES;
        // flowLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#HeaderSectionHeight#>);
        // flowLayout.footerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#FooterSectionHeight#>);
        flowLayout.sectionInset = UIEdgeInsetsZero;

        UICollectionView *cv = [[UICollectionView alloc]initWithFrame:collectFrame collectionViewLayout:flowLayout];
        cv.backgroundColor = [UIColor whiteColor];
        cv.pagingEnabled = YES;

        cv.delegate = self;
        cv.dataSource = self;

        _collectionView = cv;
    }
    return _collectionView;
}
@end
