//
//  DJO2OGoodItemModel.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJO2OGoodItemModel.h"

@interface DJO2OGoodItemModel() {
}

@end

@implementation DJO2OGoodItemModel
#pragma mark -
#pragma mark - 🛠Life Cycle
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"t_id": @"id"

    };
}

- (BOOL)didFinishTransformFromDictionary {
    /// 设置默认值
    CGFloat maxWidth = SCREEN_WIDTH - kLeftTableWidth;
    maxWidth -= kPadding * 2;
    maxWidth -= kLogoWidth + kPadding;
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    self.f_titleMaxWidth = maxWidth;

    CGFloat rightHeight = 0.f;
    rightHeight += kPadding * 2;
    /// 1. 标题
    NSString *title = self.productName;
    if(!isEmptyString(title)) {
        UIFont *font = [UIFont systemFontOfSize:kWPercentage(14.f)];
        NSMutableAttributedString *titleAttr = [[NSMutableAttributedString alloc]
                                                initWithString:title
                                                attributes:@{
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: [UIColor colorWithHex:0x333333]
        }];
        self.f_titleAttributeString = titleAttr;

        CGSize size = [titleAttr boundingRectWithSize:maxSize
                                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                              context:nil].size;
        rightHeight += MIN(font.lineHeight * 2, size.height);
    }
    /// 2. 副标题
    NSString *subtitle = self.pointTitle;
    if(!isEmptyString(subtitle)) {
        UIFont *font = [UIFont systemFontOfSize:kWPercentage(11.f)];
        NSMutableAttributedString *subtitleAttr = [[NSMutableAttributedString alloc]initWithString:subtitle attributes:@{
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: [UIColor colorWithHex:0x999999]
        }];
        self.f_subtitleAttributeString = subtitleAttr;

        CGSize size = [subtitleAttr boundingRectWithSize:maxSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 context:nil].size;
        rightHeight += kTitleSpacing + MIN(font.lineHeight * 2, size.height);
    }

    /// 3. tagList
    self.f_popinfosList = [[self.popinfosList.rac_sequence filter:^BOOL(DJGoodItemPopinfosList *value) {
        return value.ruletype != DJRuleType12;
    }] map:^id(DJGoodItemPopinfosList *value) {
        if([value.buyMember isEqualToString:@"1"]) {
            value.f_borderWidth = 0.f;
            value.f_cornerRadius = 3.f;
            value.f_textFont = [UIFont boldSystemFontOfSize:kWPercentage(10.f)];
            value.f_textColor = [UIColor colorWithHex:0x191B22 alpha:0.8];
            value.f_borderColor = [UIColor colorWithHex:0x191B22 alpha:0.8];
            value.f_backgroundColor = [UIColor colorWithHex:0xF7C3A7];
        } else {
            value.f_borderWidth = 1.f;
            value.f_cornerRadius = 7.5f;
        }
        value.f_text = value.sLabel;
        [value makeTextAttribute];
        return value;
    }];
    __block CGFloat allWidth = 0.f;
    self.f_popinfosList = [[self.f_popinfosList
                            map:^id(DJGoodItemPopinfosList *value) {
        value.f_cornerRadius = kTagListHeight / 2.f;
        [value makeTextAttribute];
        return value;
    }]
                           filter:^BOOL(DJGoodItemPopinfosList *value) {
        allWidth += CGRectGetWidth(value.f_textRect) + kTagListHPadding * 2 + kTagListInterval;
        if([value.buyMember isEqualToString:@"1"]) {
            allWidth += kWPercentage(15.f);
        }
        return (allWidth - kTagListInterval) <= maxWidth;
    }];
    if(self.f_popinfosList.array.count > 0) {
        rightHeight += kTitleSpacing + kTagListHeight;
    }
    /// 4. 24H 发货
    if([self.tdType isEqualToString:@"2"]) {
        rightHeight += kTitleSpacing + kTagListHeight;
    }
    /// 5. 价格
    rightHeight += kPadding + kPriceWrapperHeight + kPadding;
    /// 6. finally cellHeight
    CGFloat leftHeight = kLogoWidth + kPadding * 2;
    self.f_cellHeight = MAX(leftHeight, ceilf(rightHeight));

    return YES;
}

#pragma mark -
#pragma mark - 👀Public Actions
- (NSString *)xl_goodsName {
    return self.productName;
}

#pragma mark -
#pragma mark - 🔐Private Actions

@end
