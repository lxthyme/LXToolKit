//
//  DJShopCartEnum.h
//  DJBusinessTools
//
//  Created by lxthyme on 2022/8/27.
//

#ifndef DJShopCartEnum_h
#define DJShopCartEnum_h

/// 促销类型
typedef NS_ENUM(NSInteger, DJCartPopType) {
    DJCartPopType_Unknown = 0,
    /// 1: 满减
    DJCartPopType_1 = 1,
    /// 2: 折扣
    DJCartPopType_2 = 2,
    /// 3: 用券
    DJCartPopType_3 = 3,
    /// 4: 返券
    DJCartPopType_4 = 4,
    /// 5: 定制篮框
    DJCartPopType_5 = 5,
    /// 6: 团闪抢 ? 满赠
    DJCartPopType_6 = 6,
    /// 7: X元Y件
    DJCartPopType_7 = 7,
    /// 10: 用现金券
    DJCartPopType_10 = 10,
    /// 12: 专享
    DJCartPopType_12 = 12,
    /// 16: 换购商品
    DJCartPopType_16 = 16,
};

/// 分组类型
typedef NS_ENUM(NSInteger, DJCartGroupType) {
    DJCartGroupType_Unknown = 0,
    /// 20: 失效商品组
    DJCartGroupType_20 = 20,
    /// 21: 可以配送
    DJCartGroupType_21 = 21,
    /// 22: 可以自提
    DJCartGroupType_22 = 22,
};
/// 配送方式
typedef NS_ENUM(NSInteger, DJDistributeStatus) {
    /// 仅自提
    DJDistributeStatusSince,
    /// 仅配送
    DJDistributeStatusDistribute,
    /// 自提 & 配送
    DJDistributeStatusAll
};

/// 当前购物车门店是否在可配送范围内
typedef NS_ENUM(NSInteger, DJCheckLocationCachedType) {
    /// 尚未查询状态
    DJCheckLocationCachedTypeNoCache = 0,
    /// 不在配送范围内
    DJCheckLocationCachedTypeInvalid = 1,
    /// 在配送范围内
    DJCheckLocationCachedTypeValid = 2
};

#endif /* DJShopCartEnum_h */
