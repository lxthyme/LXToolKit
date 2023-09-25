//
//  LXPopTestVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/6/28.
//
#import "LXPopTestVC.h"

#import <Masonry/Masonry.h>
#import <pop/POP.h>

#define SCREEN_WIDTH UIScreen.mainScreen.bounds.size.width
#define SCREEN_Height UIScreen.mainScreen.bounds.size.height

@interface LXPopTestVC() {
}
@property(nonatomic, strong)UIView *topView;
@property(nonatomic, strong)UIView *bottomView;
@property(nonatomic, strong)UILabel *labLine1;
@property(nonatomic, strong)UILabel *labLine2;
@property(nonatomic, strong)UISegmentedControl *segment;
@property(nonatomic, strong)UIButton *btnGo;

@end

@implementation LXPopTestVC
- (void)dealloc {
    NSLog(@"🎷DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // NSLog(@"🛠viewWillAppear: %@", NSStringFromClass([self class]));
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    // NSLog(@"🛠viewDidAppear: %@", NSStringFromClass([self class]));
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    // NSLog(@"🛠viewWillDisappear: %@", NSStringFromClass([self class]));
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    // NSLog(@"🛠viewDidDisappear: %@", NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    [self prepareUI];
    // [self addAnimation];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions
- (void)addAnimation {
    POPSpringAnimation *anim;
    anim = [self animWithkPOPLayerBounds];
    // anim = [self animWithkPOPLayerPositionY];
    // anim = [self animWithkPOPLayerTranslationY];
    // anim = [self animWi];
    // anim = [self animWi];
    // anim = [self animWi];
    // anim = [self animWi];
    anim.springBounciness = 0.f;
    anim.beginTime = CACurrentMediaTime() + 1;
    [self.topView.layer pop_addAnimation:anim forKey:@"allCategoryView.translation.y"];
}
- (POPSpringAnimation *)animWithkPOPLayerBounds {
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    CGRect frame = self.topView.frame;
    frame.size.height = 0.f;
    anim.fromValue = [NSValue valueWithCGRect:frame];
    frame.size.height = 200.f;
    anim.toValue = [NSValue valueWithCGRect:frame];
    return anim;
}
- (POPSpringAnimation *)animWithkPOPLayerPositionY {
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.fromValue = @(SCREEN_Height);
    anim.fromValue = @0.f;
    return anim;
}
- (POPSpringAnimation *)animWithkPOPLayerTranslationY {
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:
                                kPOPLayerTranslationY];
    anim.fromValue = @(SCREEN_HEIGHT);
    anim.toValue = @(0);
    // anim.fromValue = @0.f;
    // anim.toValue = @1.f;
    return anim;
}
- (POPSpringAnimation *)animWithkPOPLayerScaleY {
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:
                                kPOPLayerScaleY];
    anim.fromValue = @(0);
    anim.toValue = @(1);
    return anim;
}
- (POPSpringAnimation *)animWithkPOPLayerSize {
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:
                                kPOPViewFrame];
    // CGSize size = self.topView.frame.size;
    // size.height = 0.f;
    // anim.fromValue = [NSValue valueWithCGSize:size];
    // size.height = 200.f;
    // anim.toValue = [NSValue valueWithCGSize:size];
    CGRect frame = self.topView.frame;
    // anim.toValue = [NSValue valueWithCGRect:frame];
    // frame.origin.y = 0.f;
    frame.size.height = 0.f;
    anim.fromValue = [NSValue valueWithCGRect:frame];
    // anim.fromValue = @0.f;
    // anim.toValue = @1.f;
    return anim;
}
/**
 - (POPSpringAnimation *)animWith {
 POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
 // anim.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
 // anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_Height / 2.f)];
 // anim.fromValue = @(SCREEN_Height);
 // anim.toValue = @(SCREEN_Height);
 return anim;
 }
 */

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)btnGoClick:(UIButton *)sender {
    [self addAnimation];
}
- (void)segmentControlValueChanged:(UISegmentedControl *)segmentedControl {
    POPSpringAnimation *anim;
    switch(segmentedControl.selectedSegmentIndex) {
    case 0: {
        anim = [self animWithkPOPLayerBounds];
    } break;
    case 1: {
        anim = [self animWithkPOPLayerPositionY];
    } break;
    case 2: {
        anim = [self animWithkPOPLayerTranslationY];
    } break;
    case 3: {
        anim = [self animWithkPOPLayerScaleY];
    } break;
    case 4: {
        anim = [self animWithkPOPLayerSize];
    } break;
    default: break;
    }
    if(anim) {
        anim.springBounciness = 0.f;
        anim.beginTime = CACurrentMediaTime() + 1;
        __weak typeof(anim) weakAnim = anim;
        anim.completionBlock = ^(POPAnimation *anim2, BOOL finished) {
            NSLog(@"-->[%d]: %@", finished, anim2);
            NSLog(@"-->%@", weakAnim);
        };
        [self.topView.layer pop_addAnimation:anim forKey:@"allCategoryView.translation.y"];
    }
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.labLine1];
    [self.view addSubview:self.labLine2];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.segment];
    [self.view addSubview:self.btnGo];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0.f);
        make.width.height.equalTo(@200.f);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0.f);
        make.width.height.equalTo(@200.f);
    }];
    [self.labLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100.f);
        make.centerX.equalTo(@0.f);
        make.width.equalTo(@100.f);
    }];
    [self.labLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labLine1.mas_bottom).offset(20.f);
        make.left.width.equalTo(self.labLine1);
    }];
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labLine2.mas_bottom).offset(10.f);
        make.centerX.equalTo(@0.f);
    }];
    [self.btnGo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segment.mas_bottom).offset(5.f);
        make.centerX.equalTo(@0.f);
        make.width.equalTo(@200.f);
        make.height.equalTo(@44.f);
    }];
}

#pragma mark Lazy Property
- (UIView *)topView {
    if(!_topView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7f];
        _topView = v;
    }
    return _topView;
}
- (UIView *)bottomView {
    if(!_bottomView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.7f];
        _bottomView = v;
    }
    return _bottomView;
}
- (UILabel *)labLine1 {
    if(!_labLine1){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"上海市第一医药商店连锁经营有限公司国货第一医药商店";
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor blackColor];
        // label.backgroundColor = [UIColor <#cyanColor#>];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentLeft;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labLine1 = label;
    }
    return _labLine1;
}
- (UILabel *)labLine2 {
    if(!_labLine2){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"上海市第一医药商店连锁经营";
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor blackColor];
        // label.backgroundColor = [UIColor <#cyanColor#>];
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentLeft;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labLine2 = label;
    }
    return _labLine2;
}
- (UIButton *)btnGo {
    if(!_btnGo){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];

        [btn setTitle:@"Go" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [btn addTarget:self action:@selector(btnGoClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnGo = btn;
    }
    return _btnGo;
}
- (UISegmentedControl *)segment {
    if(!_segment){
        UISegmentedControl *v = [[UISegmentedControl alloc]initWithItems:@[
            @"Bounds",
            @"PositionY",
            @"TranslationY",
            @"ScaleY",
            @"Size",
        ]];
        [v addTarget:self action:@selector(segmentControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        _segment = v;
    }
    return _segment;
}
@end

