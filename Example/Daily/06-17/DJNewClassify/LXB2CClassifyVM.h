//
//  LXB2CClassifyVM.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LXLHCategoryModel.h"
#import "LXGoodsInfoListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXB2CClassifyVM: NSObject {
}
@property(nonatomic, strong)RACCommand *productSearchDoCategoryByLevOneCommand;
@property(nonatomic, strong)RACCommand *v2SearchForLHApiCommand;
@property(nonatomic, strong)RACSubject *productSearchDoCategoryByLevOneSubject;
@property(nonatomic, strong)RACSubject *v2SearchForLHApiSubject;

- (void)loadV2SearchForLHApi:(NSString *)categorySid;
- (void)loadProductSearchDoCategoryByLevOne;

@end

NS_ASSUME_NONNULL_END
