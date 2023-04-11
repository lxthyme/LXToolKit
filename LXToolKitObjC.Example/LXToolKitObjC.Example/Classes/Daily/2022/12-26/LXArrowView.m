//
//  LXArrowView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2023/1/6.
//  Copyright © 2023 lxthyme. All rights reserved.
//
#import "LXArrowView.h"

#import <Masonry/Masonry.h>

@interface LXArrowView() {
}

@end

@implementation LXArrowView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    CGSize size = self.frame.size;
    CGPoint _startPoint = CGPointMake(0, size.height);
    CGPoint _middlePoint = CGPointMake(size.width / 2.f, 0);
    CGPoint _endPoint = CGPointMake(size.width, size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context, _startPoint.x, _startPoint.y);
    CGContextAddLineToPoint(context,_middlePoint.x, _middlePoint.y);
    CGContextAddLineToPoint(context,_endPoint.x, _endPoint.y);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    CGContextSetLineWidth(context, 0);
    // [_color setFill]; //设置填充色
    // [_color setStroke];//边框也设置为_color，否则为默认的黑色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
}
#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    // [self addSubview:self.<#table#>];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
}

#pragma mark Lazy Property

@end
