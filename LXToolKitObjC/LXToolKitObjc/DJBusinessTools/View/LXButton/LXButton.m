//
//  LXButton.m
//  DJBusinessTools
//
//  Created by lxthyme on 2022/2/23.
//

#import "LXButton.h"

@interface LXButton() {
}

@end

@implementation LXButton
#pragma mark -
#pragma mark - 🛠Life Cycle
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return [super hitTest:point withEvent:event];
    }
    CGRect expandRect = CGRectInset(self.bounds, -self.f_expandInset, -self.f_expandInset);
    if(CGRectContainsPoint(expandRect, point)) {
        return self;
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

@end
