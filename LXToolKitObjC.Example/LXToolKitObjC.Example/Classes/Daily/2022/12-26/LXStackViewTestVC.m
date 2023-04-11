//
//  LXStackViewTestVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/12/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXStackViewTestVC.h"

#import "LXStackViewCell.h"

@interface LXStackViewTestVC()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
}
@property(nonatomic, strong)NSArray<NSString *> *dataList;
@property(nonatomic, strong)UICollectionView *collectionView;

@end

@implementation LXStackViewTestVC
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
    LXStackViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXStackViewCell" forIndexPath:indexPath];
    cell.labTitle.text = self.dataList[indexPath.row];
    return cell;
}
#pragma mark -
#pragma mark - ✈️UICollectionViewDelegateFlowLayout

#pragma mark - ✈️UICollectionViewDelegate
// - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//     // if(indexPath.row <= 5) {
//     //     return CGSizeMake(300, 50.f);
//     // }
//     return UICollectionViewFlowLayoutAutomaticSize;
// }
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"--->didSelectItemAtIndexPath: %ld", indexPath.row);
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.collectionView registerClass:[LXStackViewCell class] forCellWithReuseIdentifier:@"LXStackViewCell"];
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
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (NSArray<NSString *> *)dataList {
    if(!_dataList){
        NSMutableArray *arr = [NSMutableArray array];
        NSArray *templ = @[
        @"马来西亚进口 福多巧克力瑞士卷 108g",
        @"马来西亚进口 福多巧克力瑞士卷 108g",
        @"马来西亚进口 福多巧克力瑞士卷 108g",
        @"马来西亚进口 福多巧克力瑞士卷 108g",
        @"马来西亚进口 福多巧克力瑞士卷 108g",
        @"马来西亚进口 福多巧克力瑞士卷 108g",
        @"马来西亚进口 福多巧克力瑞士卷 108g",
        @"马来西亚进口 福多巧克力瑞士卷 108g",
        @"马来西亚进口 福多巧克力瑞士卷 108g",
        @"马来西亚进口 福多巧克力瑞士卷 108g",
        ];
        for (NSInteger i = 0; i < 20; i++) {
            [arr addObject:[NSString stringWithFormat:@"row: %ld: %@", i,
                            [[templ subarrayWithRange:NSMakeRange(0, i % templ.count)] componentsJoinedByString:@" | "]
                           ]];
        }
        _dataList = [arr copy];
    }
    return _dataList;
}
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        CGRect collectFrame = CGRectZero;
        CGSize itemSize = CGSizeMake(414, 120);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
        flowLayout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
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
        // cv.pagingEnabled = YES;

        cv.delegate = self;
        cv.dataSource = self;

        _collectionView = cv;
    }
    return _collectionView;
}
@end
