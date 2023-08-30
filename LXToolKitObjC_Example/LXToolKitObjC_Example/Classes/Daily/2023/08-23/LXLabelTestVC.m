//
//  LXLabelTestVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/23.
//
#import "LXLabelTestVC.h"

#import <Masonry/Masonry.h>
#import <YYText/YYText.h>
#import "LXCornerRadiusView.h"

@interface LXLabelTestVC() {
}
@property(nonatomic, strong)UIStackView *wrapperStackView;
@property(nonatomic, strong)UILabel *labTitle;
@property(nonatomic, strong)UILabel *labTitle2;
@property(nonatomic, strong)UILabel *labTitle3;
@property(nonatomic, strong)UILabel *labTitle4;
@property(nonatomic, strong)LXCornerRadiusView *cornerView;
@property(nonatomic, strong)UITextView *tvTitle3;

@end

@implementation LXLabelTestVC
- (void)dealloc {
    NSLog(@"🎷DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    [self prepareUI];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (UILabel *)createfactoryLabel {
    UILabel *label = [[UILabel alloc]init];
    label.text = @"老正兴菜馆（福州路店）配送";
    label.font = [UIFont systemFontOfSize:18.f];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [[UIColor cyanColor]colorWithAlphaComponent:0.3f];
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByCharWrapping;//NSLineBreakByTruncatingTail;
    label.layer.borderWidth = 1.f;
    label.layer.borderColor = [UIColor cyanColor].CGColor;
    return label;
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    // navigationItem.title = @"";

    [self.wrapperStackView addArrangedSubview:self.labTitle];
    [self.wrapperStackView addArrangedSubview:self.labTitle2];
    [self.wrapperStackView addArrangedSubview:self.labTitle3];
    [self.wrapperStackView addArrangedSubview:self.labTitle4];
    [self.wrapperStackView addArrangedSubview:self.cornerView];
    [self.wrapperStackView addArrangedSubview:self.tvTitle3];

    [self.view addSubview:self.wrapperStackView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.wrapperStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0.f);
        make.width.equalTo(@230.f);
        // make.height.equalTo(@100.f);
    }];
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.greaterThanOrEqualTo(@30.f);
    }];
    [self.labTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.greaterThanOrEqualTo(@30.f);
    }];
    [self.labTitle3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.greaterThanOrEqualTo(@30.f);
    }];
    [self.labTitle4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.greaterThanOrEqualTo(@30.f);
    }];
    [self.cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30.f);
    }];
}

#pragma mark Lazy Property
- (UIStackView *)wrapperStackView {
    if(!_wrapperStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisVertical;
        sv.alignment = UIStackViewAlignmentFill;
        // sv.distribution = UIStackViewDistributionFillProportionally;
        sv.spacing = 10.f;
        _wrapperStackView = sv;
    }
    return _wrapperStackView;
}
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [self createfactoryLabel];
        label.text = @"1";
        label.layer.cornerRadius = 16.f;
        label.layer.cornerCurve = kCACornerCurveContinuous;
        label.layer.masksToBounds = YES;
        _labTitle = label;
    }
    return _labTitle;
}
- (UILabel *)labTitle2 {
    if(!_labTitle2){
        UILabel *label = [self createfactoryLabel];
        label.text = @"2";
        label.layer.cornerRadius = 16.f;
        label.layer.cornerCurve = kCACornerCurveContinuous;
        _labTitle2 = label;
    }
    return _labTitle2;
}
- (UILabel *)labTitle3 {
    if(!_labTitle3){
        UILabel *label = [self createfactoryLabel];
        label.text = @"3";
        label.layer.cornerRadius = 16.f;
        label.layer.masksToBounds = YES;
        _labTitle3 = label;
    }
    return _labTitle3;
}
- (UILabel *)labTitle4 {
    if(!_labTitle4){
        UILabel *label = [self createfactoryLabel];
        label.text = @"4";
        label.layer.cornerRadius = 16.f;
        label.layer.maskedCorners = kCALayerMaxXMaxYCorner | kCALayerMaxXMinYCorner;
        label.layer.cornerCurve = kCACornerCurveContinuous;
        _labTitle4 = label;
    }
    return _labTitle4;
}
- (LXCornerRadiusView *)cornerView {
    if(!_cornerView){
        LXCornerRadiusView *v = [[LXCornerRadiusView alloc]init];
        v.corners = UIRectCornerAllCorners;
        v.cornerRadii = CGSizeMake(35.f, 35.f);
        _cornerView = v;
    }
    return _cornerView;
}
- (UITextView *)tvTitle3 {
    if(!_tvTitle3){
        UITextView *tv = [[UITextView alloc]init];
        tv.text = @"老正兴菜馆（福州路店）配送";
        tv.editable = NO;
        tv.scrollEnabled = NO;
        tv.textColor = [UIColor blackColor];
        tv.font = [UIFont systemFontOfSize:18.f];
        tv.returnKeyType = UIReturnKeyDone;
        tv.keyboardType = UIKeyboardTypeDefault;
        tv.textAlignment = NSTextAlignmentLeft;
        tv.showsHorizontalScrollIndicator = NO;
        tv.showsVerticalScrollIndicator = NO;
        tv.textContainer.maximumNumberOfLines = 2;
        tv.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
        tv.contentInset = UIEdgeInsetsZero;
        tv.textContainerInset = UIEdgeInsetsZero;
        CGFloat padding = tv.textContainer.lineFragmentPadding;
        tv.textContainerInset = UIEdgeInsetsMake(0, -padding, 0, -padding);

        tv.layer.borderWidth = 1.f;
        tv.layer.borderColor = [UIColor cyanColor].CGColor;
        _tvTitle3 = tv;
    }
    return _tvTitle3;
}
@end
