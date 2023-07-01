//
//  LXTestView.m
//  tes
//
//  Created by lxthyme on 2023/6/2.
//
#import "LXTestView.h"

#import <Masonry/Masonry.h>

#define kScreenWidth UIScreen.mainScreen.bounds.size.width

@interface LXTestView() {
}
@property(nonatomic, strong)UIView *wrapperView;
@property(nonatomic, strong)UIView *topView;
@property(nonatomic, strong)UIView *middleView;
@property(nonatomic, strong)UIView *bottomView;
@property(nonatomic, strong)UIView *lineView;
@property(nonatomic, strong)UIImageView *imgViewCircleLeft;
@property(nonatomic, strong)UIImageView *imgViewCircleRight;

@end

@implementation LXTestView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
        [self testM];
    }
    return self;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)testM {
    // CAShapeLayer *lineLayer = [self addImaginaryLineWithFrame:CGRectMake(10, 100, kScreenWidth - 20, 10)
    //                                                 lineColor:[UIColor redColor]
    //                                                lineHeight:1
    //                                             lineDashWidth:@10
    //                                             lineDashSpace:@5];
    // lineLayer.frame = CGRectMake(10, 100, kScreenWidth - 20, 10);
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10.f, 8.f)];
    [path addLineToPoint:CGPointMake(kScreenWidth - 80.f - 10.f, 8.f)];
    [path closePath];
    lineLayer.path = path.CGPath;

    lineLayer.position = CGPointMake(0, 1);
    lineLayer.fillColor = nil;

    lineLayer.strokeColor = [UIColor redColor].CGColor;
    lineLayer.lineWidth = 1;
    lineLayer.lineJoin = kCALineJoinRound;
    lineLayer.lineDashPattern = @[@3, @5];
    [self.middleView.layer addSublayer:lineLayer];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7f];

    [self.wrapperView addSubview:self.topView];
    [self.wrapperView addSubview:self.middleView];
    [self.wrapperView addSubview:self.bottomView];
    [self.middleView addSubview:self.imgViewCircleLeft];
    [self.middleView addSubview:self.lineView];
    [self.middleView addSubview:self.imgViewCircleRight];
    [self addSubview:self.wrapperView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40.f);
        make.right.equalTo(@-40.f);
        make.centerY.equalTo(@0.f);
        make.height.equalTo(@300.f);
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@67.f);
    }];
    [self.imgViewCircleLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(@0.f);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0.f);
        make.left.equalTo(self.imgViewCircleLeft.mas_right);
        make.right.equalTo(self.imgViewCircleRight.mas_left);
    }];
    [self.imgViewCircleRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0.f);
        make.centerY.equalTo(self.imgViewCircleLeft);
    }];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.right.equalTo(@0.f);
        make.height.equalTo(@16.f);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UIView *)wrapperView {
    if(!_wrapperView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor clearColor];
        v.layer.cornerRadius = 13.f;
        v.layer.masksToBounds = YES;
        _wrapperView = v;
    }
    return _wrapperView;
}
- (UIView *)topView {
    if(!_topView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        _topView = v;
    }
    return _topView;
}
- (UIView *)middleView {
    if(!_middleView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor clearColor];
        _middleView = v;
    }
    return _middleView;
}
- (UIView *)bottomView {
    if(!_bottomView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        _bottomView = v;
    }
    return _bottomView;
}
- (UIView *)lineView {
    if(!_lineView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        _lineView = v;
    }
    return _lineView;
}
- (UIImageView *)imgViewCircleLeft {
    if(!_imgViewCircleLeft){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [UIImage imageNamed:@"icon_circle_left"];
        _imgViewCircleLeft = iv;
    }
    return _imgViewCircleLeft;
}
- (UIImageView *)imgViewCircleRight {
    if(!_imgViewCircleRight){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [UIImage imageNamed:@"icon_circle_right"];
        _imgViewCircleRight = iv;
    }
    return _imgViewCircleRight;
}

@end
