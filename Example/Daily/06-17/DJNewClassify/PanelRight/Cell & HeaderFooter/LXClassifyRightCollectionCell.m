//
//  LXClassifyRightCollectionCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyRightCollectionCell.h"

#import "DJNewAddCartView.h"
#import "DJClassifyMacro.h"
#import "DJTagView.h"
#import "DJPriceWrapperStackView.h"

@interface LXClassifyRightCollectionCell() {
}
@property(nonatomic, strong)UIImageView *imgViewGoodsLogo;
@property(nonatomic, strong)UIStackView *titleStackView;
@property(nonatomic, strong)UILabel *labTitle;
@property(nonatomic, strong)UILabel *labSubtitle;
/// tag List
@property(nonatomic, strong)UIView *tagWrapperView;
/// 24H 发货
@property(nonatomic, strong)DJTagView *td24HView;
@property(nonatomic, strong)UIStackView *priceWrapperStackView;
@property(nonatomic, strong)DJPriceWrapperStackView *topPriceStackView;
@property(nonatomic, strong)DJPriceWrapperStackView *bottomPriceStackView;
@property(nonatomic, strong)DJNewAddCartView *addCartView;

@end

@implementation LXClassifyRightCollectionCell
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self prepareUI];
    }
    return self;
}
- (void)prepareForReuse {
    [super prepareForReuse];
    self.imgViewGoodsLogo.image = nil;
    self.labTitle.text = @"";
    self.labTitle.attributedText = nil;
    self.labSubtitle.text = @"";
    self.labSubtitle.attributedText = nil;
    self.labSubtitle.hidden = YES;
    for(UIView *v in self.tagWrapperView.subviews) {
        [v removeFromSuperview];
    }
    self.tagWrapperView.hidden = YES;
    self.td24HView.hidden = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(LXGoodBaseItemModel *)item {
    switch (item.f_itemType) {
        case LXClassifyGoodItemTypeB2C: {
            LXB2CGoodItemModel *itemModel = (LXB2CGoodItemModel *)item;
            [self dataFillWithB2C:itemModel];
        }
            break;
        case LXClassifyGoodItemTypeO2O:{
            LXO2OGoodItemModel *itemModel = (LXO2OGoodItemModel *)item;
            [self dataFillWithO2O:itemModel];
        }
            break;
        default:
            break;
    }
}
- (void)dataFillWithO2O:(LXO2OGoodItemModel *)item {
    /// 1. logo
    // [self.imgViewGoodsLogo yy_setImageWithURL:[NSURL URLWithString:item.goodsImage]
    //                                   options:YYWebImageOptionProgressive |
    //  YYWebImageOptionAllowBackgroundTask |
    //  YYWebImageOptionAllowInvalidSSLCertificates |
    //  YYWebImageOptionSetImageWithFadeAnimation];
    [self.imgViewGoodsLogo bl_setImageWithUrl:[NSURL URLWithString:item.goodsImage]];
    /// 1. 标题
    self.labTitle.attributedText = item.f_titleAttributeString;
    /// 2. 副标题
    self.labSubtitle.attributedText = item.f_subtitleAttributeString;
    self.labSubtitle.hidden = isEmptyString(item.subtitle233);
    /// 3. tagList
    __block CGFloat yPoint = 0.f;
    self.tagWrapperView.hidden = item.f_popinfosList.array.count <= 0;
    for(UIView *v in self.tagWrapperView.subviews) {
        [v removeFromSuperview];
    }
    for (DJGoodItemPopinfosList *tmp in item.f_popinfosList.array) {
        DJTagView *tagView = [[DJTagView alloc]init];
        CGRect frame = CGRectMake(0, 0, 0, 0);
        frame.origin.y = yPoint;
        frame.size.width = CGRectGetWidth(tmp.f_textRect) + kTagListHPadding * 2;
        frame.size.height = kTagListHeight;
        tagView.frame = frame;
        yPoint = CGRectGetMaxX(frame) + kTagListInterval;
        [tagView dataFill:tmp];
        [self.tagWrapperView addSubview:tagView];
    }
    /// 4. 24H 发货
    if([item.tdType233 isEqualToString:@"2"]) {
        DJGoodItemPopinfosList *popInfoItem = [[DJGoodItemPopinfosList alloc]init];
        [popInfoItem didFinishTransformFromDictionary];
        popInfoItem.f_text = isEmptyString(item.tdLable233) ? @"24H发货" : item.tdLable233;
        popInfoItem.f_textColor = [UIColor colorWithHex:0x55C9BA alpha:1.f];
        popInfoItem.f_borderColor = [UIColor colorWithHex:0x55C9BA alpha:1.f];
        popInfoItem.f_cornerRadius = kTagListHeight / 2.f;
        [popInfoItem makeTextAttribute];
        self.td24HView.hidden = NO;
        [self.td24HView dataFill:popInfoItem];
    }
    /// 5.价格
    [self.topPriceStackView dataFill:@"" price:@"¥9900.80"];
    [self.bottomPriceStackView dataFill:@"" price:@"¥46.90"];
    /// 6. 加车按钮
    [self.addCartView dataFill:item.num233];
}
- (void)dataFillWithB2C:(LXB2CGoodItemModel *)item {
    /// 1. logo
    NSArray *logo10006 = arrayFromObject(item.pic, @"10006");
    [self.imgViewGoodsLogo bl_setImageWithUrl:[NSURL URLWithString:logo10006.firstObject]];
    /// 1. 标题
    self.labTitle.attributedText = item.f_titleAttributeString;
    /// 2. 副标题
    self.labSubtitle.attributedText = item.f_subtitleAttributeString;
    self.labSubtitle.hidden = isEmptyString(item.subtitle233);
    /// 3. tagList
    __block CGFloat yPoint = 0.f;
    self.tagWrapperView.hidden = item.f_popinfosList.array.count <= 0;
    for(UIView *v in self.tagWrapperView.subviews) {
        [v removeFromSuperview];
    }
    for (DJGoodItemPopinfosList *tmp in item.f_popinfosList.array) {
        DJTagView *tagView = [[DJTagView alloc]init];
        CGRect frame = CGRectMake(0, 0, 0, 0);
        frame.origin.y = yPoint;
        frame.size.width = CGRectGetWidth(tmp.f_textRect) + kTagListHPadding * 2;
        frame.size.height = kTagListHeight;
        tagView.frame = frame;
        yPoint = CGRectGetMaxX(frame) + kTagListInterval;
        [tagView dataFill:tmp];
        [self.tagWrapperView addSubview:tagView];
    }
    /// 4. 24H 发货
    if([item.tdType233 isEqualToString:@"2"]) {
        DJGoodItemPopinfosList *popInfoItem = [[DJGoodItemPopinfosList alloc]init];
        [popInfoItem didFinishTransformFromDictionary];
        popInfoItem.f_text = isEmptyString(item.tdLable233) ? @"24H发货" : item.tdLable233;
        popInfoItem.f_textColor = [UIColor colorWithHex:0x55C9BA alpha:1.f];
        popInfoItem.f_borderColor = [UIColor colorWithHex:0x55C9BA alpha:1.f];
        popInfoItem.f_cornerRadius = kTagListHeight / 2.f;
        [popInfoItem makeTextAttribute];
        [self.td24HView dataFill:popInfoItem];
    }
    /// 5.价格
    [self.topPriceStackView dataFill:@"" price:@"¥9900.80"];
    [self.bottomPriceStackView dataFill:@"" price:@"¥46.90"];
    /// 6. 加车按钮
    [self.addCartView dataFill:item.num233];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 8.f;
    self.contentView.clipsToBounds = YES;

    /// logo
    [self.contentView addSubview:self.imgViewGoodsLogo];

    [self.titleStackView addArrangedSubview:self.labTitle];
    [self.titleStackView addArrangedSubview:self.labSubtitle];
    [self.titleStackView addArrangedSubview:self.tagWrapperView];
    [self.contentView addSubview:self.titleStackView];

    [self.priceWrapperStackView addArrangedSubview:self.topPriceStackView];
    [self.priceWrapperStackView addArrangedSubview:self.bottomPriceStackView];
    [self.contentView addSubview:self.priceWrapperStackView];
    
    [self.contentView addSubview:self.addCartView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.imgViewGoodsLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(@(kPadding));
        make.left.equalTo(@0.f);
        make.bottom.lessThanOrEqualTo(@(kPadding));
        make.width.height.equalTo(@(kLogoWidth));
        make.centerY.equalTo(@0.f);
    }];
    [self.titleStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(@(kPadding));
        make.left.equalTo(self.imgViewGoodsLogo.mas_right).offset(kPadding);
        make.right.lessThanOrEqualTo(@0.f);
    }];
    [self.tagWrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(kTagListHeight));
    }];
    [self.priceWrapperStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleStackView);
        make.bottom.equalTo(@0.f).offset(-kPadding);
    }];
    [self.addCartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleStackView.mas_bottom).offset(kPadding);
        make.right.equalTo(@0.f);
        make.bottom.lessThanOrEqualTo(@(-kPadding));
    }];
}

