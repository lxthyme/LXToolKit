//
//  DJClassifyHeaderView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/8/6.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseView.h>
#import "DJClassifyMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJClassifyHeaderView: UIStackView {
}
@property(nonatomic, assign)DJNewClassifyHeaderType headerType;
@property(nonatomic, strong)UIButton *btnSearch;

- (void)dataFill:(NSString *)o2oTitle b2cTitle:(NSString *)b2cTitle;

@end

NS_ASSUME_NONNULL_END
