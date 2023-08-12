//
//  DJCommentPictureView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/11.
//
#import "DJCommentPictureView.h"

#import "DJCommentPictureCell.h"

@interface DJCommentPictureView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
}
@property(nonatomic, strong)NSArray<NSString *> *dataList;
@property(nonatomic, strong)UICollectionView *collectionView;

@end

@implementation DJCommentPictureView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
        [self prepareCollectionView];
    }
    return self;
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill {
    NSInteger random = arc4random_uniform(5) + 1;
    NSMutableArray *list = [NSMutableArray array];
    [list addObject:@"https://img.xjh.me/random_img.php"];
    [list addObject:@"https://source.unsplash.com/random/200x200"];
    [list addObject:@"http://img.xjh.me/random_img.php?return=302"];
    for (NSInteger i = 0; i < random; i++) {
        [list addObject:[NSString stringWithFormat:@"https://loremflickr.com/200/200?random=%ld", i]];
    }
    self.dataList = [list copy];
    [self.collectionView reloadData];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark - ✈️UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DJCommentPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DJCommentPictureCell.xl_identifier forIndexPath:indexPath];
    NSString *item = self.dataList[indexPath.row];
    [cell dataFill:item];
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
    [self.collectionView xl_registerForCell:[DJCommentPictureCell class]];
}
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.collectionView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10.f);
        make.left.right.bottom.equalTo(@0.f);
        make.height.equalTo(@(kDJCommentPictureCellWidth));
    }];
}

#pragma mark Lazy Property
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.estimatedItemSize = CGSizeZero;
        flowLayout.itemSize = CGSizeMake(kDJCommentPictureCellWidth, kDJCommentPictureCellWidth);
        flowLayout.minimumLineSpacing = 5.f;
        flowLayout.minimumInteritemSpacing = 0.f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // flowLayout.sectionHeadersPinToVisibleBounds = YES;
        // flowLayout.sectionFootersPinToVisibleBounds = YES;
        // flowLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#HeaderSectionHeight#>);
        // flowLayout.footerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#FooterSectionHeight#>);
        flowLayout.sectionInset = UIEdgeInsetsZero;

        UICollectionView *cv = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
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