#pragma mark Lazy Property
- (UIImageView *)imgViewGoodsLogo {
    if(!_imgViewGoodsLogo){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.backgroundColor = [UIColor lightGrayColor];
        // iv.image = [UIImage imageNamed:@""];
        _imgViewGoodsLogo = iv;
    }
    return _imgViewGoodsLogo;
}
- (UIStackView *)titleStackView {
    if(!_titleStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisVertical;
        sv.spacing = kTitleSpacing;
        _titleStackView = sv;
    }
    return _titleStackView;
}
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentLeft;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
- (UILabel *)labSubtitle {
    if(!_labSubtitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentLeft;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labSubtitle = label;
    }
    return _labSubtitle;
}
- (UIView *)tagWrapperView {
    if(!_tagWrapperView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        _tagWrapperView = v;
    }
    return _tagWrapperView;
}
- (DJTagView *)td24HView {
    if(!_td24HView){
        DJTagView *v = [[DJTagView alloc]init];
        _td24HView = v;
    }
    return _td24HView;
}
- (DJNewAddCartView *)addCartView {
    if(!_addCartView){
        DJNewAddCartView *v = [[DJNewAddCartView alloc]init];
        _addCartView = v;
    }
    return _addCartView;
}
- (UIStackView *)priceWrapperStackView {
    if(!_priceWrapperStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisVertical;
        sv.spacing = kWPercentage(3.5f);
        _priceWrapperStackView = sv;
    }
    return _priceWrapperStackView;
}
- (DJPriceWrapperStackView *)topPriceStackView {
    if(!_topPriceStackView){
        DJPriceWrapperStackView *v = [[DJPriceWrapperStackView alloc]init];
        _topPriceStackView = v;
    }
    return _topPriceStackView;
}
- (DJPriceWrapperStackView *)bottomPriceStackView {
    if(!_bottomPriceStackView){
        DJPriceWrapperStackView *v = [[DJPriceWrapperStackView alloc]init];
        _bottomPriceStackView = v;
    }
    return _bottomPriceStackView;
}


@end
