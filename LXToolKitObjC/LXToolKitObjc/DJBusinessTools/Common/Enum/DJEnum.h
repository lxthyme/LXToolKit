//
//  DJEnum.h
//  DJBusinessTools
//
//  Created by lxthyme on 2021/12/17.
//

#ifndef DJEnum_h
#define DJEnum_h

/// 订单类型
typedef NS_ENUM(NSInteger, DJOrderType) {
    DJOrderTypeUnknown = -1,
    /// 全部订单
    DJOrderTypeAll = -2,
    /// 普通订单（联华）  2000业态
    DJOrderType1 = 1,
    /// 即时达订单
    DJOrderType25 = 25,
    /// 扫码购订单
    DJOrderType46 = 46,
    /// 处方药订单
    DJOrderType58 = 58,
    /// 普通订单（联华）  2000业态 + 到家托底门店
    DJOrderTypeA1 = 999,
};
/// 订单类型
typedef NS_ENUM(NSInteger, DJOrderSubTypeCode) {
    /// DJOrderType1 & DJOrderSubTypeCode4: 联华融合订单
    DJOrderSubTypeCode4 = 4,
};

/// 猜你喜欢 cell 入口来源
typedef enum : NSUInteger {
    /// 购物车入口
    DJGuessLikeFromTypeShopCart,
    /// 订单列表入口
    DJGuessLikeFromTypeOrderList,
} DJGuessLikeFromType;

typedef NS_ENUM(NSInteger, DJTabType) {
    DJTabType_O2O,
    DJTabType_B2C,
    DJTabType_ALL,
    DJTabType_CURRENT,
    DJTabType_TD,
};

#endif /* DJEnum_h */
