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

typedef NS_ENUM(NSInteger, LXViewStatus) {
    LXViewStatusUnknown = 0,
    /// 正常模式
    LXViewStatusNormal,
    /// 骨架屏
    LXViewStatusLoading,
    /// 无数据
    LXViewStatusNoData,
    /// 离线模式
    LXViewStatusOffline
};

typedef NS_ENUM(NSInteger, LXClassifyGoodItemType) {
    // LXClassifyGoodItemTypeUnknown,
    LXClassifyGoodItemTypeB2C,
    LXClassifyGoodItemTypeO2O,
    // LXClassifyGoodItemTypeBanner,
    LXClassifyGoodItemTypePinCategoryView,
    LXClassifyGoodItemTypeEmpty
};

// MARK: - 🔥一级分类配置
typedef NS_ENUM(NSInteger, DJClassifyType) {
    DJClassifyTypeB2C = 1,
    DJClassifyTypeO2O = 2,
};

// MARK: - 🔥二级分类配置

/// 分类页左侧列表宽度
#define kLeftTableWidth kWPercentage(84.f)

// MARK: - 🔥三级分类配置

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
/// 1. errorSubject sendNext:**LXViewStatus**
/// 2. 没有三级目录 === 没有数据(现状: 没有三级目录, 但是有数据)
// END
