//
//  DJ3rdCategoryCell.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/29.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <DJBusinessTools/LXBaseCollectionViewCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJ3rdCategoryCell: LXBaseCollectionViewCell {
}
@property(nonatomic, assign)BOOL isUnfold;
@property(nonatomic, strong)UIColor *bgColor;

@property(nonatomic, strong)UIColor *textBGNormalColor;
@property(nonatomic, strong)UIColor *textBGSelectedColor;

@property(nonatomic, strong)UIColor *textNormalColor;
@property(nonatomic, strong)UIColor *textSelectedColor;

@property(nonatomic, strong)UIFont *textNormalFont;
@property(nonatomic, strong)UIFont *textSelectedFont;


- (void)dataFill:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
