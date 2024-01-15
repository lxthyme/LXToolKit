//
//  LXDJGoodsPriceView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/4/18.
//
#import "LXDJGoodsPriceView.h"
#import <Masonry/Masonry.h>
#import <DJRSwiftResource/DJRSwiftResource-Swift.h>
#import <DJRSwiftResource/UIFont+ex.h>

@interface LXDJGoodsPriceView() {
}
@property(nonatomic, strong)UIStackView *contentStackView;
@property(nonatomic, strong)UILabel *labPrefix;
@property(nonatomic, strong)UIImageView *imgViewPrefix;
@property(nonatomic, strong)UILabel *labPrice;

@end

@implementation LXDJGoodsPriceView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(NSDictionary *)item style:(DJGoodsPriceStyle)style {
    NSString *price = item[@"price"];
    BOOL isPlusPrice = NO;
    NSString *priceTag = item[@"priceTag"];
    if(style == DJGoodsPriceStyleHuaXian) {
        priceTag = @"";
        isPlusPrice = [item[@"isPlusPrice"] boolValue];
        price = item[@"huaxianPrice"];
    }
    self.labPrefix.hidden = YES;
    if(![priceTag isEmpty]) {
        self.labPrefix.hidden = NO;
        self.labPrefix.text = priceTag;
    }
    self.imgViewPrefix.hidden = YES;
    if(isPlusPrice) {
        style = DJGoodsPriceStylePlus;
        self.imgViewPrefix.hidden = NO;
        self.imgViewPrefix.image = DJTest.icon_tag_plus;
    }
    self.labPrice.hidden = NO;
    self.labPrice.attributedText = [self attrFormatFromPrice:price style:style];
}

#pragma mark -
#pragma mark - 👀Public Actions
- (NSAttributedString * _Nullable)attrFormatFromPrice:(NSString *)price style:(DJGoodsPriceStyle)style {
    if([price isEmpty]) {
        return nil;
    }
    NSAttributedString *priceAttr;
    switch (style) {
        case DJGoodsPriceStyleNormal: {
            priceAttr = [self attrPrice:price
                              textColor:[UIColor xl_colorWithHexString:@"#FF4515"]
                                rmbFont:[UIFont misansFontOfSize:kWPercentage(9.f)]
                              priceFont:[UIFont misansFontOfSize:kWPercentage(15.f)]
                            suffixFont:[UIFont misansFontOfSize:kWPercentage(11.f)]];
        } break;
        case DJGoodsPriceStyleHuaXian: {
            priceAttr = [self attrPrice:price
                              textColor:[UIColor xl_colorWithHexString:@"#999999"]
                                rmbFont:[UIFont misansFontOfSize:kWPercentage(9.f)]
                              priceFont:[UIFont misansFontOfSize:kWPercentage(10.f)]
                            suffixFont:nil];
        } break;
        case DJGoodsPriceStylePlus: {
            priceAttr = [self attrPrice:price
                              textColor:[UIColor xl_colorWithHexString:@"#222222"]
                                rmbFont:[UIFont misansFontOfSize:kWPercentage(9.f)]
                              priceFont:[UIFont misansFontOfSize:kWPercentage(13.f)]
                            suffixFont:[UIFont misansFontOfSize:kWPercentage(11.f)]];
        } break;
    }
    return priceAttr;
}
#pragma mark -
#pragma mark - 🔐Private Actions
- (NSAttributedString *)attrPrice:(NSString *)price
                        textColor:(UIColor *)textColor
                          rmbFont:(UIFont *)rmbFont
                        priceFont:(UIFont *)priceFont
                      suffixFont:(UIFont * _Nullable)suffixFont {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:price attributes:@{
        NSForegroundColorAttributeName: textColor,
        NSFontAttributeName: priceFont,
    }];
    if([price containsString:@"¥"]) {
        NSRange rangeOfRMB = [price rangeOfString:@"¥"];
        [attr addAttributes:@{
            NSFontAttributeName: rmbFont
        } range:rangeOfRMB];
    }
    NSMutableArray *tmp = [[price componentsSeparatedByString:@"."] mutableCopy];
    if(suffixFont && tmp.count >= 2) {
        [tmp removeObjectAtIndex:0];
        [tmp insertObject:@"." atIndex:0];
        NSString *suffixText = [tmp componentsJoinedByString:@"."];
        NSRange rangeOfSuffix = [price rangeOfString:suffixText];
        [attr addAttributes:@{
            NSFontAttributeName: suffixFont
        } range:rangeOfSuffix];
    }
    return [attr copy];
}
#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self.contentStackView addArrangedSubview:self.labPrefix];
    [self.contentStackView addArrangedSubview:self.imgViewPrefix];
    [self.contentStackView addArrangedSubview:self.labPrice];
    [self addSubview:self.contentStackView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.contentStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UIStackView *)contentStackView {
    if(!_contentStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisHorizontal;
        sv.alignment = UIStackViewAlignmentCenter;
        // sv.distribution = UIStackViewDistributionFillProportionally;
        sv.spacing = kWPercentage(2.5f);
        _contentStackView = sv;
    }
    return _contentStackView;
}
- (UILabel *)labPrefix {
    if(!_labPrefix){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont boldSystemFontOfSize:kWPercentage(10.f)];
        label.textColor = [UIColor xl_colorWithHexString:@"#FF4515"];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.hidden = YES;
        _labPrefix = label;
    }
    return _labPrefix;
}
- (UIImageView *)imgViewPrefix {
    if(!_imgViewPrefix){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        iv.hidden = YES;
        _imgViewPrefix = iv;
    }
    return _imgViewPrefix;
}
- (UILabel *)labPrice {
    if(!_labPrice){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labPrice = label;
    }
    return _labPrice;
}

@end
