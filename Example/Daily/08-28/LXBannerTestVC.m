//
//  LXBannerTestVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/8/12.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBannerTestVC.h"

#import <Masonry/Masonry.h>
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface LXBannerTestVC()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, SDCycleScrollViewDelegate> {
}
@property(nonatomic, strong)SDCycleScrollView *bannerView;
@property(nonatomic, strong)UICollectionView *dotCollectionView;
@property(nonatomic, strong)UIImageView *imgViewTabbar;
@property(nonatomic, assign)NSInteger currentIdx;

@end

@implementation LXBannerTestVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    [self prepareCollectionView];
    [self prepareUI];
    [self dataFill];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill {
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.imgViewTabbar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    [self.imgViewTabbar bl_setImageWithUrl:[NSURL URLWithString:@"https://Img.iblimg.com/fast2home-2/images/kdj/index/2022/03/785364561.png"]];
    self.bannerView.imageURLStringsGroup = @[
        @"https://unsplash.it/400/200/?random",
        @"https://unsplash.it/400/200/?random",
        @"https://unsplash.it/400/200/?random",
        @"https://unsplash.it/400/200/?random",
    ];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    self.currentIdx = index;
    [self.dotCollectionView reloadData];
}

#pragma mark - ✈️UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.contentView.layer.cornerRadius = kWPercentage(2.f);
    cell.contentView.clipsToBounds = YES;
    if(self.currentIdx == indexPath.row) {
        cell.contentView.backgroundColor = [UIColor colorWithHex:0xFFFFFF alpha:0.6f];
    } else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
#pragma mark -
#pragma mark - ✈️UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == self.currentIdx) {
        return CGSizeMake(kWPercentage(9.f), kWPercentage(4.f));
    }
    return CGSizeMake(kWPercentage(4.5f), kWPercentage(4.f));
}

#pragma mark - ✈️UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.dotCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.bannerView];
    [self.view addSubview:self.dotCollectionView];
    [self.view addSubview:self.imgViewTabbar];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@200.f);
        make.left.equalTo(@15.f);
        make.right.equalTo(@-15.f);
        make.height.equalTo(@200.f);
    }];
    [self.dotCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0.f);
        make.bottom.equalTo(self.bannerView.mas_bottom).offset(-10.f);
        make.height.equalTo(@(kWPercentage(4.f)));
        make.width.equalTo(@200.f);
    }];
    [self.imgViewTabbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bannerView.mas_bottom).offset(20.f);
        make.left.right.equalTo(@0.f);
        make.height.equalTo(@55.f);
    }];
}

#pragma mark Lazy Property
- (SDCycleScrollView *)bannerView {
    if(!_bannerView){
        SDCycleScrollView *v = [[SDCycleScrollView alloc]init];
        v.autoScrollTimeInterval = 3.f;
        v.infiniteLoop = YES;
        v.delegate = self;
        // v.placeholderImage = [iBLImage imageNamed:@""];
        v.layer.cornerRadius = kWPercentage(4.f);
        v.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
        v.pageControlDotSize = CGSizeMake(kWPercentage(9.f), kWPercentage(4.f));
        v.currentPageDotImage = [iBLImage imageNamed:@"icon_classify_dot"];
        v.pageDotImage = [iBLImage imageNamed:@"icon_classify_pageDot"];
        v.clipsToBounds = YES;
        v.showPageControl = NO;
        _bannerView = v;
    }
    return _bannerView;
}
- (UICollectionView *)dotCollectionView {
    if(!_dotCollectionView) {
        CGRect collectFrame = CGRectZero;
        CGSize itemSize = CGSizeZero;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.estimatedItemSize = CGSizeZero;
        flowLayout.itemSize = itemSize;
        flowLayout.minimumLineSpacing = 0.f;
        flowLayout.minimumInteritemSpacing = kWPercentage(6.f);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionHeadersPinToVisibleBounds = YES;
        // flowLayout.sectionFootersPinToVisibleBounds = YES;
        // flowLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#HeaderSectionHeight#>);
        // flowLayout.footerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#FooterSectionHeight#>);
        flowLayout.sectionInset = UIEdgeInsetsZero;

        UICollectionView *cv = [[UICollectionView alloc]initWithFrame:collectFrame collectionViewLayout:flowLayout];
        cv.backgroundColor = [UIColor clearColor];
        // cv.pagingEnabled = YES;

        cv.delegate = self;
        cv.dataSource = self;

        _dotCollectionView = cv;
    }
    return _dotCollectionView;
}
- (UIImageView *)imgViewTabbar {
    if(!_imgViewTabbar){
        UIImageView *iv = [[UIImageView alloc]init];
        // iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewTabbar = iv;
    }
    return _imgViewTabbar;
}

@end
