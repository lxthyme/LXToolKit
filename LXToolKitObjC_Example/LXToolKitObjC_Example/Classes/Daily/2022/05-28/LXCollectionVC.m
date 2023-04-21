//
//  LXCollectionVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/5/30.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import "LXCollectionVC.h"
#import "LXCollectionCell.h"
#import <LXToolKitObjC/UIView+MASSafeAreaLayoutGuide.h>

#define kCollectionCellIdentifier1 @"CellIdentifier1"
#define kCollectionCellIdentifier2 @"CellIdentifier2"

@interface LXCollectionVC()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    MASConstraint *__heightConstraint;
}
@property(nonatomic, strong)UITextField *tfCount;
@property(nonatomic, strong)UICollectionView *collection;
@property(nonatomic, strong)NSMutableArray *dataList1;
@property(nonatomic, copy)NSArray *dataList2;
@end

@implementation LXCollectionVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.dataList1 = [NSMutableArray array];
    self.dataList2 = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    [self prepareUI];
    [self prepareCollectionView];
    [self prepareVM];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 0) {
        return [self.dataList1 count];
    } else {
        return [self.dataList2 count];
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        LXCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellIdentifier1 forIndexPath:indexPath];
        cell.labTitle.text = [NSString stringWithFormat:@"%@", self.dataList1[indexPath.row]];
        return cell;
    } else {
        LXCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellIdentifier2 forIndexPath:indexPath];
        cell.labTitle.text = self.dataList2[indexPath.row];
        return cell;
    }
}
#pragma mark - UICollectionViewDelegate
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8, 8, 8, 8);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.f;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0) {
    } else {
        // [self.dataList1 addObject:@(self.dataList1.count + 1)];
        NSMutableArray *ds = [NSMutableArray array];
        for (NSNumber *num in self.dataList1) {
            [ds addObject:num];
        }
        [ds addObject:@(self.dataList1.count + 1)];
        self.dataList1 = ds;
        // [self.collection reloadData];
        // NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
        // [set addIndex:1];
        // [set addIndex:0];
        // [self.collection reloadSections:set];
        [UIView performWithoutAnimation:^{
            [self.collection performBatchUpdates:^{
                [self.collection reloadSections:[NSIndexSet indexSetWithIndex:0]];
                [self.collection reloadSections:[NSIndexSet indexSetWithIndex:1]];
            } completion:nil];
        }];
    }
}
#pragma mark -
#pragma mark - ✈️<#CustomDelegate#>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth(collectionView.frame);
    if(indexPath.section == 0) {
        return CGSizeMake(width, 200);
    } else {
        return CGSizeMake(floorf((width - 8.f * 2 - 5.f) / 2.0), 400);
    }
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {// <#[self prepareUI];#>
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.tfCount];
    [self.view addSubview:self.collection];

    [self masonry];
}
- (void)prepareCollectionView {
    [self.collection registerClass:[LXCollectionCell class] forCellWithReuseIdentifier:kCollectionCellIdentifier1];
    [self.collection registerClass:[LXCollectionCell class] forCellWithReuseIdentifier:kCollectionCellIdentifier2];
}
- (void)prepareVM {
    // @weakify(self)
    // @weakify(__heightConstraint)
    // [[[[self.tfCount rac_textSignal]
    //   throttle:0.3]
    //  distinctUntilChanged]
    // subscribeNext:^(NSString * _Nullable x) {
    //     @strongify(self)
    //     @strongify(__heightConstraint)
    //     NSInteger num = [x integerValue];
    //     if(num < 5) {
    //         num = 5;
    //     }
    //     NSMutableArray *arr = [NSMutableArray array];
    //     for (NSInteger i = 0; i < num; i++) {
    //         [arr addObject:[NSString stringWithFormat:@"idx-%ld", i + 1]];
    //     }
    //     NSInteger fixedNum = MAX(5, MIN(20, arr.count));
    //     if(fixedNum > 10) {
    //         fixedNum = fixedNum / 2 * 2;
    //     }
    //     self.dataList1 = [arr subarrayWithRange:NSMakeRange(0, fixedNum)];
    //     if(self.dataList1.count <= 10) {
    //         __heightConstraint.equalTo(@100.f);
    //     } else {
    //         __heightConstraint.equalTo(@200.f);
    //     }
    //     [self.collection reloadData];
    // }];
    __block CGFloat previousY = 0.f;
    [[RACObserve(self.collection, contentOffset)
     takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(id x) {
        CGPoint offset = [x CGPointValue];
        NSLog(@"-2->contentSize: %lf", offset.y);
        if(previousY > offset.y) {
            NSLog(@"-2->DDDDD: %lf -> %lf", previousY, offset.y);
        }
        previousY = offset.y;
    }];
}

#pragma mark Masonry
- (void)masonry {
    [self.tfCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.collection.mas_top).offset(-20.f);
        make.centerX.equalTo(@0.f);
        make.width.equalTo(self.view).dividedBy(3.f);
    }];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@200.f);
        make.left.right.equalTo(@0.f);
        make.bottom.equalTo(self.view.xl_safeAreaLayoutGuideBottom);
        // __heightConstraint = make.height.equalTo(@100.f);
    }];
}

#pragma mark Lazy Property
- (UITextField *)tfCount {
    if(!_tfCount){
        //<UITextFieldDelegate>
        UITextField *tf = [[UITextField alloc]init];
        [tf setFrame:CGRectZero];
        [tf setBackgroundColor:[UIColor whiteColor]];
        [tf setPlaceholder:@"请输入分类球数量"];
        tf.borderStyle = UITextBorderStyleBezel;
        // [tf setSecureTextEntry:<#BOOL#>];
        [tf setReturnKeyType:UIReturnKeyDone];
        [tf setKeyboardType:UIKeyboardTypeNumberPad];
        _tfCount = tf;
    }
    return _tfCount;
}
- (UICollectionView *)collection {
    if(!_collection){
        CGRect collectFrame = CGRectZero;
        CGSize itemSize = CGSizeZero;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setItemSize:itemSize];
        // [flowLayout setEstimatedItemSize:<#itemSize#>];
        [flowLayout setMinimumLineSpacing:0];
        [flowLayout setMinimumInteritemSpacing:0];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        // [flowLayout setHeaderReferenceSize:CGSizeMake(CGRectGetWidth(collectFrame), <#HeaderSectionHeight#>)];
        // [flowLayout setFooterReferenceSize:CGSizeMake(CGRectGetWidth(collectFrame), <#FooterSectionHeight#>)];
        [flowLayout setSectionInset:UIEdgeInsetsZero];
        UICollectionView *cv = [[UICollectionView alloc]initWithFrame:collectFrame collectionViewLayout:flowLayout];
        [cv setBackgroundColor:[UIColor whiteColor]];
        // [<#_collectionView#> setPagingEnabled:YES];

        cv.delegate = self;
        cv.dataSource = self;
        _collection = cv;
    }
    return _collection;
}
@end
