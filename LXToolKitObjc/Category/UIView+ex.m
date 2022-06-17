//
//  UIView+ex.m
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/5/27.
//

#import "UIView+ex.h"

@implementation UIView (ex)

- (void)xl_hideKeyBoard {
    // 遍历所有子视图
    [self _traverseAllSubviewsToResignFirstResponder:self];
}

//遍历父视图的所有子视图，包括嵌套的子视图
-(void)_traverseAllSubviewsToResignFirstResponder:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if (subView.subviews.count) {
            [self _traverseAllSubviewsToResignFirstResponder:subView];
        }
        [subView resignFirstResponder];
    }
}

@end
