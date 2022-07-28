//
//  DJYYZZInfoModel.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJYYZZInfoModel.h"

@interface DJYYZZInfoModel() {
}

@end

@implementation DJYYZZInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"t_id": @"id"
    };
}
- (BOOL)didFinishTransformFromDictionary {
    if(!isEmptyString(self.extInfo) && !isEmptyString(self.certificateTypeName)) {
        CGFloat f_cellHeight = 0.f;
        f_cellHeight += kWPercentage(18.f + 18.f);
        f_cellHeight += kWPercentage(20.f);
        CGFloat maxWidth = SCREEN_WIDTH - kWPercentage(30.f * 2);
        NSAttributedString *attr = [[NSAttributedString alloc]
                                    initWithString:self.certificateTypeName
                                    attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:kWPercentage(14.f)]
        }];
        CGSize size = [attr boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                         context:nil].size;
        f_cellHeight += kWPercentage(4.f) + MAX(kWPercentage(20.f), size.height);
        f_cellHeight = ceilf(f_cellHeight);
        self.f_cellHeight = f_cellHeight;
    }
    return YES;
}
#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

@end
