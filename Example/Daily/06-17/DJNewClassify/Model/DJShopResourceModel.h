//
//  DJShopResourceModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/23.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseModel.h>

NS_ASSUME_NONNULL_BEGIN

@class DJOnlineDeployList;
@interface DJShopResourceModel: LXBaseModel {
}
@property (nonatomic, assign)NSString *resourceId;
@property (nonatomic, copy)NSArray<DJOnlineDeployList *> *onlineDeployList;

@end

@interface DJOnlineDeployList : LXBaseModel {
}
@property (nonatomic, assign)NSString *resourceId;
@property (nonatomic, copy)NSString *planName;
@property (nonatomic, copy)NSString *picUrl;
@property (nonatomic, copy)NSString *updaterId;
@property (nonatomic, copy)NSString *picDesc2;
@property (nonatomic, copy)NSString *picDesc1;
@property (nonatomic, copy)NSString *showType;
@property (nonatomic, assign)NSInteger editType;
@property (nonatomic, assign)NSInteger planId;
@property (nonatomic, copy)NSString *createrId;
@property (nonatomic, copy)NSString *deployName;
@property (nonatomic, copy)NSString *mediaUrl;
@property (nonatomic, assign)NSInteger priority;
@property (nonatomic, assign)NSInteger auditTime;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *jumpType;
@property (nonatomic, copy)NSString *jumpUrl;
@property (nonatomic, assign)NSInteger contentId;
@property (nonatomic, copy)NSString *displayContent;
@property (nonatomic, assign)NSInteger startTime;
@property (nonatomic, copy)NSString *picType;
@property (nonatomic, copy)NSString *auditor;
@property (nonatomic, copy)NSString *showDay;
@property (nonatomic, assign)NSInteger updateTime;
@property (nonatomic, copy)NSString *jumpId;
@property (nonatomic, assign)NSInteger deployId;
@property (nonatomic, copy)NSString *keyWord;
@property (nonatomic, assign)NSInteger createTime;
@property (nonatomic, assign)NSInteger endTime;
@property (nonatomic, copy)NSString *resStategy;

@end

NS_ASSUME_NONNULL_END
