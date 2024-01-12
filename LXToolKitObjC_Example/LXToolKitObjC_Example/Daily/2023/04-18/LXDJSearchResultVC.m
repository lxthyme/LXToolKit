//
//  LXDJSearchResultVC.m
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/4/18.
//
#import "LXDJSearchResultVC.h"
#import <Masonry/Masonry.h>
#import <YYText/YYText.h>
#import <DJRSwiftResource/DJRSwiftResource-Swift.h>
#import "UICollectionViewLeftAlignedLayout.h"

#import "LXDJSearchResultHeaderView.h"
#import "LXDJSearchHistoryCell.h"
#import "LXDJSearchHotRankListCell.h"

#define kHistorySectionInset UIEdgeInsetsMake(0, kWPercentage(15.f), 0, kWPercentage(15.f))
#define kHistorySectionminimumLineSpacing kWPercentage(10.f)
@interface LXDJSearchResultVC()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
}
@property(nonatomic, strong)UISearchBar *searchBar;
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)LXDJSearchHistoryCell *historyTestCell;

@property(nonatomic, strong)NSArray<NSDictionary *> *showingHistoryList;
@property(nonatomic, strong)NSArray<NSDictionary *> *allHistoryList;
@property(nonatomic, strong)NSArray<NSDictionary *> *discoveryList;
@property(nonatomic, strong)NSArray<NSDictionary *> *hotList;
@property(nonatomic, assign)BOOL isUnFolding;

@property(nonatomic, strong)YYLabel *lab2RD;

@end

