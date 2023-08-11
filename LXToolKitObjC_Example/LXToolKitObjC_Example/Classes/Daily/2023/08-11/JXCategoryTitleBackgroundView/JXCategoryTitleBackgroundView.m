//
//  JXCategoryTitleBackgroundView.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/8/16.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryTitleBackgroundView.h"

@implementation JXCategoryTitleBackgroundView

- (void)initializeData {
    [super initializeData];

    self.normalBackgroundColor = [UIColor lightGrayColor];
    self.normalBorderColor = [UIColor clearColor];
    self.selectedBackgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
    self.selectedBorderColor = [UIColor orangeColor];
    self.borderLineWidth = 0.f;
    self.backgroundCornerRadius = 0.f;
    self.backgroundWidth = JXCategoryViewAutomaticDimension;
    self.backgroundHeight = 25;
}

//返回自定义的cell class
- (Class)preferredCellClass {
    return [JXCategoryTitleBackgroundCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        JXCategoryTitleBackgroundCellModel *cellModel = [[JXCategoryTitleBackgroundCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];

}

- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];

}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    if (self.cellWidth == JXCategoryViewAutomaticDimension) {
        return ceilf([self.attributeTitles[index] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size.width);
    }else {
        return self.cellWidth;
    }
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    JXCategoryTitleBackgroundCellModel *myModel = (JXCategoryTitleBackgroundCellModel *)cellModel;
    myModel.normalBackgroundColor = self.normalBackgroundColor;
    myModel.normalBorderColor = self.normalBorderColor;
    myModel.selectedBackgroundColor = self.selectedBackgroundColor;
    myModel.selectedBorderColor = self.selectedBorderColor;
    myModel.borderLineWidth = self.borderLineWidth;
    myModel.backgroundCornerRadius = self.backgroundCornerRadius;
    myModel.backgroundWidth = self.backgroundWidth;
    myModel.backgroundHeight = self.backgroundHeight;

    myModel.titleNumberOfLines = self.titleNumberOfLines;
    myModel.attributeTitle = self.attributeTitles[index];
    myModel.selectedAttributeTitle = self.selectedAttributeTitles[index];
}


@end
