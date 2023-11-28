//
//  LXScrollVC.m
//  tes
//
//  Created by lxthyme on 2023/6/19.
//
#import "LXScrollVC.h"

#import <Masonry/Masonry.h>
#import "MyCollectionCell.h"
#import "MainScrollView.h"

@interface LXScrollVC()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
}
@property(nonatomic, strong)UIControl *navView;
@property(nonatomic, strong)UILabel *sectionView;
@property(nonatomic, strong)UIView *wrapperView;
@property(nonatomic, strong)MainScrollView *bgScrollView;
@property(nonatomic, strong)NSArray<NSString *> *dataList;
@property(nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, assign)CGFloat prevMainOffsetY;
@property (nonatomic, assign)CGFloat prevChildOffsetY;
@property(nonatomic, assign)BOOL mainScrollEnable;
@property(nonatomic, assign)BOOL childScrollEnable;


@end

@implementation LXScrollVC
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
    // self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    // NSLog(@"🛠viewWillDisappear: %@", NSStringFromClass([self class]));
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    // NSLog(@"🛠viewDidDisappear: %@", NSStringFromClass([self class]));
    // self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.
    [self prepareUI];
    [self prepareCollectionView];

    [self.collectionView reloadData];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)back:(UIControl *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - ✈️UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionCell" forIndexPath:indexPath];
    cell.labTitle.text = self.dataList[indexPath.row];
    return cell;
}
#pragma mark -
#pragma mark - ✈️UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(collectionView.frame), 44.f);
}
#pragma mark - ✈️UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - ✈️UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat sectionHeight = 80;
    if(scrollView == self.bgScrollView) {
        /// 滑动方向:
        ///     0: 不动
        ///     1: 向上滑动
        ///     2: 向下滑动
        CGFloat bgScrollViewDirection = 0;
        if(self.prevMainOffsetY > offsetY) {
            /// 向下滚动
            bgScrollViewDirection = 2;
        } else if(self.prevMainOffsetY < offsetY) {
            /// 向上滚动
            bgScrollViewDirection = 1;
        }
        if(bgScrollViewDirection == 1 &&
                  (offsetY < sectionHeight && offsetY > 0)) {
            NSLog(@"下...");
            self.mainScrollEnable = YES;
            self.childScrollEnable = NO;
        } else if(!self.mainScrollEnable) {
            self.bgScrollView.contentOffset = CGPointMake(0, sectionHeight);
            self.childScrollEnable = YES;
        } else if(scrollView.contentOffset.y >= sectionHeight) {
            self.bgScrollView.contentOffset = CGPointMake(0, sectionHeight);
            self.mainScrollEnable = NO;
            self.childScrollEnable = YES;
        } else if(scrollView.contentOffset.y < 0) {
            self.bgScrollView.contentOffset = CGPointZero;
            self.childScrollEnable = YES;
        }
        self.prevMainOffsetY = offsetY;
    } else {
        if(!self.childScrollEnable) {
            self.collectionView.contentOffset = CGPointMake(0, self.prevChildOffsetY);
        } else if(scrollView.contentOffset.y <= 0) {
            self.prevChildOffsetY = 0;
            self.collectionView.contentOffset = CGPointMake(0, 0);
            self.childScrollEnable = NO;
            self.mainScrollEnable = YES;
        } else {
            self.prevChildOffsetY = offsetY;
        }
    }
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.collectionView registerClass:[MyCollectionCell class] forCellWithReuseIdentifier:@"MyCollectionCell"];
}
- (void)prepareUI {
    self.title = @"Test";
    self.view.backgroundColor = [UIColor cyanColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.mainScrollEnable = YES;
    self.childScrollEnable = NO;

    [self.view addSubview:self.navView];
    [self.wrapperView addSubview:self.sectionView];
    [self.wrapperView addSubview:self.collectionView];
    [self.bgScrollView addSubview:self.wrapperView];
    [self.view addSubview:self.bgScrollView];
    // [self.view addSubview:self.wrapperView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64.f);
        make.left.right.equalTo(@0.f);
        make.height.equalTo(@44.f);
    }];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.edges.width.height.equalTo(@0.f);
        make.top.equalTo(self.navView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
        // make.width.equalTo(self.view);
        // make.height.equalTo(self.view);
    }];
    [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
        // make.width.height.equalTo(self.bgScrollView);
        make.width.height.equalTo(self.view);
        // make.top.equalTo(self.navView.mas_bottom);
        // make.left.right.bottom.equalTo(@0.f);
    }];
    [self.sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.top.equalTo(self.navView.mas_bottom);
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@100.f);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sectionView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
        // make.height.equalTo(@400.f);
    }];
}

#pragma mark Lazy Property
- (UIControl *)navView {
    if(!_navView){
        UIControl *v = [[UIControl alloc]init];
        v.backgroundColor = [UIColor lightTextColor];
        [v addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        _navView = v;
    }
    return _navView;
}
// - (UIView *)sectionView {
//     if(!_sectionView){
//         UIView *v = [[UIView alloc]init];
//         v.backgroundColor = [UIColor lightGrayColor];
//         _sectionView = v;
//     }
//     return _sectionView;
// }
- (UILabel *)sectionView {
    if(!_sectionView){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"SectionView";
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor lightGrayColor];
        label.numberOfLines = 0;
        // label.textAlignment = <#NSTextAlignmentCenter#>;
        // label.lineBreakMode = <#NSLineBreakByTruncatingTail#>;
        _sectionView = label;
    }
    return _sectionView;
}
- (UIView *)wrapperView {
    if(!_wrapperView){
        UIView *v = [[UIView alloc]init];
        _wrapperView = v;
    }
    return _wrapperView;
}
- (MainScrollView *)bgScrollView {
    if(!_bgScrollView){
        MainScrollView *sv = [[MainScrollView alloc]init];
        sv.backgroundColor = [UIColor whiteColor];
        // sv.pagingEnabled = <#YES#>;
        // sv.bounds = <#YES#>;
        sv.showsVerticalScrollIndicator = NO;
        sv.showsHorizontalScrollIndicator = NO;
        // sv.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        sv.delegate = self;
        // sv.scrollEnabled = NO;
        if (@available(iOS 11.0, *)) {
            sv.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _bgScrollView = sv;
    }
    return _bgScrollView;
}
- (NSArray<NSString *> *)dataList {
    if(!_dataList){
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = 0; i < 50; i++) {
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
        flowLayout.estimatedItemSize = CGSizeZero;
        flowLayout.itemSize = itemSize;
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
        // cv.scrollEnabled = NO;

        cv.delegate = self;
        cv.dataSource = self;

        _collectionView = cv;
    }
    return _collectionView;
}
@end
