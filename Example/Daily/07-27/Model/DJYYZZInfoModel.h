//
//  DJYYZZInfoModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJYYZZInfoModel: LXBaseModel {
}
@property (nonatomic, copy)NSString *updatedBy;
@property (nonatomic, strong)NSString *createdDate;
@property (nonatomic, copy)NSString *createdBy;
@property (nonatomic, copy)NSString *imageUrl;
@property (nonatomic, copy)NSString *t_id;
@property (nonatomic, assign)NSInteger updatedDate;
@property (nonatomic, copy)NSString *storeId;
@property (nonatomic, assign)NSInteger delFlag;
@property (nonatomic, assign)NSInteger certificateType;
@property (nonatomic, copy)NSString *certificateTypeName;
@property (nonatomic, copy)NSString *extInfo;

/// 营业资质图片为奇数时, 填充一个用作占位(样式问题)
@property (nonatomic, assign)BOOL f_isPlaceholder;
@property (nonatomic, assign)CGFloat f_cellHeight;

@end

NS_ASSUME_NONNULL_END
