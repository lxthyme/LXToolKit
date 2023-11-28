//
//  DJCouponEnum.h
//  DJBusinessTools
//
//  Created by lxthyme on 2022/3/8.
//

#ifndef DJCouponEnum_h
#define DJCouponEnum_h

/// 券类型
typedef NS_ENUM(NSInteger, DJCouponType) {
    DJCoupon10Type = 10,
    /// 11:抵用券
    DJCoupon11Type = 11,
    /// 16: 商品抵换券
    DJCoupon16Type = 16,
    /// 17:运费券
    DJCoupon17Type = 17,
    /// 18:抽奖券
    DJCoupon18Type = 18,
    /// 20:折扣券
    DJCoupon20Type = 20
};

/// 券状态
typedef NS_ENUM(NSInteger, DJCouponStatus) {
    /// 0：正常 
    DJCouponNormalStatus = 0,
    /// 1：即将过期
    DJCouponWillInvalidStatus = 1,
    /// 2：已过期
    DJCouponInvalidNewStatus = 2,
    /// 3:新到
    DJCouponNewStatus = 3
};

#endif /* DJCouponEnum_h */
