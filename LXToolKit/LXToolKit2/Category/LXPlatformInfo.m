//
//  LXPlatformInfo.m
//  Vaffle_demo
//
//  Created by DamonJow on 2018/11/1.
//  Copyright © 2018 DamonJow. All rights reserved.
//

#import "LXPlatformInfo.h"

#include <sys/types.h>
#include <sys/sysctl.h>

@interface LXPlatformInfo () {
}
/** platformInfo */
@property(nonatomic, retain)NSDictionary *platform;
@end
@implementation LXPlatformInfo

+ (instancetype)sharedInstance {
    static LXPlatformInfo *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[LXPlatformInfo alloc]init];
    });
    return _sharedInstance;
}

/// 获得设备型号
+ (NSString *)getCurrentDeviceModel {
    return [[LXPlatformInfo sharedInstance] getCurrentDeviceModel];
}
/// 获得设备型号
- (NSString *)getCurrentDeviceModel {
    int mib[2];
    size_t len;
    char *machine;

    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);

    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);

    return self.platform[platform];
}

#pragma mark - platform
- (NSDictionary *)platform {
    if(!_platform){
        _platform = @{
                                    @"i386" : @"iPhone Simulator",
                                    @"x86_64" : @"iPhone Simulator",

                                    /// iPhone
                                    @"iPhone1,1" : @"iPhone 2G (A1203)",
                                    @"iPhone1,2" : @"iPhone 3G (A1241/A1324)",
                                    @"iPhone2,1" : @"iPhone 3GS (A1303/A1325)",
                                    @"iPhone3,1" : @"iPhone 4 (A1332)",
                                    @"iPhone3,2" : @"iPhone 4 (A1332)",
                                    @"iPhone3,3" : @"iPhone 4 (A1349)",
                                    @"iPhone4,1" : @"iPhone 4S (A1387/A1431)",
                                    @"iPhone5,1" : @"iPhone 5 (A1428)",
                                    @"iPhone5,2" : @"iPhone 5 (A1429/A1442)",
                                    @"iPhone5,3" : @"iPhone 5c (A1456/A1532)",
                                    @"iPhone5,4" : @"iPhone 5c (A1507/A1516/A1526/A1529)",
                                    @"iPhone6,1" : @"iPhone 5s (A1453/A1533)",
                                    @"iPhone6,2" : @"iPhone 5s (A1457/A1518/A1528/A1530)",
                                    @"iPhone7,1" : @"iPhone 6 Plus (A1522/A1524)",
                                    @"iPhone7,2" : @"iPhone 6 (A1549/A1586)",
                                    @"iPhone8,1" : @"iPhone 6S",
                                    @"iPhone8,2" : @"iPhone 6S Plus",
                                    @"iPhone8,3" : @"iPhone SE",
                                    @"iPhone8,4" : @"iPhone SE",
                                    @"iPhone9,1" : @"iPhone 7",
                                    @"iPhone9,2" : @"iPhone 7 Plus",
                                    @"iPhone10.1" : @"iPhone 8",
                                    @"iPhone10,4" : @"iPhone 8",
                                    @"iPhone10.2" : @"iPhone 8 Plus",
                                    @"iPhone10,5" : @"iPhone 8 Plus",
                                    @"iPhone10,3" : @"iPhone X",
                                    @"iPhone10,6" : @"iPhone X",

                                    /// iPod
                                    @"iPod1,1" : @"iPod Touch 1G",
                                    @"iPod2,1" : @"iPod Touch 2G",
                                    @"iPod3,1" : @"iPod Touch 3G",
                                    @"iPod4,1" : @"iPod Touch 4G",
                                    @"iPod5,1" : @"iPod Touch 5G",
                                    @"iPod7,1" : @"iPod Touch 6G",

                                    /// iPad
                                    @"iPad1,1" : @"iPad",
                                    @"iPad2,1" : @"iPad 2 (WiFi)",
                                    @"iPad2,2" : @"iPad 2 (GSM)",
                                    @"iPad2,3" : @"iPad 2 (CDMA)",
                                    @"iPad2,4" : @"iPad 2 (32nm)",
                                    @"iPad3,1" : @"iPad 3 (WiFi)",
                                    @"iPad3,2" : @"iPad 3(CDMA)",
                                    @"iPad3,3" : @"iPad 3(4G)",
                                    @"iPad3,4" : @"iPad 4 (WiFi)",
                                    @"iPad3,5" : @"iPad 4 (4G)",
                                    @"iPad3,6" : @"iPad 4 (CDMA)",

                                    /// iPad Air
                                    @"iPad4,1" : @"iPad Air",
                                    @"iPad4,2" : @"iPad Air",
                                    @"iPad4,3" : @"iPad Air",
                                    @"iPad5,3" : @"iPad Air 2",
                                    @"iPad5,4" : @"iPad Air 2",

                                    /// iPad mini
                                    @"iPad2,5" : @"iPad Mini (WiFi)",
                                    @"iPad2,6" : @"iPad Mini (GSM)",
                                    @"iPad2,7" : @"iPad Mini (CDMA)",
                                    @"iPad4,4" : @"iPad mini 2",
                                    @"iPad4,5" : @"iPad mini 2",
                                    @"iPad4,6" : @"iPad mini 2",
                                    @"iPad4,7" : @"iPad mini 3",
                                    @"iPad4,8" : @"iPad mini 3",
                                    @"iPad4,9" : @"iPad mini 3",
                                    @"iPad5,1" : @"iPad mini 4",
                                    @"iPad5,2" : @"iPad mini 5",
                                    };
    }
    return _platform;
}
@end
