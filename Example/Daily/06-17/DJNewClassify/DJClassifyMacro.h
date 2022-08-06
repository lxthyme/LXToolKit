//
//  DJClassifyMacro.h
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/7/5.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#ifndef DJClassifyMacro_h
#define DJClassifyMacro_h

#define kPingFangSCMedium(__size__) [UIFont fontWithName:@"PingFangSC-Medium" size:(__size__)]
#define kPingFangSCSemibold(__size__) [UIFont fontWithName:@"PingFangSC-Semibold" size:(__size__)]

typedef NS_ENUM(NSInteger, DJViewStatus) {
    DJViewStatusUnknown = 0,
    /// 正常模式
    DJViewStatusNormal,
    /// 骨架屏
    DJViewStatusLoading,
    /// 无数据
    DJViewStatusNoData,
    /// 离线模式
    DJViewStatusOffline
};

typedef NS_ENUM(NSInteger, DJClassifyCategoryType) {
    // DJClassifyGoodItemTypeUnknown,
    DJClassifyCategoryTypeSection,
    DJClassifyCategoryTypePinView = 1,
    /// 自动补上的二级目录
    DJClassifyCategoryTypeRepair2rd,
    // DJClassifyGoodItemTypeBanner,
    // DJClassifyGoodItemTypePinCategoryView,
    // DJClassifyGoodItemTypeEmpty
};
typedef NS_ENUM(NSInteger, DJClassifyGoodItemType) {
    // DJClassifyGoodItemTypeUnknown,
    DJClassifyGoodItemTypeB2C,
    DJClassifyGoodItemTypeO2O,
    // DJClassifyGoodItemTypeBanner,
    // DJClassifyGoodItemTypePinCategoryView,
    // DJClassifyGoodItemTypeEmpty
};

// MARK: - 🔥一级分类配置
typedef NS_ENUM(NSInteger, DJClassifyType) {
    DJClassifyTypeB2C = 1,
    DJClassifyTypeO2O = 2,
};

typedef NS_ENUM(NSInteger, DJRuleType) {
    DJRuleTypeUnknown,
    DJRuleType12 = 12,
};

// MARK: - 🔥二级分类配置

/// 分类页左侧列表宽度
#define kLeftTableWidth kWPercentage(84.f)

// MARK: - 🔥三级分类配置

typedef NS_ENUM(NSInteger, DJClassifyRightCellType) {
    DJClassifyRightVCCellTypeBanner = 1,
    DJClassifyRightVCCellTypeGoodsItem,
};
// typedef NS_ENUM(NSInteger, DJT3DataLoadedStatus) {
//     /// 尚未开始加载
//     DJT3DataLoadedStatusNotYet,
//     /// 加载 idsList...
//     DJT3DataLoadedStatusLoadingIdsList,
//     /// 加载 goodsList...
//     DJT3DataLoadedStatusLoadingGoodsList,
//     /// 尚未开始加载 goodsList
//     DJT3DataLoadedStatusGoodsListNotYet,
//     /// 已经加载 goodsList
//     DJT3DataLoadedStatusLoadedGoodsList,
// };

/// 三级分类页 banner 所在的 section
static const NSUInteger kBannerSectionIdx = 0;
/// 三级分类页 banner 的高度
#define kBannerSectionHeight kWPercentage(90.f)
/// 三级分类页悬浮内容所在的 section
static const NSUInteger kPinCategoryViewSectionIndex = 0;

/// 三级分类 view 高度
#define kPinCategoryViewHeight kWPercentage(44.f)
/// 三级分类 filterView 高度
#define kPinFilterViewHeight kWPercentage(34.f)
/// 三级分类悬浮 view 高度
// #define kPinViewHeight (kPinCategoryViewHeight + kPinFilterViewHeight)

#define kT3RightCellHeight kWPercentage(125.f)
/// 三级分类cell padding
#define kPadding kWPercentage(10.f)
/// 三级分类cell标题组件间隔
#define kTitleSpacing kWPercentage(5.f)
/// 三级分类cell logo 尺寸
#define kLogoWidth kWPercentage(100.f)
/// 三级分类cell tag 高度
#define kTagListHeight kWPercentage(15.f)
/// tag cell 内边距
#define kTagListHPadding kWPercentage(5.f)
/// tag cell 间隔
#define kTagListInterval kWPercentage(3.5f)

/// 添加购物车图标
#define kAddCartNumHeight kWPercentage(12.f)
#define kAddCartTopHeight kWPercentage(8.f)
#define kAddCartLogoHeight kWPercentage(21.f)
// #define kAddCartViewFullHeight (kAddCartTopHeight + kAddCartLogoHeight)

/// 价格区域高度
#define kPriceWrapperHeight kWPercentage(32.5f)

#endif /* DJClassifyMacro_h */



// TODO: 「lxthyme」💊
/// 1. errorSubject sendNext:**DJViewStatus**
/// 2. 没有三级目录 === 没有数据(现状: 没有三级目录, 但是有数据)
// END
