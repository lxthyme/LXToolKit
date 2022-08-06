//
//  DJNewAddCartView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/5.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DJO2OGoodItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJNewAddCartView: UIControl {
}

- (void)dataFill:(DJO2OGoodItemModel *)item num:(NSInteger)num;

@end

NS_ASSUME_NONNULL_END