@implementation LXDJSearchResultVC
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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    [self prepareUI];
    [self prepareCollectionView];
    [self dataFill];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill {
    NSArray *historyList = @[
        @{ @"title": @"年夜饭", @"isHot": @1 },
        @{ @"title": @"小年大吉", @"isHot": @0 },
        @{ @"title": @"团圆火锅", @"isHot": @1 },
        @{ @"title": @"买一送一", @"isHot": @0 },
        @{ @"title": @"鸡蛋", @"isHot": @0 },
        @{ @"title": @"葡萄柚", @"isHot": @0 },
        @{ @"title": @"纯牛奶", @"isHot": @0 },
        @{ @"title": @"砂糖橘", @"isHot": @0 },
        @{ @"title": @"汤圆", @"isHot": @0 },
        @{ @"title": @"年夜饭", @"isHot": @1 },
        @{ @"title": @"小年大吉", @"isHot": @0 },
        @{ @"title": @"团圆火锅", @"isHot": @1 },
    ];
    historyList = [self caclHistoryListSize:historyList];
    self.discoveryList = historyList;
    self.allHistoryList = [historyList.rac_sequence map:^id(NSDictionary *value) {
        NSMutableDictionary *tmp = [NSMutableDictionary dictionaryWithDictionary:value];
        tmp[@"isHot"] = @0;
        return tmp;
    }].array;
    self.showingHistoryList = [self format_historyList:self.allHistoryList];
    self.hotList = @[
        @{
            @"rank": @1,
            @"logo": @"",
            @"title": @"进口大串香蕉 重约900-1000g",
            @"tagList": @[@{
                @"tag": @"折",
                @"tagPlus": @"",
                @"content": @"99元6件",
            }],
            @"priceTag": @"",
            @"isPlusPrice": @0,
            @"price": @"¥8.80",
            @"huaxianPrice": @"¥12.90"
            // }
        }, @{
            @"rank": @2,
            @"logo": @"",
            @"title": @"四川春见耙耙柑 约750g 酸甜爽口颗粒饱, 四川春见耙耙柑 约750g 酸甜爽口颗粒饱",
            @"tagList": @[@{
                @"tag": @"折",
                @"tagPlus": @"",
                @"content": @"9折",
            }],
            @"priceTag": @"到手",
            @"isPlusPrice": @0,
            @"price": @"¥16.90",
            @"huaxianPrice": @"¥22.60"
        }, @{
            @"rank": @3,
            @"logo": @"",
            @"title": @"散装无抗土鸡蛋 500g",
            @"tagList": @[@{
                @"tag": @"折",
                @"tagPlus": @"",
                @"content": @"满赠",
            }],
            @"priceTag": @"新人",
            @"isPlusPrice": @0,
            @"price": @"¥9.80",
            @"huaxianPrice": @"¥10.60"
        }, @{
            @"rank": @4,
            @"logo": @"",
            @"title": @"光明优倍鲜牛奶250ml",
            @"tagList": @[@{
                @"tag": @"折",
                @"tagPlus": @"",
                @"content": @"129元减30元",
            }],
            @"isPlusPrice": @0,
            @"priceTag": @"预售",
            @"price": @"¥8.80",
            @"huaxianPrice": @"¥12.60"
        }, @{
            @"rank": @5,
            @"logo": @"",
            @"title": @"枸杞千禧小番茄250g",
            @"tagList": @[],
            @"priceTag": @"",
            @"isPlusPrice": @1,
            @"price": @"¥9.20",
            @"huaxianPrice": @"¥6.90"
        }, @{
            @"rank": @6,
            @"logo": @"",
            @"title": @"新疆阿克苏苹果800g",
            @"tagList": @[@{
                @"tag": @"",
                @"tagPlus": @"8折",
                @"content": @"",
            }, @{
                @"tag": @"折",
                @"tagPlus": @"",
                @"content": @"99元6件",
            }],
            @"priceTag": @"",
            @"isPlusPrice": @0,
            @"price": @"¥18.80",
            @"huaxianPrice": @"¥10.80"
        }
    ];
    [self.collectionView reloadData];

    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]init];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = kWPercentage(10.f);
    [result appendAttributedString:[[NSAttributedString alloc]initWithString:@"也可试试" attributes:@{
        NSParagraphStyleAttributeName:paragraphStyle,
        NSForegroundColorAttributeName:[UIColor colorWithHex:0X666666],
        NSFontAttributeName:[UIFont systemFontOfSize:kWPercentage(13.f)]
    }]];
    YYTextBorder *tagBorder = [[YYTextBorder alloc]init];
    tagBorder.fillColor = [UIColor colorWithHex:0xF6F8FB];
    tagBorder.cornerRadius = 22 / 2.f;
    // YYTextHighlight *tagHighlight = [[YYTextHighlight alloc]init];
    // [tagHighlight setBorder:tagBorder];
    // tagHighlight.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
    //     NSLog(@"text[1]: %@", text.string);
    // };
    NSString *obj = @"羊蝎子火锅";
    NSMutableAttributedString *tagAttr = [[NSMutableAttributedString alloc]initWithString:obj attributes:@{
        NSFontAttributeName: [UIFont boldSystemFontOfSize:kWPercentage(13.f)]
    }];
    // [tagAttr yy_setTextHighlight:tagHighlight range:NSMakeRange(0, obj.length)];
    [result appendAttributedString:tagAttr];

    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)];
    container.insets = UIEdgeInsetsMake(kWPercentage(20.f), kWPercentage(15.f), kWPercentage(10.f), kWPercentage(15.f));
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:result];

    self.lab2RD.textLayout = layout;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (NSArray *)caclHistoryListSize:(NSArray *)historyList {
    NSMutableArray *list = [NSMutableArray array];
    for (NSInteger i = 0; i < historyList.count; i++) {
        NSMutableDictionary *item = [historyList[i] mutableCopy];
        NSString *title = item[@"title"];
        [self.historyTestCell prepareForReuse];
        [self.historyTestCell data:item];
        CGFloat w = [self.historyTestCell calcCellSize:item];
        NSLog(@"-->[%ld]%@: %f", i, title, w);
        item[@"cellWidth"] = @(w);
        [list addObject:item];
    }
    return [list copy];
}
- (NSArray *)format_AllHistoryList:(NSArray *)historyList {
    NSMutableArray *list = [NSMutableArray array];
    [list addObjectsFromArray:historyList];
    [list addObject:@{
        @"isDown": @NO,
        @"isArrow": @1,
        @"cellWidth": @(kSearchHistoryCellHeight)
    }];
    return [list copy];
}
- (NSArray *)format_historyList:(NSArray *)historyList {
    UIEdgeInsets inset = kHistorySectionInset;
    CGFloat maxWidth = SCREEN_WIDTH - (inset.left + inset.right);
    CGFloat allWidth = 0.f;
    CGFloat row = 0;
    NSMutableArray *list = [NSMutableArray array];
    for (NSInteger i = 0; i < historyList.count; i++) {
        NSDictionary *item = historyList[i];
        CGFloat w = [item[@"cellWidth"] floatValue];
        allWidth += w;
        if(allWidth >= maxWidth) {
            row += 1;
            allWidth = w + kHistorySectionminimumLineSpacing;
            maxWidth -= kHistorySectionminimumLineSpacing + kSearchHistoryCellHeight + 1;
        } else {
            allWidth += kHistorySectionminimumLineSpacing;
        }
        if(row > 1) {
            break;
        }

        [list addObject:item];
    }
    [list addObject:@{
        @"isDown": @YES,
        @"isArrow": @1,
        @"cellWidth": @(kSearchHistoryCellHeight)
    }];
    return [list copy];
}

