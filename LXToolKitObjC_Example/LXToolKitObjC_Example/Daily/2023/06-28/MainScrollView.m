//
//  MainScrollView.m
//  tes
//
//  Created by lxthyme on 2023/6/19.
//
#import "MainScrollView.h"

@interface MainScrollView() {
}

@end

@implementation MainScrollView
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
