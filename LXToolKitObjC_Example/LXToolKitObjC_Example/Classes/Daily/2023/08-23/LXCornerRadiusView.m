//
//  LXCornerRadiusView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/24.
//
#import "LXCornerRadiusView.h"

#import <Masonry/Masonry.h>

@interface LXCornerRadiusView() {
}

@end

@implementation LXCornerRadiusView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    // UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(_bottomLeftRadius?UIRectCornerBottomLeft:0)|(_bottomRightRadius?UIRectCornerBottomRight:0)|(_topLeftRadius?UIRectCornerTopLeft:0)|(_topRightRadius?UIRectCornerTopRight:0) cornerRadii:CGSizeMake(_singleCornerRadius, 0.f)];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                            byRoundingCorners:self.corners
                                                  cornerRadii:self.cornerRadii];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, path.CGPath);
    CGContextClosePath(ctx);
    CGContextClip(ctx);
    CGContextAddRect(ctx, rect);
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
    CGContextFillPath(ctx);
    // CGContextRelease(ctx);
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor lightTextColor];
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = [UIColor cyanColor].CGColor;
    // self.layer.masksToBounds = YES;

    // [self addSubview:self.<#table#>];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
}

#pragma mark Lazy Property

@end
