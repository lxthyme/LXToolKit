//
//  DJClassifyBaseCategoryModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <LXToolKitObjc/LXBaseModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJClassifyBaseCategoryModel: LXBaseModel {
}
/// 分类ID
@property (nonatomic, copy)NSString *categoryId;
/// 分类名称
@property (nonatomic, copy)NSString *categoryName;

@end

NS_ASSUME_NONNULL_END
