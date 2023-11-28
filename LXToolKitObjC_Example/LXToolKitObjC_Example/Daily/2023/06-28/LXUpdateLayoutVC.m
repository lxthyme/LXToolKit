//
//  LXUpdateLayoutVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/6/28.
//
#import "LXUpdateLayoutVC.h"

#import <Masonry/Masonry.h>

@interface LXUpdateLayoutVC() {
}
@property(nonatomic, strong)UIView *navView;
@property(nonatomic, strong)UIView *sectionView;
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)UIView *footerView;

@end

@implementation LXUpdateLayoutVC
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
    [self updateLayout];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions
- (void)updateLayout {
    //dispatch_after
    double delayInSeconds = 2.0f;
    dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(delayInNanoSeconds, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.sectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.navView.mas_bottom);
                make.left.right.equalTo(@0.f);
                make.height.equalTo(@80.f);
            }];
        });
    });
}

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.title = @"FirstVC";
    // self.view.backgroundColor = [UIColor colorWithHex:0xF4F6FA];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.sectionView];

    // self.gradientLayer.bounds = self.collectionView.bounds;
    // [self.collectionView.layer addSublayer:self.gradientLayer];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.footerView];
    // [self.view addSubview:self.backToTopButton];
    // UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // self.filterView.frame = keyWindow.bounds;
    // [self.view addSubview:self.filterView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.equalTo(@0.f);
        make.height.equalTo(@44.f);
    }];

    [self.sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom);
        make.left.right.equalTo(@0.f);
        make.height.equalTo(@0.f);
    }];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sectionView.mas_bottom);
        make.left.right.equalTo(@0.f);
    }];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
        make.height.equalTo(@50.f);
    }];
}

#pragma mark Lazy Property
- (UIView *)navView {
    if(!_navView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor orangeColor];
        _navView = v;
    }
    return _navView;
}
- (UIView *)sectionView {
    if(!_sectionView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor greenColor];
        _sectionView = v;
    }
    return _sectionView;
}
- (UICollectionView *)collectionView {
    if(!_collectionView) {//<#UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout#>
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

        // cv.delegate = self;
        // cv.dataSource = self;

        _collectionView = cv;
    }
    return _collectionView;
}
- (UIView *)footerView {
    if(!_footerView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor magentaColor];
        _footerView = v;
    }
    return _footerView;
}
@end