#pragma mark - ✈️UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 0) {
        return self.showingHistoryList.count;
    } else if(section == 1) {
        return self.discoveryList.count;
    } else if(section == 2) {
        return 1;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        LXDJSearchHistoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXDJSearchHistoryCell" forIndexPath:indexPath];
        NSDictionary *item = self.showingHistoryList[indexPath.row];
        [cell data:item];
        return cell;
    } else if(indexPath.section == 1) {
        LXDJSearchHistoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXDJSearchHistoryCell" forIndexPath:indexPath];
        NSDictionary *item = self.discoveryList[indexPath.row];
        [cell data:item];
        return cell;
    } else if(indexPath.section == 2) {
        if(self.hotList.count > 0) {
            LXDJSearchHotRankListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXDJSearchHotRankListCell" forIndexPath:indexPath];
            // NSDictionary *item = self.showingHistoryList[indexPath.row];
            // NSString *title = item[@"title"];
            // BOOL isHot = [item[@"isHot"] boolValue];
            [cell dataFill:self.hotList];
            return cell;
        }
    }
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
}

#pragma mark - ✈️UICollectionViewDelegate
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if(section == 0 || section == 1) {
        return kHistorySectionInset;
    }
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if(section == 0 || section == 1) {
        return kHistorySectionminimumLineSpacing;
    }
    return CGFLOAT_MIN;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if(section == 0 || section == 1) {
        return kHistorySectionminimumLineSpacing;
    }
    return CGFLOAT_MIN;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat width = CGRectGetWidth(collectionView.frame);
    if(section == 0) {
        if(self.showingHistoryList.count > 0) {
            return CGSizeMake(width, kWPercentage(50.f));
        }
    } else if(section == 1) {
        if(self.discoveryList.count > 0) {
            return CGSizeMake(width, kWPercentage(65.f));
        }
    } else if(section == 2) {
        return CGSizeMake(width, kWPercentage(30.f));
    }
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if(indexPath.section == 0) {
            if(self.showingHistoryList.count > 0) {
                LXDJSearchResultHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LXDJSearchResultHeaderView" forIndexPath:indexPath];
                header.actionBlock = ^(DJSearchResultHeaderStyle style) {
                    NSLog(@"style: %ld", style);
                };
                [header dataFill:@"搜索历史" style:DJSearchResultHeaderStyleDelete];
                return header;
            }
        } else if(indexPath.section == 1) {
            LXDJSearchResultHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LXDJSearchResultHeaderView" forIndexPath:indexPath];
            header.actionBlock = ^(DJSearchResultHeaderStyle style) {
                NSLog(@"style: %ld", style);
            };
            [header dataFill:@"搜索发现" style:DJSearchResultHeaderStyleRefresh];
            return header;
        }
    }
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        NSDictionary *item = self.showingHistoryList[indexPath.row];
        CGFloat w = [item[@"cellWidth"] floatValue];
        return CGSizeMake(w, kSearchHistoryCellHeight);
    } else if(indexPath.section == 1) {
        NSDictionary *item = self.discoveryList[indexPath.row];
        CGFloat w = [item[@"cellWidth"] floatValue];
        return CGSizeMake(w, kSearchHistoryCellHeight);
    } else {
        return CGSizeMake(CGRectGetWidth(collectionView.frame), kWPercentage(505.f));
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0) {
        NSDictionary *item = self.showingHistoryList[indexPath.row];
        BOOL isArrow = [item[@"isArrow"] boolValue];
        if(isArrow) {
            if(self.isUnFolding) {
                self.showingHistoryList = [self format_historyList:self.allHistoryList];
            } else {
                self.showingHistoryList = [self format_AllHistoryList:self.allHistoryList];
            }
            self.isUnFolding = !self.isUnFolding;
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }
    }
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerClass:[LXDJSearchHistoryCell class] forCellWithReuseIdentifier:@"LXDJSearchHistoryCell"];
    [self.collectionView registerClass:[LXDJSearchHotRankListCell class] forCellWithReuseIdentifier:@"LXDJSearchHotRankListCell"];
    [self.collectionView registerClass:[LXDJSearchResultHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LXDJSearchResultHeaderView"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
    [self.collectionView registerClass:[LXDJSearchResultHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.lab2RD];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.xl_safeAreaLayoutGuideTop);
        make.left.right.equalTo(@0.f);
        make.height.equalTo(@(kWPercentage(44.f)));
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar.mas_bottom);
        make.left.right.equalTo(@0.f);
        make.bottom.equalTo(self.view.xl_safeAreaLayoutGuideBottom);
    }];
    [self.lab2RD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kWPercentage(15.f)));
        make.right.equalTo(@(kWPercentage(-15.f)));
        make.centerY.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UISearchBar *)searchBar {
    if(!_searchBar){
        UISearchBar *v = [[UISearchBar alloc]init];
        v.showsCancelButton = YES;
        UIImageView *searchIcon = [[UIImageView alloc]init];
        searchIcon.image = DJTest.icon_search;
        // searchIcon.frame = CGRectMake(0, 0, kWPercentage(12.f + 14.f + 10.f), kWPercentage(30.f));
        v.searchTextField.backgroundColor = [UIColor whiteColor];
        v.searchTextField.layer.cornerRadius = kWPercentage(16.f);
        v.searchTextField.leftView = searchIcon;
        v.searchTextField.leftViewMode = UITextFieldViewModeAlways;
        v.searchTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"火锅季" attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:kWPercentage(13.f)],
            NSForegroundColorAttributeName: [UIColor xl_colorWithHexString:@"#999999"]
        }];
        _searchBar = v;
    }
    return _searchBar;
}
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        CGRect collectFrame = CGRectZero;
        // CGSize itemSize = CGSizeZero;
        UICollectionViewLeftAlignedLayout *flowLayout = [[UICollectionViewLeftAlignedLayout alloc]init];
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
        // flowLayout.itemSize = CGSizeMake(0.1, 0.1);
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
        cv.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;

        cv.delegate = self;
        cv.dataSource = self;

        _collectionView = cv;
    }
    return _collectionView;
}
- (LXDJSearchHistoryCell *)historyTestCell {
    if(!_historyTestCell){
        LXDJSearchHistoryCell *v = [[LXDJSearchHistoryCell alloc]init];
        _historyTestCell = v;
    }
    return _historyTestCell;
}
- (YYLabel *)lab2RD {
    if(!_lab2RD){
        UILabel *label = [[UILabel alloc]init];
        label.numberOfLines = 0;
        _lab2RD = label;
    }
    return _lab2RD;
}
@end
