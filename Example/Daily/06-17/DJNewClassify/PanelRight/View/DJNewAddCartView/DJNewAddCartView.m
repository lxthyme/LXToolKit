//
//  DJNewAddCartView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/5.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJNewAddCartView.h"

#import <DJBusinessTools/LXLabel.h>
#import "DJClassifyMacro.h"
#import <DJBusinessTools/DJGoodImageView.h>

@interface DJNewAddCartView() {
}
@property(nonatomic, strong)LXLabel *labNum;
@property(nonatomic, strong)UIButton *btnMinBuy;

@end

@implementation DJNewAddCartView
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
- (void)dataFillWithO2O:(DJO2OGoodItemModel *)item num:(NSInteger)num {
    self.labNum.hidden = YES;
    self.btnAdd.hidden = YES;
    self.btnMinBuy.hidden = YES;
    self.labNum.text = @"";
    if(item.minBuyQuan > 1) {
        self.btnMinBuy.hidden = NO;
        NSString *minBuySpec = item.minBuySpec;
        if(isEmptyString(minBuySpec)) {
            minBuySpec = @"件";
        }
        NSString *title = [NSString stringWithFormat:@"%ld%@起购", item.minBuyQuan, minBuySpec];
        [self.btnMinBuy setTitle:title forState:UIControlStateNormal];
    } else {
        self.labNum.hidden = NO;
        self.btnAdd.hidden = NO;
        self.labNum.text = [NSString stringWithFormat:@"%ld", num];
        self.labNum.hidden = !(num > 0);
        DJGoodImageViewLabelType type = [self getTypeFromGoodItem:item];
        if(type == DJGoodImageViewLabelTypeSoldout) {
            [self.btnAdd setImage:[iBLImage imageNamed:@"DJ_addshopcart_black"] forState:UIControlStateNormal];
            self.btnAdd.userInteractionEnabled = NO;
            self.labNum.backgroundColor = [UIColor colorWithHex:0xCCCCCC];
        } else {
            [self.btnAdd setImage:[iBLImage imageNamed:@"dj_addShoppingCart"] forState:UIControlStateNormal];
            self.btnAdd.userInteractionEnabled = YES;
            self.labNum.backgroundColor = [UIColor colorWithHex:0xFF774F];
        }
    }
}
- (void)dataFillWithB2C:(DJB2CGoodItemModel *)item num:(NSInteger)num {
    self.labNum.hidden = YES;
    self.btnAdd.hidden = YES;
    self.btnMinBuy.hidden = YES;
    self.labNum.text = @"";
    if(item.minBuyQuan > 1) {
        self.btnMinBuy.hidden = NO;
        NSString *minBuySpec = item.minBuySpec;
        if(isEmptyString(minBuySpec)) {
            minBuySpec = @"件";
        }
        NSString *title = [NSString stringWithFormat:@"%ld%@起购", item.minBuyQuan, minBuySpec];
        [self.btnMinBuy setTitle:title forState:UIControlStateNormal];
    } else {
        self.labNum.hidden = NO;
        self.btnAdd.hidden = NO;
        self.labNum.text = [NSString stringWithFormat:@"%ld", num];
        self.labNum.hidden = !(num > 0);
        DJGoodImageViewLabelType type = [self getTypeFromGoodItem:item];
        if(type == DJGoodImageViewLabelTypeSoldout) {
            [self.btnAdd setImage:[iBLImage imageNamed:@"DJ_addshopcart_black"] forState:UIControlStateNormal];
            self.btnAdd.userInteractionEnabled = NO;
            self.labNum.backgroundColor = [UIColor colorWithHex:0xCCCCCC];
        } else {
            [self.btnAdd setImage:[iBLImage imageNamed:@"dj_addShoppingCart"] forState:UIControlStateNormal];
            self.btnAdd.userInteractionEnabled = YES;
            self.labNum.backgroundColor = [UIColor colorWithHex:0xFF774F];
        }
    }
}

#pragma mark -
#pragma mark - 👀Public Actions
- (DJGoodImageViewLabelType )getTypeFromGoodItem:(DJGoodBaseItemModel *)item {
    DJGoodImageViewLabelType type = DJGoodImageViewLabelTypeDefault;
    NSInteger stockCount = -1;
    if (item.saleStockSum) {
        stockCount = [item.saleStockSum integerValue];;
    }

    if(stockCount < 3 && stockCount != -1){
        type = DJGoodImageViewLabelTypeTension;
    }

    if(!isEmptyString(item.limitBuyPersonSum) &&
       ![item.limitBuyPersonSum isEqualToString:@"0"]) {
        type = DJGoodImageViewLabelTypeLimit;
    }

    if([item.saleStockStatus isEqualToString:@"0"]){
        type = DJGoodImageViewLabelTypeSoldout;
    }

    if ([item.type isEqualToString:@"LH"] &&
        type == DJGoodImageViewLabelTypeTension) {
        if ([item.saleStockStatus integerValue] == 0) {
            type = DJGoodImageViewLabelTypeSoldout;
        }else{
            type = DJGoodImageViewLabelTypeDefault;
        }
    }

    return type;
}

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.btnAdd];
    [self addSubview:self.labNum];
    [self addSubview:self.btnMinBuy];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kAddCartTopHeight));
        make.left.greaterThanOrEqualTo(@0.f);
        make.bottom.equalTo(@0.f);
        make.right.equalTo(@(kWPercentage(-5.f)));
        make.width.height.equalTo(@(kAddCartLogoHeight));
    }];
    [self.labNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(@0.f);
        make.width.greaterThanOrEqualTo(@(kAddCartNumHeight));
        make.height.equalTo(@(kAddCartNumHeight));
    }];
    [self.btnMinBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(@0.f);
        make.left.right.bottom.equalTo(@0.f);
        make.height.equalTo(@(kWPercentage(20.f)));
    }];
}

#pragma mark Lazy Property
- (UIButton *)btnAdd {
    if(!_btnAdd){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[iBLImage imageNamed:@"icon_addCart"] forState:UIControlStateNormal];
        btn.contentEdgeInsets = UIEdgeInsetsZero;
        _btnAdd = btn;
    }
    return _btnAdd;
}
- (LXLabel *)labNum {
    if(!_labNum){
        LXLabel *label = [[LXLabel alloc]init];
        // label.x_insets = UIEdgeInsetsMake(0, kWPercentage(4.5f), 0, kWPercentage(4.5f));
        label.text = @"";
        label.font = [UIFont boldSystemFontOfSize:kWPercentage(9.f)];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor colorWithHex:0xFF774F];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.layer.cornerRadius = kAddCartNumHeight / 2.f;
        label.layer.borderColor = [UIColor whiteColor].CGColor;
        label.layer.borderWidth = 1.f;
        label.clipsToBounds = YES;
        _labNum = label;
    }
    return _labNum;
}
- (UIButton *)btnMinBuy {
    if(!_btnMinBuy){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithHex:0xFF774F];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:kWPercentage(12.f)];
        btn.contentEdgeInsets = UIEdgeInsetsMake(kWPercentage(3.f), kWPercentage(7.5f), kWPercentage(3.f), kWPercentage(7.5f));
        btn.layer.cornerRadius = kWPercentage(10.f);

        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnMinBuy = btn;
    }
    return _btnMinBuy;
}
@end
