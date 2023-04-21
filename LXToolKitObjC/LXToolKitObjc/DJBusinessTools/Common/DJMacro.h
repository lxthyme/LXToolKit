//
//  DJMacro.h
//  DJBusinessTools
//
//  Created by lxthyme on 2021/12/6.
//

#ifndef DJDJBusinessTools_DJMacro_h
#define DJDJBusinessTools_DJMacro_h

#ifndef WEAKSELF
#define WEAKSELF(self)  __weak __typeof(&*self)weakSelf = self;
#endif

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#endif

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)
#endif

#ifndef kHPercentage
#define kHPercentage(a) (SCREEN_HEIGHT * ((a) / 667.00))
#endif

#ifndef kWPercentage
#define kWPercentage(a) (SCREEN_WIDTH *((a) / 375.00))
#endif

#define kBOOLString(__bool__) ((__bool__) ? @"YES" : @"NO")

/// 像素对齐
#define kFixed0_5 ([UIScreen mainScreen].scale >= 3 ? 0.75f : 0.5f)

#define section1Height kWPercentage(35.f) + BL_STATUSBAR_HEIGHT
/// 头部气泡超出边界 -5px
#define section2Height (86.f - 5.f)
#define diffConstant 1

/// 固定读取资源位20220314：获取jiege类型下的底图图片（非必填，无数据按无底图样式展示）
#define kPictureCMSLabBGResourceID @"20220314"

/// 商品加车时最大数量限制
/// [06.07]去掉最大加车数量限制
#define kGoodsAddMaxNumber NSIntegerMax

/// 商品组件加车数量 UI 高度
#define kAddCartNumHeight kWPercentage(12.f)

/// 是否进在到家首页环境
// DJUserDefaultsHadGoDJNewHomeViewController

/// 是否是手动选择地址flag
// isFromManualChooseAdress

/// "查看附近门店" 缓存的数据
// kUserLocationCachedKey

#endif /* DJDJBusinessTools_DJMacro_h */
