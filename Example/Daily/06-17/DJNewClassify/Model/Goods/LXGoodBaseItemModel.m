//
//  LXGoodBaseItemModel.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXGoodBaseItemModel.h"

@interface LXGoodBaseItemModel() {
}

@end

@implementation LXGoodBaseItemModel

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

@end

@implementation DJGoodItemPopinfosList
#pragma mark -
#pragma mark - 🛠Life Cycle
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"t_id": @"id",
    };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"rules": [DJGoodItemRule class]
    };
}
#pragma mark -
#pragma mark - 🔐Private Actions
- (BOOL)didFinishTransformFromDictionary {
    /// 设置默认值
    self.f_cornerRadius = 0.f;
    self.f_borderWidth = 1.f;
    self.f_textColor = [UIColor colorWithHex:0xFF4A4A];
    self.f_borderColor = [UIColor colorWithHex:0xFF4A4A];
    self.f_backgroundColor = [UIColor colorWithHex:0xffffff];
    self.f_textFont = [UIFont systemFontOfSize:kWPercentage(9.f)];
    return YES;
}

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)makeTextAttribute {
    self.f_textAttributeString = [[NSAttributedString alloc]
                                  initWithString:self.f_text
                                  attributes:@{
        NSFontAttributeName: self.f_textFont,
        NSForegroundColorAttributeName: self.f_textColor,
    }];
    self.f_textRect = [self.f_textAttributeString
                       boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.f_textFont.lineHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                       context:nil];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

@end

@implementation DJGoodItemRule
#pragma mark -
#pragma mark - 🛠Life Cycle
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"t_id": @"id",
    };
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

@end
