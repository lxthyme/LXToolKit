//
//  LXDJSearchRankItemCell.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/4/18.
//
#import "LXDJSearchRankItemCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <DJRSwiftResource/DJRSwiftResource-Swift.h>
#import <UICollectionViewLeftAlignedLayout/UICollectionViewLeftAlignedLayout.h>

#import "LXDJGoodsPriceView.h"
#import "LXDJGoodsTagCell.h"

@interface LXDJSearchRankItemCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegateLeftAlignedLayout> {
}
@property(nonatomic, strong)UIImageView *imgViewRank;
@property(nonatomic, strong)UIImageView *imgViewLogo;
@property(nonatomic, strong)UILabel *labTitle;
@property(nonatomic, strong)UICollectionView *tagCollectionView;
@property(nonatomic, strong)LXDJGoodsPriceView *normalPriceView;
@property(nonatomic, strong)LXDJGoodsPriceView *huaXianPriceView;
@property(nonatomic, strong)UIImageView *imgViewAddCart;
@property(nonatomic, strong)LXDJGoodsTagCell *tagCell;

@property(nonatomic, strong)MASConstraint *tagCollectionViewWidthConstraint;
@property(nonatomic, strong)NSDictionary *item;

@end

@implementation LXDJSearchRankItemCell
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self prepareUI];
        [self prepareCollectionView];
    }
    return self;
}
- (void)prepareForReuse {
    [super prepareForReuse];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
// - (CGSize)intrinsicContentSize {
//     CGSize size = [super intrinsicContentSize];
//     size.height += kWPercentage(15.f);
//     return size;
// }
- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = UIEdgeInsetsInsetRect(self.contentView.frame, UIEdgeInsetsMake(0, 0, kWPercentage(15.f), 0));
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(NSDictionary *)item {
    self.item = item;
    self.imgViewRank.image = [DJTest getRankIconFrom:[item[@"rank"] integerValue]];
    [self.imgViewLogo sd_setImageWithURL:[NSURL URLWithString:@"https://unsplash.it/400/400/?random"]
                        placeholderImage:nil];
    self.labTitle.text = item[@"title"];
    [self.normalPriceView dataFill:item style:DJGoodsPriceStyleNormal];
    [self.huaXianPriceView dataFill:item style:DJGoodsPriceStyleHuaXian];
    self.imgViewAddCart.image = DJTest.icon_addCart;

    NSArray *tagList = self.item[@"tagList"];
    NSLog(@"-->tagList: %ld", tagList.count);
    self.tagCollectionView.hidden = tagList.count <= 0;
    [self.tagCollectionView reloadData];
    // [self calcTagSize:tagList];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)calcTagSize:(NSArray *)tagList {
    __block CGFloat fullWidth = 0.f;
    WEAKSELF(self)
    [tagList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // weakSelf.tagCell.frame = CGRectMake(0, 0, 20.f, 10.f);
        // weakSelf.tagCell.contentView.frame = CGRectMake(0, 0, 20.f, 10.f);
        [weakSelf.tagCell prepareForReuse];
        [weakSelf.tagCell setNeedsUpdateConstraints];
        [weakSelf.tagCell setNeedsFocusUpdate];
        [weakSelf.tagCell setNeedsLayout];
        [weakSelf.tagCell setNeedsDisplay];
        [weakSelf.tagCell dataFill:obj];
        [weakSelf.tagCell layoutIfNeeded];
        [weakSelf.tagCell updateFocusIfNeeded];
        [weakSelf.tagCell updateConstraintsIfNeeded];
        fullWidth += CGRectGetWidth(weakSelf.tagCell.contentStackView.frame);
    }];
    if(tagList.count > 1) {
        fullWidth += kWPercentage(10.f) * tagList.count;
    }
    fullWidth = MAX(200.f, fullWidth);
    self.tagCollectionViewWidthConstraint.equalTo(@(fullWidth));
    NSLog(@"-->fullWidth: %.f \t%@", fullWidth, self.tagCell);
}

#pragma mark - ✈️UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *tagList = self.item[@"tagList"];
    return tagList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXDJGoodsTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXDJGoodsTagCell" forIndexPath:indexPath];
    NSArray *tagList = self.item[@"tagList"];
    NSDictionary *item = tagList[indexPath.row];
    [cell dataFill:item];
    return cell;
}
#pragma mark -
#pragma mark - ✈️UICollectionViewDelegateLeftAlignedLayout

