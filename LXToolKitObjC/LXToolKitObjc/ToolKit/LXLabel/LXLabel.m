//
//  LXLabel.m
//  LXToolKitObjC
//
//  Created by lxthyme on 2022/7/1.
//
#import "LXLabel.h"

@interface LXLabel() {
}
/// 长按复制手势
@property(nonatomic, strong)UILongPressGestureRecognizer *longPressCopyGesture;

@end

@implementation LXLabel
#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.x_insets)];
}
- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += self.x_insets.left + self.x_insets.right;
    size.height += self.x_insets.top + self.x_insets.bottom;
    return size;
}
- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    self.preferredMaxLayoutWidth = bounds.size.width - (self.x_insets.left + self.x_insets.right);
}
- (BOOL)canBecomeFirstResponder {
    if(self.canCopy) {
        return YES;
    }
    return [super canBecomeFirstResponder];
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if(action == @selector(copyAction)) {
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)copyAction {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.text;
}
- (void)longPressAction:(UILongPressGestureRecognizer *)recognizer {
    [self becomeFirstResponder];
    UIMenuItem *copyItem = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyAction)];
    [[UIMenuController sharedMenuController] setMenuItems:@[copyItem]];
    [[UIMenuController sharedMenuController]setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController]setMenuVisible:YES animated:YES];
}

#pragma mark -
#pragma mark - 📌UI Prepare & Masonry
#pragma mark getter / setter
- (void)setX_insets:(UIEdgeInsets)x_insets {
    if(UIEdgeInsetsEqualToEdgeInsets(x_insets, _x_insets)) {
        return;
    }
    _x_insets = UIEdgeInsetsMake(ceilf(x_insets.top), ceilf(x_insets.left), ceilf(x_insets.bottom), ceilf(x_insets.right));
}
- (void)setCanCopy:(BOOL)canCopy {
    if(canCopy == _canCopy) {
        return;
    }
    _canCopy = canCopy;

    self.userInteractionEnabled = canCopy;
    if(canCopy) {
        [self addGestureRecognizer:self.longPressCopyGesture];
    } else {
        [self removeGestureRecognizer:self.longPressCopyGesture];
    }
}
- (UILongPressGestureRecognizer *)longPressCopyGesture {
    if(!_longPressCopyGesture){
        UILongPressGestureRecognizer *v = [[UILongPressGestureRecognizer alloc]init];
        v.minimumPressDuration = 0.75f;
        [v addTarget:self action:@selector(longPressAction:)];
        _longPressCopyGesture = v;
    }
    return _longPressCopyGesture;
}

@end
