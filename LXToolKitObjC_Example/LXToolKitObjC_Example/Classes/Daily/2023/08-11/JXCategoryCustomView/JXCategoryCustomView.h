//
//  JXCategoryCustomView.h
//  JXCategoryView
//
//  Created by jiaxin on 2019/8/16.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import <JXCategoryView/JXCategoryTitleView.h>
#import "JXCategoryCustomCellModel.h"
#import "JXCategoryCustomCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXCategoryCustomView: JXCategoryTitleView {
}
@property (nonatomic, strong) UIColor *normalBackgroundColor;
@property (nonatomic, strong) UIColor *normalBorderColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *selectedBorderColor;
@property (nonatomic, assign) CGFloat borderLineWidth;
@property (nonatomic, assign) CGFloat backgroundCornerRadius;
@property (nonatomic, assign) CGFloat backgroundWidth;
@property (nonatomic, assign) CGFloat backgroundHeight;

@property (nonatomic, strong) NSArray <NSAttributedString *> *attributeTitles;
@property (nonatomic, strong) NSArray <NSAttributedString *> *selectedAttributeTitles;

@end

NS_ASSUME_NONNULL_END
