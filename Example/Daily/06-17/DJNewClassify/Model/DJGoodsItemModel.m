//
//  DJGoodsItemModel.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/8.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJGoodsItemModel.h"

#import "DJClassifyMacro.h"

@interface DJGoodsItemModel() {
}

@end

@implementation DJGoodsItemModel
#pragma mark -
#pragma mark - 🛠Life Cycle
// + (NSDictionary *)modelContainerPropertyGenericClass {
//     return @{
//         @"popinfosList": [DJGoodsPopinfosList class]
//     };
// }
// - (BOOL)didFinishTransformFromDictionary {
//     /// 3. tagList
//     self.f_popinfosList = [[self.popinfosList.rac_sequence filter:^BOOL(DJGoodsPopinfosList *value) {
//         return value.ruletype != DJGoodsRuleType12;
//     }] map:^id(DJGoodsPopinfosList *value) {
//         if([value.buyMember isEqualToString:@"1"]) {
//             value.f_borderWidth = 0.f;
//             value.f_cornerRadius = 3.f;
//             value.f_textFont = [UIFont boldSystemFontOfSize:kWPercentage(10.f)];
//             value.f_textColor = [UIColor colorWithHex:0x191B22 alpha:0.8];
//             value.f_borderColor = [UIColor colorWithHex:0x191B22 alpha:0.8];
//             value.f_backgroundColor = [UIColor colorWithHex:0xF7C3A7];
//         } else {
//             value.f_borderWidth = 1.f;
//             value.f_cornerRadius = 7.5f;
//         }
//         value.f_text = value.sLabel;
//         [value makeTextAttribute];
//         return value;
//     }];
//     return YES;
// }

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

@end
