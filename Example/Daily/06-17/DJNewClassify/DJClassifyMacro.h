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
typedef NS_ENUM(NSInteger, DJNewClassifyHeaderType) {
    DJNewClassifyHeaderTypeO2O = 1,
    DJNewClassifyHeaderTypeB2C = 2,
};
// typedef NS_ENUM(NSInteger, DJClassifyType) {
//     DJClassifyTypeB2C = 1,
//     DJClassifyTypeO2O = 2,
// };

typedef NS_ENUM(NSInteger, DJRuleType) {
    DJRuleTypeUnknown,
    DJRuleType12 = 12,
};

// MARK: - 🔥二级分类配置

/// 分类页左侧列表宽度
#define kLeftTableWidth kWPercentage(84.f)
#define kLabelAllWidth kWPercentage(35.f)
#define kB2CCategoryViewHeight kWPercentage(48.5f)

// MARK: - 🔥三级分类配置

typedef NS_ENUM(NSInteger, DJClassifyRightCellType) {
    DJClassifyRightVCCellTypeBanner = 1,
    DJClassifyRightVCCellTypeGoodsItem,
};
typedef NS_ENUM(NSInteger, DJT3DataLoadedStatus) {
    /// 尚未开始加载
    DJT3DataLoadedStatusNotYet = 0,
    /// 加载 idsList...
    // DJT3DataLoadedStatusLoadingIdsList,
    /// 加载 goodsList...
    // DJT3DataLoadedStatusLoadingGoodsList,
    /// 尚未开始加载 goodsList
    // DJT3DataLoadedStatusGoodsListNotYet,
    /// 已经加载 goodsList
    // DJT3DataLoadedStatusLoadedGoodsList,
    /// 加载中
    DJT3DataLoadedStatusLoading,
    /// 加载完毕
    DJT3DataLoadedStatusLoaded
};

/// filter 类型
typedef NS_ENUM(NSInteger, DJSubcategoryFilterType) {
    DJSubcategoryFilterTypeNone = 0,
    /// 即时达
    // DJSubcategoryFilterTypeJiShiDa = 1,
    /// 价格(递增)
    DJSubcategoryFilterTypePriceAsc = 2,
    /// 价格(递减)
    DJSubcategoryFilterTypePriceDesc = 3,
    /// 销量
    DJSubcategoryFilterTypeSale = 4
};

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

#define kT3FoldMinimumLineSpacing kWPercentage(5.f)
#define kT3FoldMinimumInteritemSpacing kWPercentage(5.f)
#define kT3FoldSectionInset UIEdgeInsetsMake(kWPercentage(10.f), 0.f, kWPercentage(10.f), 0.f)

#define kT3UnfoldMinimumLineSpacing kWPercentage(7.5f)
#define kT3UnfoldMinimumInteritemSpacing kWPercentage(7.5f)
#define kT3UnfoldSectionInset UIEdgeInsetsMake(0, kWPercentage(10.f), kWPercentage(15.f), kWPercentage(10.f))

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
