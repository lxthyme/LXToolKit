//
//  DJShopCartMacro.h
//  DJBusinessTools
//
//  Created by lxthyme on 2022/8/31.
//

#ifndef DJShopCartMacro_h
#define DJShopCartMacro_h

#define WeakSelf __weak typeof(self) weakSelf = self;

/// 通知栏 资源位ID：20190917 （APP-到店维度）
static NSString * const kShopCart_Notify_ResourceID = @"20190917";
/// 限重提示语资源位
static NSString * const kShopCart_WeightLimit_ResourceID = @"20200820";
/// 购物车猜你喜欢 pageSize
#define kShopCartGuessLikePageSize 30

#define kSCTopAreaViewHeight kWPercentage(95.f + 15.f + 10.f)
#define kSCGiftViewHeight kWPercentage(25.f)
#define kSCActivityViewHeight kWPercentage(25.f)

/// 购物车是否开启展示 ECP 标识
// #define kShowCartECPFlag 1

#endif /* DJShopCartMacro_h */
