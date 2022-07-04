//
//  LXLabel.m
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/7/1.
//
#import "LXLabel.h"

@interface LXLabel() {
}

@end

@implementation LXLabel
#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.x_insets)];
}
- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    return CGSizeMake(size.width + self.x_insets.left + self.x_insets.right,
                      size.height + self.x_insets.top + self.x_insets.bottom);
}
- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    self.preferredMaxLayoutWidth = bounds.size.width - (self.x_insets.left + self.x_insets.right);
}

@end
