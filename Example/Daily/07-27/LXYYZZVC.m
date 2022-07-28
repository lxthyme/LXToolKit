//
//  LXYYZZVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXYYZZVC.h"

#import "LXYYZZImageCell.h"
#import "DJYYZZInfoCell.h"
#import "DJYYZZHeaderView.h"
#import "DJYYZZFooterView.h"
#import "DJYYZZInfoModel.h"

#import <MWPhotoBrowser/MWPhotoBrowser.h>

#define kSectionInset UIEdgeInsetsMake(0, kWPercentage(10.f), 0, kWPercentage(10.f))

@interface LXYYZZVC()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, MWPhotoBrowserDelegate> {
}
@property(nonatomic, strong)NSArray<DJYYZZInfoModel *> *yyzzImageList;
@property(nonatomic, strong)NSArray<DJYYZZInfoModel *> *yyzzInfoList;
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)NSArray<MWPhoto *> *photoList;

@end

@implementation LXYYZZVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    [self prepareUI];
    [self prepareCollectionView];
    [self loadData];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)loadData {
    NSString *mockData = [self mockData];
    NSArray<DJYYZZInfoModel *> *yyzzInfoModelList = [NSArray yy_modelArrayWithClass:[DJYYZZInfoModel class] json:mockData];
    NSMutableArray *f_yyzzInfoModelList = [NSMutableArray arrayWithArray:yyzzInfoModelList];
    // [f_yyzzInfoModelList removeLastObject];
    if(f_yyzzInfoModelList.count % 2 != 0) {
        DJYYZZInfoModel *item = [[DJYYZZInfoModel alloc]init];
        item.f_isPlaceholder = YES;
        [f_yyzzInfoModelList addObject:item];
    }
    self.yyzzImageList = [f_yyzzInfoModelList copy];
    self.yyzzInfoList = [f_yyzzInfoModelList.rac_sequence filter:^BOOL(DJYYZZInfoModel *value) {
        return !isEmptyString(value.certificateTypeName) && !isEmptyString(value.extInfo);
    }].array;
    [self.collectionView reloadData];

    self.photoList = [f_yyzzInfoModelList.rac_sequence map:^id(DJYYZZInfoModel *value) {
        NSString *url = [value.imageUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        return [[MWPhoto alloc]initWithURL:[NSURL URLWithString:url]];
    }].array;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)showPreviewWithCurrentIndex:(NSInteger)idx {
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc]initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.alwaysShowControls = NO;
    browser.enableSwipeToDismiss = YES;
    browser.enableGrid = YES;
    browser.startOnGrid = NO;
    browser.autoPlayOnAppear = NO;

    // browser.customImageSelectedIconName = @"";
    // browser.customImageSelectedSmallIconName = @"";

    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];

    [browser setCurrentPhotoIndex:idx];
    [self.navigationController pushViewController:browser animated:YES];
}

#pragma mark -
#pragma mark - ✈️MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.yyzzImageList.count;
}
- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if(index < self.photoList.count) {
        return self.photoList[index];
    }
    return nil;
}