#pragma mark - ✈️UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.tagCollectionView registerClass:[LXDJGoodsTagCell class] forCellWithReuseIdentifier:@"LXDJGoodsTagCell"];
}
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self.imgViewLogo addSubview:self.imgViewRank];
    [self.contentView addSubview:self.imgViewLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.tagCollectionView];
    [self.contentView addSubview:self.normalPriceView];
    [self.contentView addSubview:self.huaXianPriceView];
    [self.contentView addSubview:self.imgViewAddCart];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.imgViewLogo, self.imgViewRank,
                  self.labTitle, self.tagCollectionView,
                  self.normalPriceView, self.huaXianPriceView,
                  self.imgViewAddCart)
    [self.imgViewRank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.imgViewLogo);
    }];
    [self.imgViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0.f);
        make.left.equalTo(@(kWPercentage(10.f)));
        make.width.equalTo(@(kWPercentage(60.f)));
    }];
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgViewLogo);
        make.left.equalTo(self.imgViewLogo.mas_right).offset(kWPercentage(10.f));
        make.right.lessThanOrEqualTo(@(kWPercentage(-10.f)));
    }];
    [self.tagCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(kWPercentage(5.f));
        make.left.equalTo(self.labTitle);
        make.right.lessThanOrEqualTo(@(kWPercentage(-10.f)));
        make.height.equalTo(@(kDJGoodsTagViewHeight));
        // self.tagCollectionViewWidthConstraint = make.width.equalTo(@(100.f));
    }];
    [self.normalPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labTitle);
        make.bottom.equalTo(self.imgViewLogo);
    }];
    [self.huaXianPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.normalPriceView.mas_right).offset(kWPercentage(10.f));
        make.bottom.equalTo(self.normalPriceView);
    }];
    [self.imgViewAddCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(kWPercentage(-15.f)));
        make.bottom.equalTo(self.imgViewLogo);
    }];
}

#pragma mark Lazy Property
- (UIImageView *)imgViewRank {
    if(!_imgViewRank){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewRank = iv;
    }
    return _imgViewRank;
}

- (UIImageView *)imgViewLogo {
    if(!_imgViewLogo){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewLogo = iv;
    }
    return _imgViewLogo;
}
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont boldSystemFontOfSize:kWPercentage(12.f)];
        label.textColor = [UIColor xl_colorWithHexString:@"#444444"];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
- (UICollectionView *)tagCollectionView {
    if(!_tagCollectionView) {
        CGRect collectFrame = CGRectZero;
        UICollectionViewLeftAlignedLayout *flowLayout = [[UICollectionViewLeftAlignedLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
        flowLayout.itemSize = CGSizeMake(30.f, kDJGoodsTagViewHeight);
        // flowLayout.itemSize = CGSizeZero;
        flowLayout.minimumInteritemSpacing = kWPercentage(5.f);
        flowLayout.minimumLineSpacing = 0.f;
        flowLayout.sectionHeadersPinToVisibleBounds = YES;
        flowLayout.sectionInset = UIEdgeInsetsZero;

        UICollectionView *cv = [[UICollectionView alloc]initWithFrame:collectFrame collectionViewLayout:flowLayout];
        cv.backgroundColor = [UIColor whiteColor];
        cv.showsHorizontalScrollIndicator = NO;
        cv.showsVerticalScrollIndicator = NO;

        cv.delegate = self;
        cv.dataSource = self;

        _tagCollectionView = cv;
    }
    return _tagCollectionView;
}
- (LXDJGoodsPriceView *)normalPriceView {
    if(!_normalPriceView){
        LXDJGoodsPriceView *v = [[LXDJGoodsPriceView alloc]init];
        _normalPriceView = v;
    }
    return _normalPriceView;
}
- (LXDJGoodsPriceView *)huaXianPriceView {
    if(!_huaXianPriceView){
        LXDJGoodsPriceView *v = [[LXDJGoodsPriceView alloc]init];
        _huaXianPriceView = v;
    }
    return _huaXianPriceView;
}
- (UIImageView *)imgViewAddCart {
    if(!_imgViewAddCart){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewAddCart = iv;
    }
    return _imgViewAddCart;
}
- (LXDJGoodsTagCell *)tagCell {
    if(!_tagCell){
        LXDJGoodsTagCell *v = [[LXDJGoodsTagCell alloc]initWithFrame:CGRectZero];
        _tagCell = v;
    }
    return _tagCell;
}
@end
