//
//  LXNumberFormatterVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/6/28.
//
#import "LXNumberFormatterVC.h"

#import <Masonry/Masonry.h>
#import "LXTestView.h"
// #import "LXUpdateLayoutVC.h"
// #import "LXPopTestVC.h"
// #import "LXScrollVC.h"

#define kScreenWidth UIScreen.mainScreen.bounds.size.width

@interface LXNumberFormatterVC () {
}
@property(nonatomic, strong)UIView *wrapperView;
@property(nonatomic, strong)LXTestView *testView;

@end

@implementation LXNumberFormatterVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];

    // LXUpdateLayoutVC *vc = [[LXUpdateLayoutVC alloc]init];
    // LXPopTestVC *vc = [[LXPopTestVC alloc]init];
    // LXScrollVC *vc = [[LXScrollVC alloc]init];
    // // self.navigationController.navigationBarHidden = YES;
    // self.navigationController.hidesBarsOnSwipe = YES;
    // self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    // [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];

    [self prepareUI];
    // [self prepareLayer];

    [self testM];
}

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)testM {
    NSNumberFormatter *nf = [[NSNumberFormatter alloc]init];
    nf.maximumFractionDigits = 12;
    nf.minimumFractionDigits = 12;
    nf.decimalSeparator = @".";
    // nf.usesGroupingSeparator = YES;
    // nf.groupingSeparator = @"_";
    // CGFloat number = 7.5f;
    NSString *string = [nf stringFromNumber:@123456789.123456789f];
    NSLog(@"-->string: %@", string);
}
- (void)prepareLayer {
    CALayer *layer = [CALayer layer];
    CAShapeLayer *lineLayer = [self addImaginaryLineWithFrame:CGRectMake(10, 100, kScreenWidth - 20, 10)
                                                    lineColor:[UIColor redColor]
                                                   lineHeight:1
                                                lineDashWidth:@10
                                                lineDashSpace:@5];
    lineLayer.frame = CGRectMake(10, 100, kScreenWidth - 20, 10);
    CAShapeLayer *leftCircleLayer = [CAShapeLayer layer];
    UIBezierPath *pathLeftCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 100) radius:10 startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    leftCircleLayer.path = pathLeftCircle.CGPath;
    leftCircleLayer.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f].CGColor;
    leftCircleLayer.strokeColor = [UIColor blackColor].CGColor;
    leftCircleLayer.backgroundColor = [UIColor greenColor].CGColor;
    CAShapeLayer *rightCircleLayer = [CAShapeLayer layer];
    UIBezierPath *pathRightCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kScreenWidth - 100, 100) radius:10 startAngle:M_PI_2 endAngle:-M_PI_2 clockwise:YES];
    rightCircleLayer.path = pathRightCircle.CGPath;
    rightCircleLayer.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f].CGColor;
    rightCircleLayer.strokeColor = [UIColor blackColor].CGColor;
    [layer addSublayer:lineLayer];
    [layer addSublayer:leftCircleLayer];
    [layer addSublayer:rightCircleLayer];
    layer.opaque = YES;
    layer.allowsGroupOpacity = YES;
    layer.frame = self.view.bounds;
    // layer.backgroundColor = [UIColor redColor].CGColor;
    [self.wrapperView.layer addSublayer:layer];
    // self.wrapperView.layer.mask = circleLayer;
    // layer.frame = self.view.bounds;
    // self.wrapperView.layer.mask = layer;
}

- (CAShapeLayer *)addImaginaryLineWithFrame:(CGRect)frame lineColor:(UIColor *)color lineHeight:(float)height lineDashWidth:(NSNumber *)width lineDashSpace:(NSNumber *)space {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];

    shapeLayer.position = CGPointMake(0, 1);
    shapeLayer.fillColor = nil;

    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.lineWidth = height;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineDashPattern = @[width, space];

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 10, 0);
    CGPathAddLineToPoint(path, NULL, kScreenWidth - 20,0);
    shapeLayer.path = path;
    CGPathRelease(path);

    // UIView *view = [[UIView alloc] initWithFrame:frame];
    // [view.layer addSublayer:shapeLayer];
    // return view;
    return shapeLayer;
}

#pragma mark -
#pragma mark - 📌UI Prepare & Masonry
- (void)prepareUI {
    // self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7f];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.wrapperView];
    [self.view addSubview:self.testView];
    [self masonry];
}
#pragma mark getter / setter
#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50.f);
        make.right.equalTo(@-50.f);
        make.height.equalTo(@200.f);
        make.center.equalTo(@0.f);
    }];
    [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UIView *)wrapperView {
    if(!_wrapperView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        v.layer.cornerRadius = 10.f;
        _wrapperView = v;
    }
    return _wrapperView;
}
- (LXTestView *)testView {
    if(!_testView){
        LXTestView *v = [[LXTestView alloc]init];
        _testView = v;
    }
    return _testView;
}
@end
