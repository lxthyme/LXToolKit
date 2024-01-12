//
//  LXDJGoodsPriceView.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/4/18.
//
#import <UIKit/UIKit.h>
#import <LXToolKitObjC/LXBaseView.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DJGoodsPriceStyle) {
    DJGoodsPriceStyleNormal,
    /// 划线价
    DJGoodsPriceStyleHuaXian,
    /// plus 价
    DJGoodsPriceStylePlus,
};

@interface LXDJGoodsPriceView: LXBaseView {
}

- (void)dataFill:(NSDictionary *)item style:(DJGoodsPriceStyle)style;

@end

NS_ASSUME_NONNULL_END
