//
//  DJPriceWrapperStackView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/8.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJPriceWrapperStackView.h"

#import <BLCategories/UIColor+Hex.h>

@interface DJPriceWrapperStackView() {
}
@property(nonatomic, strong)UIImageView *imgViewLogo;

@end

@implementation DJPriceWrapperStackView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareUI];
    }
    return self;
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(NSString *)logo price:(NSString *)price {
    self.imgViewLogo.image = [iBLImage imageNamed:logo];
    self.imgViewLogo.hidden = logo.length <= 0;
    self.labTitle.text = price;
}
- (void)dataFillTopWith:(NSString *)price priceType:(DJGoodsPriceType)priceType {
    NSDictionary *info = @{
        /// 新人
        @(DJGoodsPriceNewUserType): @"price_newUser",
        //        @(DJGoodsPriceXianGouType): @"限购",
        /// 到手
        @(DJGoodsPriceRealType): @"price_daoShou",
        /// 预售
        @(DJGoodsPricePreSellType): @"price_yuShou",
    };
    self.imgViewLogo.hidden = YES;
    if(priceType == DJGoodsPriceRealType ||
       priceType == DJGoodsPricePreSellType ||
       priceType == DJGoodsPriceNewUserType) {
        UIImage *priceTagImg = [iBLImage imageNamed:info[@(priceType)]];
        self.imgViewLogo.image = priceTagImg;
        self.imgViewLogo.hidden = NO;
    }

    NSString *fmtPrice = [NSString stringWithFormat:@"¥%.2f", [price doubleValue]];
    NSMutableAttributedString *fmtPriceAttr = [[NSMutableAttributedString alloc]
                                               initWithString:fmtPrice
                                               attributes:@{
        NSFontAttributeName: [UIFont boldSystemFontOfSize:kWPercentage(17.f)],
        NSForegroundColorAttributeName: [UIColor colorWithHex:0xFF4A4A]
    }];
    [fmtPriceAttr addAttributes:@{
        NSFontAttributeName: [UIFont boldSystemFontOfSize:kWPercentage(9.f)]
    } range:[fmtPrice rangeOfString:@"¥"]];
    self.labTitle.attributedText = [fmtPriceAttr copy];
}
- (void)dataFillBottomWith:(DJO2OGoodItemModel *)item {
    NSString *price = @"";

    self.imgViewLogo.hidden = YES;
    if(isEmptyString(item.plusPrice)) {
        if([item.salePrice doubleValue] < [item.basePrice doubleValue]) {
            price = item.basePrice;
        }
    } else {
        price = item.plusPrice;
        self.imgViewLogo.image = [iBLImage imageNamed:@"dj_plus"];
    }
    self.labTitle.hidden = YES;
    self.hidden = YES;
    if(!isEmptyString(price)) {
        NSString *fmtPrice = [NSString stringWithFormat:@"¥%.2f", [price doubleValue]];
        NSMutableAttributedString *fmtPriceAttr = [[NSMutableAttributedString alloc]
                                                   initWithString:fmtPrice
                                                   attributes:@{
            NSFontAttributeName: [UIFont boldSystemFontOfSize:kWPercentage(11.f)],
            NSForegroundColorAttributeName: [UIColor colorWithHex:0x999999],
            NSStrikethroughColorAttributeName: [UIColor colorWithHex:0x999999],
            NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle)
        }];
        [fmtPriceAttr addAttributes:@{
            NSFontAttributeName: [UIFont boldSystemFontOfSize:kWPercentage(9.f)]
        } range:[fmtPrice rangeOfString:@"¥"]];
        self.labTitle.attributedText = [fmtPriceAttr copy];
        self.labTitle.hidden = NO;
        self.hidden = NO;
    }
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];
    self.axis = UILayoutConstraintAxisHorizontal;
    self.alignment = UIStackViewAlignmentCenter;
    self.spacing = kWPercentage(5.f);

    [self addArrangedSubview:self.imgViewLogo];
    [self addArrangedSubview:self.labTitle];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.imgViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kWPercentage(22.f)));
    }];
}

#pragma mark Lazy Property
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
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}

@end
