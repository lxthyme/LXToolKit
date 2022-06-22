//
//  LXBaseCollectionReusableView.m
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/6/22.
//
#import "LXBaseCollectionReusableView.h"

@interface LXBaseCollectionReusableView() {
}

@end

@implementation LXBaseCollectionReusableView
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

@end
