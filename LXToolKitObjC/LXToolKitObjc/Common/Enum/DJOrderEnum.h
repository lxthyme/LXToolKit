//
//  DJOrderEnum.h
//  DJBusinessTools
//
//  Created by lxthyme on 2022/3/25.
//

#ifndef DJOrderEnum_h
#define DJOrderEnum_h

/// 订单配送状态
typedef NS_ENUM(NSInteger, DJOrderFullStatus) {
    /// 全部子单都可配送
    DJOrderFullNoneStatus = 1,
    /// 部分子单可配送
    DJOrderFullSomeStatus = 2,
    /// 全部子单都不可配送
    DJOrderFullAllStatus = 3
};

typedef NS_ENUM(NSInteger, DJOrderStatus) {
    /**<  即时达配送订单   **/
    DJDeliverOrderWaitPay = 0, //待付款
    DJDeliverOrderWaitCheck = 1,   // 待审核
    DJDeliverOrderWaitDelivery = 2, // 待发货
    DJDeliverOrderWaitWarehouse = 3, // 待出库
    DJDeliverOrderIsDistribution = 4, // 配送中
    DJDeliverOrderFinishDelivery = 5, // 已配送
    DJDeliverOrderFinishedOrder = 6, // 已完成
    DJDeliverOrderIsCancle = 7, // 取消中
    DJDeliverOrderFinishedCancle = 8, // 已取消
    DJDeliverOrderFailedCancle = 9, // 取消失败
    DJDeliverOrderiIsFinishedPay = 10, // 已支付
    DJDeliverOrderRejectOrder = 11, // 订单拒收
    /**<  即时达自提订单   **/
    DJBySelfOrderWaitPay, //待付款
    DJBySelfOrderWaitCheck,   // 待审核
    DJBySelfOrderWaitDelivery, // 待发货
    DJBySelfOrderWaitWarehouse, // 待出库
    DJBySelfOrderIsDistribution, // 配送中
    DJBySelfOrderFinishDelivery, // 已配送
    DJBySelfOrderWaitTakeBySelf, // 待自提
    DJBySelfOrderFinishedOrder, // 已完成
    DJBySelfOrderOverTime, // 超时未取
    DJBySelfOrderIsCancle, // 取消中
    DJBySelfOrderFinishedCancle, // 已取消
    DJBySelfOrderFailedCancle, // 取消失败
    DJBySelfOrderiIsFinishedPay, // 已支付
    /**<  扫码购订单   **/
    DJScanOrderWaitPay, //待付款
    DJScanOrderWaitCheck,   // 待校验
    DJScanOrderFinishedOrder, // 已完成
    DJScanOrderFinishedCancle, // 已取消
    /**<  扫码购配送订单   **/
    DJScanDeliveryOrderWaitPay, //待付款
    DJScanDeliveryOrderWaitCheck,   // 待校验
    DJScanDeliveryOrderWaitDelivery, // 待发货
    DJScanDeliveryOrderIsDistribution, // 配送中
    DJScanDeliveryOrderFinishedOrder, // 已完成
    DJScanDeliveryOrderFinishedCancle, // 已取消
    /**<  普通订单   **/
    DJCommonOrderWaitPay, //待付款
    DJCommonOrderWaitCheck,   // 待审核
    DJCommonOrderWaitDelivery, // 待发货
    DJCommonOrderWaitWarehouse, // 待出库
    DJCommonOrderIsDistribution, // 配送中
    DJCommonOrderFinishDelivery, // 已配送
    DJCommonOrderFinishedOrder, // 已完成
    DJCommonOrderIsCancle, // 取消中
    DJCommonOrderFinishedCancle, // 已取消
    DJCommonOrderFailedCancle, // 取消失败
    DJCommonOrderiIsFinishedPay, // 已支付
    DJCommonOrderRejectOrder, // 订单拒收
    
    DJOrderIsFinishNotComment,  // 已完成未初评
    
    DJOrderDrugWaitCheck,   //处方单待审核
};

#endif /* DJOrderEnum_h */
