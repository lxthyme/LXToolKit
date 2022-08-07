//
//  DJO2OCategoryListModel.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJO2OCategoryListModel.h"
#import <DJBusinessTools/NSString+ex.h>

@interface DJO2OCategoryListModel() {
}

@end

@implementation DJO2OCategoryListModel
#pragma mark -
#pragma mark - 🛠Life Cycle
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"rywCategorys": [DJO2OCategoryListModel class]
    };
}

#pragma mark -
#pragma mark - 👀Public Actions
/// 计算三级目录 size
- (void)calcCellSize {
    [self calcFoldCellSize];
    [self calcUnfoldCellSize];
}
- (void)calcUnfoldCellSize {
    CGFloat minimumLineSpacing = kT3UnfoldMinimumLineSpacing;
    CGFloat minimumInteritemSpacing = kT3UnfoldMinimumInteritemSpacing;
    UIEdgeInsets sectionInset = kT3UnfoldSectionInset;
    CGFloat itemWidth = SCREEN_WIDTH - kLeftTableWidth - (sectionInset.left + sectionInset.right + minimumLineSpacing + minimumInteritemSpacing);
    itemWidth /= 3.f;

    for (DJO2OCategoryListModel *item in self.rywCategorys) {
        CGSize size = [[item.categoryName xl_substringTo:16]
                       boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 16)
                       options:NSStringDrawingUsesFontLeading
                       attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:kWPercentage(12.f)]
        }
                       context:nil].size;
        if(size.width > itemWidth) {
            size.height = kWPercentage(50.f);
        } else {
            size.height = kWPercentage(35.f);
        }
        size.width = itemWidth;
        item.f_unfoldSize = size;
    }
    for (NSInteger i = 0; i < self.rywCategorys.count; i += 3) {
        DJO2OCategoryListModel *t1 = self.rywCategorys[i];
        DJO2OCategoryListModel *t2, *t3;
        CGFloat maxH = t1.f_unfoldSize.height;
        if((i + 1) < self.rywCategorys.count) {
            t2 = self.rywCategorys[i + 1];
            maxH = MAX(maxH, t2.f_unfoldSize.height);
        }
        if((i + 2) < self.rywCategorys.count) {
            t3 = self.rywCategorys[i + 2];
            maxH = MAX(maxH, t3.f_unfoldSize.height);
        }
        t1.f_unfoldSize = CGSizeMake(t1.f_unfoldSize.width, maxH);
        if(t2) {
            t2.f_unfoldSize = CGSizeMake(t2.f_unfoldSize.width, maxH);
        }
        if(t3) {
            t3.f_unfoldSize = CGSizeMake(t3.f_unfoldSize.width, maxH);
        }
    }
}
- (void)calcFoldCellSize {
    UIEdgeInsets sectionInset = kT3FoldSectionInset;
    for (DJO2OCategoryListModel *item in self.rywCategorys) {
        CGSize size = [[item.categoryName xl_substringTo:16]
                       boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 16)
                       options:NSStringDrawingUsesFontLeading
                       attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:kWPercentage(12.f)]
        } context:nil].size;
        item.f_foldSize = CGSizeMake(ceilf(size.width + kWPercentage(8.f)), kPinCategoryViewHeight - sectionInset.top - sectionInset.bottom);
    }
}

#pragma mark -
#pragma mark - 🔐Private Actions

@end
