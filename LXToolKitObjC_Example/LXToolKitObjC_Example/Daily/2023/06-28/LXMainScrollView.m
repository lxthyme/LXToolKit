//
//  LXMainScrollView.m
//  tes
//
//  Created by lxthyme on 2023/6/19.
//
#import "LXMainScrollView.h"

@interface LXMainScrollView() {
}

@end

@implementation LXMainScrollView
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
