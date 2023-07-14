//
//  LXCollectionTestVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/6/28.
//
#import "LXCollectionTestVC.h"

#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import "MyCollectionCell.h"

@interface LXCollectionTestVC()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
}
@property(nonatomic, strong)NSArray<NSString *> *dataList;
@property(nonatomic, strong)UICollectionView *collectionView;

@end

@implementation LXCollectionTestVC
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

    [self prepareUI];
    [self prepareCollectionView];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark - ✈️UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MyCollectionCell.xl_identifier forIndexPath:indexPath];
    cell.labTitle.text = self.dataList[indexPath.row];
    return cell;
}
#pragma mark -
#pragma mark - ✈️UICollectionViewDelegateFlowLayout

#pragma mark - ✈️UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.collectionView registerClass:[MyCollectionCell class] forCellWithReuseIdentifier:MyCollectionCell.xl_identifier];

    WEAKSELF(self)
    // self.collectionView.mj_header.ignoredScrollViewContentInsetTop = 100;
    self.collectionView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //dispatch_after
        double delayInSeconds = 2.0f;
        dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(delayInNanoSeconds, dispatch_get_global_queue(0, 0), ^{
            [weakSelf.collectionView.mj_header endRefreshing];
        });
    }];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.collectionView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(100.f);
        make.left.right.equalTo(@0.f);
        make.height.equalTo(@50.f);
    }];
}

#pragma mark Lazy Property
- (NSArray<NSString *> *)dataList {
    if(!_dataList){
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:@"云南西双版纳 无花果4-6个装300g（单果60g+）"];
        [arr addObject:@"云南西双版纳 无花果4-6个装300g（单果60g+）云南西双版纳 无花果4-6个装300g（单果60g+）"];
        [arr addObject:@"云南西双版纳 无花果4-6个装300g（单果60g+）云南西双版纳 无花果4-6个装300g（单果60g+）云南西双版纳 无花果4-6个装300g（单果60g+）"];
        for (NSInteger i = 0; i < 20; i++) {
            [arr addObject:[NSString stringWithFormat:@"row: %ld", i]];
        }
        _dataList = [arr copy];
    }
    return _dataList;
}
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        CGRect collectFrame = CGRectZero;
        CGSize itemSize = CGSizeZero;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.estimatedItemSize = CGSizeMake(40, 50.f);
        // flowLayout.itemSize = CGSizeZero;
        flowLayout.minimumLineSpacing = 0.f;
        flowLayout.minimumInteritemSpacing = 0.f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionHeadersPinToVisibleBounds = YES;
        // flowLayout.sectionFootersPinToVisibleBounds = YES;
        // flowLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#HeaderSectionHeight#>);
        // flowLayout.footerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#FooterSectionHeight#>);
        flowLayout.sectionInset = UIEdgeInsetsZero;

        UICollectionView *cv = [[UICollectionView alloc]initWithFrame:collectFrame collectionViewLayout:flowLayout];
        cv.backgroundColor = [UIColor whiteColor];
        cv.showsHorizontalScrollIndicator = NO;
        cv.showsVerticalScrollIndicator = NO;
        // cv.pagingEnabled = YES;

        cv.delegate = self;
        cv.dataSource = self;

        _collectionView = cv;
    }
    return _collectionView;
}
@end
