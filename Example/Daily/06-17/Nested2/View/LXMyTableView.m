//
//  LXMyTableView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXMyTableView.h"

#import <Masonry/Masonry.h>

@interface LXMyTableView() {
}

@end

@implementation LXMyTableView
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // return YES;
    BOOL should = [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
    if(!should) {
        should = [gestureRecognizer.view isKindOfClass:[LXMyTableView class]] &&
        [otherGestureRecognizer.view isKindOfClass:[JXPagerMainTableView class]];
    }
    if(should) {
        NSLog(@"should: YES");
        return YES;
    }
    NSLog(@"should: %@, \n[%@: %@]\n[%@: %@]",
          kBOOLString(should),
          NSStringFromClass([gestureRecognizer class]),
          NSStringFromClass([otherGestureRecognizer class]),
          NSStringFromClass([gestureRecognizer.view class]),
          NSStringFromClass([otherGestureRecognizer.view class]));
    return NO;
}
@end
