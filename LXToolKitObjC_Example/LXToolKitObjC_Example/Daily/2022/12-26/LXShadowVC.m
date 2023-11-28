//
//  LXShadowVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/12/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXShadowVC.h"
#import <LXToolKitObjC/LXMacro.h>
#import <LXToolKitObjC/UIColor+ex.h>
#import <Masonry/Masonry.h>
#import <YYModel/YYModel.h>
#import "DJZitiRuleTipModel.h"

@interface LXShadowVC() {
}
@property(nonatomic, strong)UIView *shadowView;
@property(nonatomic, strong)UITextView *tvContent;
@property(nonatomic, strong)UIButton *btnStack;
@property(nonatomic, strong)UIStackView *btnWrapperStackView;
@property(nonatomic, strong)UIImageView *imgViewLogo;
@property(nonatomic, strong)UITextView *tvTips;

@end

@implementation LXShadowVC
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
    // [self testArray];
    [self testAttributedString];
    [self testBtnStack];

    self.shadowView.hidden = YES;
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)testArray {
    NSArray *a = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    NSLog(@"a: %@", a);
}
- (void)testAttributedString {
    NSDictionary *data = @{
        @"title": @"请在下单或指定自提最晚时间+24小时内完成自提，超时未取将取消订单。",
        @"ruleLt": @[@{
            @"label": @"手机号和自提码取货",
            @"value": @"用户凭下单手机号和自提码到店取货，通过验证后可自提商品。"
        }, @{
            @"label": @"24小时内自提，超时取消",
            @"value": @"请在下单或指定自提最晚时间+24小时内完成自提，超时未取将取消订单，支付款将原路返回。"
        }]
    };
    DJZitiRuleTipModel *model = [DJZitiRuleTipModel yy_modelWithJSON:data];
    __block NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    // style.lineHeightMultiple = 1.5f;
    // style.paragraphSpacingBefore = 20.f;
    [model.ruleLt enumerateObjectsUsingBlock:^(DJZitiRuleTipItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // DJZitiRuleTipItemModel *item1 = data.ruleLt[idx];

        UIFont *font1 = [UIFont boldSystemFontOfSize:kWPercentage(14)];
        style.lineSpacing = 10 - (font1.lineHeight - font1.pointSize);
        NSMutableAttributedString *attrTitle1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"·%@\n", obj.label] attributes:@{
            NSParagraphStyleAttributeName: style,
            NSFontAttributeName: font1,
            NSForegroundColorAttributeName: [UIColor xl_colorWithHex:0xFF774F]
        }];
        [string appendAttributedString:attrTitle1];

        UIFont *font2 = [UIFont systemFontOfSize:kWPercentage(14)];
        style.lineSpacing = 10 - (font2.lineHeight - font2.pointSize);
        BOOL isLast = idx == model.ruleLt.count - 1;
        NSMutableAttributedString *attrSubTitle1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", obj.value, isLast ? @"" : @"\n\n"] attributes:@{
            NSParagraphStyleAttributeName: style,
            NSFontAttributeName: font2,
            NSForegroundColorAttributeName: [UIColor xl_colorWithHex:0x666666]
        }];
        [string appendAttributedString:attrSubTitle1];
    }];
    self.tvContent.attributedText = string;
}
- (void)testBtnStack {
    // self.imgViewLogo.image = [UIImage imageNamed:@""];
    NSString *text = @"马来西亚进口 福多巧克力瑞士卷 108g";
    UIFont *font = [UIFont systemFontOfSize:20.f];
    // font.lineHeight = 30.f;
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    // style.lineHeightMultiple = 2;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    UIImage *tagImg = [UIImage imageNamed:@"icon_coupon_tag_diyong"];
    if(tagImg) {
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = tagImg;
        CGFloat h = 13.f;
        CGFloat w = h * (tagImg.size.width / tagImg.size.height);
        attach.bounds = CGRectMake(0, 0, w, h);
        [attr appendAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
    }
    [attr appendAttributedString:[[NSMutableAttributedString alloc]initWithString:text attributes:@{
        NSFontAttributeName: font,
        // NSParagraphStyleAttributeName: style,
    }]];
    // self.tvTips.font = font;
    // self.tvTips.text = text;
    // self.tvTips.attributedText = attr;
    self.tvTips.text = text;

}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.shadowView];
    [self.view addSubview:self.tvContent];

    [self.btnWrapperStackView addArrangedSubview:self.imgViewLogo];
    // [self.btnWrapperStackView addArrangedSubview:self.tvTips];
    [self.btnStack addSubview:self.btnWrapperStackView];
    [self.view addSubview:self.btnStack];
    [self.view addSubview:self.tvTips];

    [self masonry];
    // [self.btnWrapperStackView xl_setVerticalHuggingAndCompression];
    // [self.btnStack xl_setVerticalHuggingAndCompression];
    // [self.btnWrapperStackView xl_setAllHuggingAndCompression];
    // [self.btnStack xl_setAllHuggingAndCompression];
    // [self.tvTips xl_setHorizontalHuggingAndCompression];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@200);
        make.left.right.equalTo(@0.f);
        make.height.equalTo(@10);
    }];
    [self.tvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shadowView.mas_bottom);
        make.width.equalTo(@(kWPercentage(250.f)));
        make.height.equalTo(@(kWPercentage(200.f)));
        make.centerX.equalTo(@0.f);
    }];
    [self.imgViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(kWPercentage(20.f)));
    }];
    [self.btnWrapperStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
    [self.btnStack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tvContent.mas_bottom).offset(50.f);
        make.centerX.equalTo(@0.f);
    }];
    [self.tvTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnWrapperStackView.mas_bottom).offset(10.f);
        make.centerX.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UIView *)shadowView {
    if(!_shadowView){
        UIView *v = [[UIView alloc]init];
        // v.backgroundColor = [UIColor whiteColor];
        v.layer.shadowColor = [UIColor xl_colorWithHex:0x000000].CGColor;
        v.layer.shadowOffset = CGSizeMake(0, 2);
        v.layer.shadowOpacity = 1;
        v.layer.shadowRadius = kWPercentage(10.f);
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake(0, 0, SCREEN_WIDTH, 10));
        v.layer.shadowPath = path;
        CGPathRelease(path);
        _shadowView = v;
    }
    return _shadowView;
}
- (UITextView *)tvContent {
    if(!_tvContent){// <#UITextViewDelegate#>
        UITextView *tv = [[UITextView alloc]init];
        tv.editable = NO;
        tv.textColor = [UIColor xl_colorWithHex:0x666666];
        tv.font = [UIFont systemFontOfSize:15];
        tv.returnKeyType = UIReturnKeyDone;
        tv.keyboardType = UIKeyboardTypeDefault;
        tv.contentInset = UIEdgeInsetsZero;
        CGFloat padding = tv.textContainer.lineFragmentPadding;
        tv.textContainerInset = UIEdgeInsetsMake(0, -padding, 0, -padding);
        _tvContent = tv;
    }
    return _tvContent;
}
- (UIButton *)btnStack {
    if(!_btnStack){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor cyanColor];
        _btnStack = btn;
    }
    return _btnStack;
}
- (UIStackView *)btnWrapperStackView {
    if(!_btnWrapperStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisHorizontal;
        sv.alignment = UIStackViewAlignmentFill;
        // sv.distribution = UIStackViewDistributionFillProportionally;
        sv.spacing = 10.f;
        _btnWrapperStackView = sv;
    }
    return _btnWrapperStackView;
}
- (UIImageView *)imgViewLogo {
    if(!_imgViewLogo){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.backgroundColor = [UIColor magentaColor];
        // iv.image = [UIImage imageNamed:@""];
        _imgViewLogo = iv;
    }
    return _imgViewLogo;
}
- (UITextView *)tvTips {
    if(!_tvTips){
        UITextView *tv = [[UITextView alloc]init];
        tv.editable = NO;
        tv.textColor = [UIColor blackColor];
        tv.font = [UIFont systemFontOfSize:16.f];
        tv.backgroundColor = [UIColor magentaColor];
        tv.returnKeyType = UIReturnKeyDone;
        tv.keyboardType = UIKeyboardTypeDefault;
        tv.contentInset = UIEdgeInsetsZero;
        tv.textContainerInset = UIEdgeInsetsZero;
        tv.textAlignment = NSTextAlignmentLeft;
        tv.scrollEnabled = NO;
        tv.showsHorizontalScrollIndicator = NO;
        tv.showsVerticalScrollIndicator = NO;
        _tvTips = tv;
    }
    return _tvTips;
}

@end
