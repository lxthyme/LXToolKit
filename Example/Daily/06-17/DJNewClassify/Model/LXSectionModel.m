//
//  LXSectionModel.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXSectionModel.h"

#import "DJClassifyMacro.h"

@interface LXSectionItemModel() {
}

@end

@implementation LXSectionItemModel
#pragma mark -
#pragma mark - 🛠Life Cycle
- (BOOL)didFinishTransformFromDictionary {
    CGFloat maxWidth = SCREEN_WIDTH - kLeftTableWidth;
    maxWidth -= kPadding * 2;
    maxWidth -= kLogoWidth + kPadding;
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    self.f_titleMaxWidth = maxWidth;

    CGFloat rightHeight = 0.f;
    rightHeight += kPadding * 2;
    /// 1. 标题
    if(self.goodsItem.productName.length > 0) {
        UIFont *font = [UIFont systemFontOfSize:kWPercentage(14.f)];
        NSMutableAttributedString *titleAttr = [[NSMutableAttributedString alloc]initWithString:self.goodsItem.productName attributes:@{
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
    if(self.subtitle.length > 0) {
        UIFont *font = [UIFont systemFontOfSize:kWPercentage(11.f)];
        NSMutableAttributedString *subtitleAttr = [[NSMutableAttributedString alloc]initWithString:self.subtitle attributes:@{
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
    __block CGFloat allWidth = 0.f;
    self.f_popinfosList = [[self.goodsItem.f_popinfosList
                            map:^id(DJGoodItemPopinfosList *value) {
        value.f_cornerRadius = kTagListHeight / 2.f;
        [value makeTextAttribute];
        return value;
    }]
                           filter:^BOOL(DJGoodItemPopinfosList *value) {
        allWidth += CGRectGetWidth(value.f_textRect) + kTagListHPadding * 2 + kTagListInterval;
        return (allWidth - kTagListInterval) <= maxWidth;
    }];
    if(self.f_popinfosList.array.count > 0) {
        rightHeight += kTitleSpacing + kTagListHeight;
    }
    /// 4. 24H 发货
    if([self.goodsItem.tdType isEqualToString:@"2"]) {
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

#pragma mark -
#pragma mark - 🔐Private Actions

@end

@interface LXSectionModel() {
}

@end

@implementation LXSectionModel

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

@end

@interface LXSubCategoryModel() {
}

@end

@implementation LXSubCategoryModel

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

@end

@interface LXCategoryModel() {
}

@end

@implementation LXCategoryModel

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

@end
