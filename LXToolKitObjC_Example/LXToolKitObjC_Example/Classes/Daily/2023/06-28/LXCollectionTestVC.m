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
@property(nonatomic, strong)CAGradientLayer *gradientLayer;

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
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGRect frame = self.collectionView.bounds;
    frame = self.view.bounds;
    CGFloat y = 20;
    frame.origin.y = y;
    frame.size.height -= y;
    self.gradientLayer.frame = frame;
    // self.gradientLayer.anchorPoint = CGPointZero;
    [self.collectionView.backgroundView.layer insertSublayer:self.gradientLayer atIndex:0];
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(CGRectGetWidth(collectionView.frame), 100);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:UICollectionReusableView.xl_identifier forIndexPath:indexPath];
        header.backgroundColor = [UIColor cyanColor];
        return header;
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.collectionView registerClass:[MyCollectionCell class] forCellWithReuseIdentifier:MyCollectionCell.xl_identifier];
    [self.collectionView xl_registerForSectionHeader:[UICollectionReusableView class]];

    WEAKSELF(self)
    // self.collectionView.mj_header.ignoredScrollViewContentInsetTop = 100;
    // self.collectionView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
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

    // self.collectionView.lay
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundView = v;
    [self.view addSubview:self.collectionView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);//.offset(100.f);
        make.left.right.equalTo(@0.f);
        // make.height.equalTo(@50.f);
        make.bottom.equalTo(@0.f);
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
        // flowLayout.estimatedItemSize = CGSizeMake(40, 50.f);
        // flowLayout.itemSize = CGSizeZero;
        flowLayout.estimatedItemSize = CGSizeZero;
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, 100.f);
        flowLayout.minimumLineSpacing = 0.f;
        flowLayout.minimumInteritemSpacing = 0.f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionHeadersPinToVisibleBounds = NO;
        // flowLayout.sectionFootersPinToVisibleBounds = YES;
        // flowLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#HeaderSectionHeight#>);
        // flowLayout.footerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#FooterSectionHeight#>);
        flowLayout.sectionInset = UIEdgeInsetsZero;

        UICollectionView *cv = [[UICollectionView alloc]initWithFrame:collectFrame collectionViewLayout:flowLayout];
        cv.backgroundColor = [UIColor clearColor];
        cv.showsHorizontalScrollIndicator = NO;
        cv.showsVerticalScrollIndicator = NO;
        // cv.pagingEnabled = YES;

        cv.delegate = self;
        cv.dataSource = self;

        _collectionView = cv;
    }
    return _collectionView;
}
- (CAGradientLayer *)gradientLayer {
    if(!_gradientLayer){
        CAGradientLayer *v = [[CAGradientLayer alloc]init];
        // 设置渐变颜色数组
        v.colors = @[
            (__bridge id)[[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor,
            (__bridge id)[[UIColor lightGrayColor] colorWithAlphaComponent:0.7].CGColor,
            // (__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0.1].CGColor,
            // (__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:1].CGColor
        ];
        // 设置渐变起始点
        v.startPoint = CGPointMake(0, 0);
        // 设置渐变结束点
        v.endPoint = CGPointMake(0, 1);
        v.cornerRadius = kWPercentage(15.f);
        // 设置渐变颜色分布区间，不设置则均匀分布
        // gradientLayer.locations = @[@(0.0), @(1.0)];
        // 设置渐变类型，不设置则按像素均匀变化
        // gradientLayer.type = kCAGradientLayerAxial;// 按像素均匀变化
        _gradientLayer = v;
    }
    return _gradientLayer;
}
@end
