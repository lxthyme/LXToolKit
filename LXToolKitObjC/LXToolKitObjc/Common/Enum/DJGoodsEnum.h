//
//  DJGoodsEnum.h
//  DJBusinessTools
//
//  Created by lxthyme on 2022/8/8.
//

#ifndef DJGoodsEnum_h
#define DJGoodsEnum_h

typedef NS_ENUM (NSInteger,DJGoodImageViewLabelType){
    DJGoodImageViewLabelTypeDefault = 0,
    DJGoodImageViewLabelTypeLimit,
    DJGoodImageViewLabelTypeSoldout,
    DJGoodImageViewLabelTypeTension,
    DJGoodImageViewLabelTypeOffShelf
};

/// 药品类型
///     1:
///     29: 非处方药
///     30: 处方药
typedef NS_ENUM(NSInteger, DJGoodsType) {
    /// 1:
    DJGoodsType1 = 1,
    /// 29: 非处方药
    DJGoodsNotChuFangType = 29,
    /// 30: 处方药
    DJGoodsChuFangType = 30,
};

/// 药品类型
///    1: 防疫药品
///    2: 非防疫药品
///    3: 保健食品
///    4: 医疗器械
///    5: 化妆品
typedef NS_ENUM(NSInteger, DJMedicineType) {
    /// 1: 防疫药品
    DJMedicineFangYiType = 1,
    /// 2: 非防疫药品
    DJMedicineNotFangYiType = 2,
    /// 3: 保健食品
    DJMedicineBaoJianType = 3,
    /// 4: 医疗器械
    DJMedicineYiLiaoType = 4,
    /// 5: 化妆品
    DJMedicineHuaZhuangPinType = 5
};

/// 商品详情页所有 cell 类型
typedef NS_ENUM(NSInteger, DJGoodsDetailCellType) {
    /// 轮播图
    DJGoodsDetailCellTypeBanner = 1001,
    DJGoodsDetailCellTypeTitle,
    /// 限时抢购
    DJGoodsDetailCellTypePromotionPrice,
    DJGoodsDetailCellTypePromotion,
    DJGoodsDetailCellTypePresell = 1005,
    DJGoodsDetailCellTypePlusMemberSign,
    /// 规格
    DJGoodsDetailCellTypeOtherInfo,
    /// 配送信息
    DJGoodsDetailCellTypeDelivery,
    /// 服务信息
    DJGoodsDetailCellTypeService,
    DJGoodsDetailCellTypeCoupon = 10010,
    /// 促销
    DJGoodsDetailCellTypePromotionSale,
    /// 门店
    DJGoodsDetailCellTypeShoppingStore,
    DJGoodsDetailCellTypeAutoCycle,
    DJGoodsDetailCellTypeRecommend,
    /// 评论 header
    DJGoodsDetailCellTypeCommentHeader = 10015,
    /// 评论列表
    DJGoodsDetailCellTypeCommentDetail,
    /// 评论 footer
    DJGoodsDetailCellTypeCommentFooter,
    /// 菜谱
    DJGoodsDetailCellTypeRecommendMenu,
    /// 图文详情
    DJGoodsDetailCellTypePictureDetail,
};

#endif /* DJGoodsEnum_h */
