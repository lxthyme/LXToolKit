//
//  DJNewAddCartView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/5.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DJO2OGoodItemModel.h"
#import "DJB2CGoodsItemListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DJNewAddCartView: UIControl {
}
@property(nonatomic, strong)UIButton *btnAdd;

- (void)dataFillWithO2O:(DJO2OGoodItemModel *)item num:(NSInteger)num;
- (void)dataFillWithB2C:(DJB2CGoodItemModel *)item num:(NSInteger)num;
@end

NS_ASSUME_NONNULL_END
