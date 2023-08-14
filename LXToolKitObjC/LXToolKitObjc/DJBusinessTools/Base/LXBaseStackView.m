//
//  LXBaseStackView.m
//  DJBusinessTools
//
//  Created by lxthyme on 2022/11/23.
//
#import "LXBaseStackView.h"

@interface LXBaseStackView() {
}

@end

@implementation LXBaseStackView

#pragma mark -
#pragma mark - 🛠Life Cycle
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    /// Passing all touches to the next view (if any), in the view stack.
    NSMutableArray *allSubViews = [NSMutableArray array];
    [allSubViews addObjectsFromArray:self.arrangedSubviews];
    [allSubViews addObjectsFromArray:self.subviews];
    for(UIView *subview in allSubViews) {
        CGPoint subPoint = [self convertPoint:point toView:subview];
        UIView *testView = [subview hitTest:subPoint withEvent:event];
        if(testView) {
            // NSLog(@"-->hitTest[√]: %@", testView);
            return YES;
        }
    }
    BOOL a = [super pointInside:point withEvent:event];
    NSLog(@"-->hitTest[x]: %d", a);
    return NO;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

@end
