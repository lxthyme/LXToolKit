//
//  LXJXCategoryCustomCell.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/8/16.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "LXJXCategoryCustomCell.h"
#import "LXJXCategoryCustomCellModel.h"

@interface LXJXCategoryCustomCell()
@property (nonatomic, strong) CALayer *bgLayer;
@end

@implementation LXJXCategoryCustomCell

- (void)initializeViews {
    [super initializeViews];

    self.bgLayer = [CALayer layer];
    [self.contentView.layer insertSublayer:self.bgLayer atIndex:0];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    LXJXCategoryCustomCellModel *myCellModel = (LXJXCategoryCustomCellModel *)self.cellModel;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGFloat bgWidth = self.contentView.bounds.size.width;
    if (myCellModel.backgroundWidth != JXCategoryViewAutomaticDimension) {
        bgWidth = myCellModel.backgroundWidth;
    }
    CGFloat bgHeight = self.contentView.bounds.size.height;
    if (myCellModel.backgroundHeight != JXCategoryViewAutomaticDimension) {
        bgHeight = myCellModel.backgroundHeight;
    }
    self.bgLayer.bounds = CGRectMake(0, 0, bgWidth, bgHeight);
    self.bgLayer.position = self.contentView.center;
    [CATransaction commit];
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    LXJXCategoryCustomCellModel *myCellModel = (LXJXCategoryCustomCellModel *)cellModel;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.bgLayer.borderWidth = myCellModel.borderLineWidth;
    self.bgLayer.cornerRadius = myCellModel.backgroundCornerRadius;
    if (myCellModel.isSelected) {
        self.bgLayer.backgroundColor = myCellModel.selectedBackgroundColor.CGColor;
        self.bgLayer.borderColor = myCellModel.selectedBorderColor.CGColor;
    }else {
        self.bgLayer.backgroundColor = myCellModel.normalBackgroundColor.CGColor;
        self.bgLayer.borderColor = myCellModel.normalBorderColor.CGColor;
    }
    [CATransaction commit];

    self.titleLabel.numberOfLines = myCellModel.titleNumberOfLines;
    if (myCellModel.isSelected && myCellModel.selectedAttributeTitle != nil) {
        self.titleLabel.attributedText = myCellModel.selectedAttributeTitle;
    }else {
        self.titleLabel.attributedText = myCellModel.attributeTitle;
    }

    self.maskTitleLabel.numberOfLines = myCellModel.titleNumberOfLines;
    if (myCellModel.isSelected && myCellModel.selectedAttributeTitle != nil) {
        self.maskTitleLabel.attributedText = myCellModel.selectedAttributeTitle;
    }else {
        self.maskTitleLabel.attributedText = myCellModel.attributeTitle;
    }
}

@end
