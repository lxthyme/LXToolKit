//
//  LXBaseObject.m
//  LXToolKitObjC
//
//  Created by lxthyme on 2022/6/22.
//
#import "LXBaseObject.h"
#import "DJLogger.h"

@interface LXBaseObject() {
}

@end

@implementation LXBaseObject
- (void)dealloc {
    commonlog(@"🛠DEALLOC[NSObject]: %@", NSStringFromClass([self class]));
}

@end
