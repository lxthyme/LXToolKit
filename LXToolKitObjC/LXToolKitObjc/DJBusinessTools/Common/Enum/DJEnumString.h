//
//  DJEnumString.h
//  DJBusinessTools
//
//  Created by lxthyme on 2022/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString *DJModulePictureType NS_TYPED_ENUM;
/// 老版本样式
extern DJModulePictureType const DJModulePictureDefaultType;
/// A: 价格
extern DJModulePictureType const DJModulePictureAType;
/// B: 促销语
extern DJModulePictureType const DJModulePictureBType;

typedef NSString *DJBigDataFrom NS_TYPED_ENUM;
/// h: 首页
extern DJBigDataFrom const DJBigDataFromNewHome;
/// s: 购物车页
extern DJBigDataFrom const DJBigDataFromShopCart;
/// odetail: 订单列表
extern DJBigDataFrom const DJBigDataFromOrderList;

@interface DJEnumString : NSObject {
}

@end

NS_ASSUME_NONNULL_END