#pragma mark - ✈️UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 0) {
        return self.yyzzImageList.count;
    } else {
        return self.yyzzInfoList.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        LXYYZZImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXYYZZImageCell" forIndexPath:indexPath];
        DJYYZZInfoModel *item = self.yyzzImageList[indexPath.row];
        [cell dataFill:item isLeft:indexPath.row % 2 == 0];
        return cell;
    } else {
        DJYYZZInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DJYYZZInfoCell" forIndexPath:indexPath];
        DJYYZZInfoModel *item = self.yyzzInfoList[indexPath.row];
        [cell dataFill:item];
        return cell;
    }
}
#pragma mark -
#pragma mark - ✈️UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if(section == 0) {
        return kSectionInset;
    }
    return UIEdgeInsetsZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth(collectionView.frame);
    if(indexPath.section == 0) {
        UIEdgeInsets sectionInset = kSectionInset;
        CGFloat itemWidth = (width - (sectionInset.left + sectionInset.right)) / 2.f;
        return CGSizeMake(floorf(itemWidth), kWPercentage(105.f + 15.f));
    } else {
        DJYYZZInfoModel *item = self.yyzzInfoList[indexPath.row];
        return CGSizeMake(width, item.f_cellHeight);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat width = CGRectGetWidth(collectionView.frame);
    if(section == 0) {
        if(self.yyzzImageList.count > 0) {
            return CGSizeMake(width, kWPercentage(55.f));
        }
    }
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGFloat width = CGRectGetWidth(collectionView.frame);
    if(section == 0) {
        if(self.yyzzImageList.count > 0) {
            return CGSizeMake(width, kWPercentage(25.f));
        }
    }
    return CGSizeZero;
}
#pragma mark - ✈️UICollectionViewDelegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        if(self.yyzzImageList.count > 0) {
            if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
                DJYYZZHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                              withReuseIdentifier:@"DJYYZZHeaderView"
                                                                                     forIndexPath:indexPath];
                return header;
            } else if([kind isEqualToString:UICollectionElementKindSectionFooter]) {
                DJYYZZFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                              withReuseIdentifier:@"DJYYZZFooterView"
                                                                                     forIndexPath:indexPath];
                return footer;
            }
        }
    }
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0) {
        [self showPreviewWithCurrentIndex:indexPath.row];
    }
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.collectionView registerClass:[LXYYZZImageCell class] forCellWithReuseIdentifier:@"LXYYZZImageCell"];
    [self.collectionView registerClass:[DJYYZZInfoCell class] forCellWithReuseIdentifier:@"DJYYZZInfoCell"];
    [self.collectionView registerClass:[DJYYZZHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DJYYZZHeaderView"];
    [self.collectionView registerClass:[DJYYZZFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"DJYYZZFooterView"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor colorWithHex:0xF9F9F9];

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
- (UICollectionView *)collectionView {
    if(!_collectionView) {//
        CGRect collectFrame = CGRectZero;
        CGSize itemSize = CGSizeZero;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.estimatedItemSize = CGSizeZero;
        flowLayout.itemSize = itemSize;
        flowLayout.minimumLineSpacing = 0.f;
        flowLayout.minimumInteritemSpacing = 0.f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // flowLayout.sectionHeadersPinToVisibleBounds = YES;
        // flowLayout.sectionFootersPinToVisibleBounds = YES;
        // flowLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#HeaderSectionHeight#>);
        // flowLayout.footerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#FooterSectionHeight#>);
        flowLayout.sectionInset = UIEdgeInsetsZero;

        UICollectionView *cv = [[UICollectionView alloc]initWithFrame:collectFrame collectionViewLayout:flowLayout];
        cv.backgroundColor = [UIColor colorWithHex:0xF9F9F9];
        // cv.pagingEnabled = YES;

        cv.delegate = self;
        cv.dataSource = self;

        _collectionView = cv;
    }
    return _collectionView;
}
- (NSString *)mockData {
    return @"[{        \"updatedBy\":\"BL_CK\",        \"createdDate\":1634191051395,        \"createdBy\":\"陈国建\",        \"imageUrl\":\"https://img20.st.iblimg.com/sitemethod-2/store/certificateImg/2022/07/19/11.jpg\",        \"id\":\"a4ebb6560e9c4e60b3fd7b5fdc4a2790\",        \"updatedDate\":1658295272806,        \"storeId\":\"a8dc67a568b64f4f8e43a767704c7999\",        \"delFlag\":0,        \"certificateType\":1,        \"certificateTypeName\":\"营业执照\",        \"extInfo\":\"showtaaatttccc123\"    },{        \"updatedBy\":\"陈国建\",        \"createdDate\":1634193346205,        \"createdBy\":\"陈国建\",        \"imageUrl\":\"https://img20.st.iblimg.com/sitemethod-1/store/certificateImg/2021/10/14/QQ截图20190428102204.png\",        \"id\":\"c79c8202806b4245a8a2432b6eab8b67\",        \"updatedDate\":1658214674749,        \"storeId\":\"a8dc67a568b64f4f8e43a767704c7999\",        \"delFlag\":0,        \"certificateType\":4,        \"certificateTypeName\":\"医疗器械注册证\",        \"extInfo\":\"2323234234@@#$%^^&amp;\"    },{        \"updatedBy\":\"陈国建\",        \"imageUrl\":\"https://img20.st.iblimg.com/site-3/images/store/2018/07/152674834.png\",        \"id\":\"1312eqwe\",        \"updatedDate\":1658215279657,        \"storeId\":\"a8dc67a568b64f4f8e43a767704c7999\",        \"delFlag\":0,        \"certificateType\":1,        \"certificateTypeName\":\"营业执照\",        \"extInfo\":\"112233\"    },{        \"updatedBy\":\"陈国建\",        \"createdDate\":1634113265624,        \"createdBy\":\"陈国建\",        \"imageUrl\":\"https://img20.st.iblimg.com/sitemethod-1/store/certificateImg/te11634113256873.jpg\",        \"id\":\"07a9ea45093c409e9d0c7fc5a5a90ba3\",        \"updatedDate\":1634113265624,        \"storeId\":\"a8dc67a568b64f4f8e43a767704c7999\",        \"delFlag\":0,        \"certificateType\":4,        \"certificateTypeName\":\"医疗器械注册证\"    }]";
}
@end
