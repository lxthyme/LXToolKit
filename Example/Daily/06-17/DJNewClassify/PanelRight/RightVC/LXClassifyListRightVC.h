//
//  LXClassifyListRightVC.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import <DJBusinessTools/LXBaseVC.h>

#import "DJClassifyMacro.h"
#import "LXClassifyRightVCModel.h"
#import "DJClassifyMacro.h"
#import "LXB2CClassifyVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXClassifyListRightVC : LXBaseVC {
}
@property(nonatomic, assign)DJClassifyType classifyType;
@property(nonatomic, strong)LXB2CClassifyVM *b2cVM;
@property(nonatomic, copy)void (^refreshBlock)(BOOL isRefresh);

- (void)dataFill:(LXClassifyRightModel *)rightModel;

- (void)dismissAllCategoryView;

@end

NS_ASSUME_NONNULL_END
