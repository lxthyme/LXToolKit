//
//  DJPriceWrapperStackView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/8.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJPriceWrapperStackView: UIStackView {
}
@property(nonatomic, strong)UILabel *labTitle;

- (void)dataFill:(NSString *)logo price:(NSString *)price;

@end

NS_ASSUME_NONNULL_END
