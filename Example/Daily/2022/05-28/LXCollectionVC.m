//
//  LXCollectionVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/5/30.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import "LXCollectionVC.h"
#import "LXCollectionCell.h"

#define kCollectionCellIdentifier @"CellIdentifier"

@interface LXCollectionVC()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    MASConstraint *__heightConstraint;
}
@property(nonatomic, strong)UITextField *tfCount;
@property(nonatomic, strong)UICollectionView *collection;
@property(nonatomic, copy)NSArray *dataList;
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataList count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellIdentifier forIndexPath:indexPath];
    // cell.selectedBackgroundView = ({
    //     UIView *view_t = [[UIView alloc]init];
    //     [view_t setFrame:cell.frame];
    //     [view_t setBackgroundColor:[UIColor lightGrayColor]];
    //     view_t;
    // });
    cell.labTitle.text = self.dataList[indexPath.row];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
#pragma mark -
#pragma mark - ✈️<#CustomDelegate#>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth(collectionView.frame);
    return CGSizeMake(floorf(width / 5.0), 100);
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
    [self.collection registerClass:[LXCollectionCell class] forCellWithReuseIdentifier:kCollectionCellIdentifier];
}
- (void)prepareVM {
    @weakify(self)
    [[[[self.tfCount rac_textSignal]
      throttle:0.3]
     distinctUntilChanged]
    subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        NSInteger num = [x integerValue];
        if(num < 5) {
            num = 5;
        }
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = 0; i < num; i++) {
            [arr addObject:[NSString stringWithFormat:@"idx-%ld", i + 1]];
        }
        NSInteger fixedNum = MAX(5, MIN(20, arr.count));
        if(fixedNum > 10) {
            fixedNum = fixedNum / 2 * 2;
        }
        self.dataList = [arr subarrayWithRange:NSMakeRange(0, fixedNum)];
        if(self.dataList.count <= 10) {
            __heightConstraint.equalTo(@100.f);
        } else {
            __heightConstraint.equalTo(@200.f);
        }
        [self.collection reloadData];
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
        __heightConstraint = make.height.equalTo(@100.f);
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
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
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
