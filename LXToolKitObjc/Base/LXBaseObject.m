//
//  LXBaseObject.m
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/6/22.
//
#import "LXBaseObject.h"

@interface LXBaseObject() {
}

@end

@implementation LXBaseObject
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

@end
