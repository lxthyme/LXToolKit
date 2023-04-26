//
//  LXPlatformInfo.h
//  Vaffle_demo
//
//  Created by DamonJow on 2018/11/1.
//  Copyright © 2018 DamonJow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXPlatformInfo : NSObject {

}

/// 获得设备型号
+ (NSString *)getCurrentDeviceModel;

@end

NS_ASSUME_NONNULL_END
