//
//  LXLabelTestVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/23.
//
#import "LXLabelTestVC.h"

#import <Masonry/Masonry.h>
#import <YYText/YYText.h>

@interface LXLabelTestVC() {
}
@property(nonatomic, strong)UILabel *labTitle;
@property(nonatomic, strong)UILabel *labTitle2;
@property(nonatomic, strong)UITextView *tvTitle3;

@end

@implementation LXLabelTestVC
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
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    // navigationItem.title = @"";

    [self.view addSubview:self.labTitle];
    [self.view addSubview:self.labTitle2];
    [self.view addSubview:self.tvTitle3];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0.f);
        make.width.equalTo(@235.f);
        make.height.equalTo(@100.f);
    }];
    [self.labTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(10.f);
        make.centerX.with.height.equalTo(self.labTitle);
    }];
    [self.tvTitle3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle2.mas_bottom).offset(10.f);
        make.centerX.height.equalTo(self.labTitle);
        make.width.equalTo(@230.f);
    }];
}

#pragma mark Lazy Property
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"老正兴菜馆（福州路店）配送";
        label.font = [UIFont systemFontOfSize:18.f];
        label.textColor = [UIColor blackColor];
        // label.backgroundColor = [UIColor <#cyanColor#>];
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentLeft;
        label.lineBreakMode = NSLineBreakByCharWrapping;//NSLineBreakByTruncatingTail;
        label.layer.borderWidth = 1.f;
        label.layer.borderColor = [UIColor cyanColor].CGColor;
        _labTitle = label;
    }
    return _labTitle;
}
- (UILabel *)labTitle2 {
    if(!_labTitle2){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"老正兴菜馆（福州路店）配送老正兴菜馆（福州路店）配送";
        label.font = [UIFont systemFontOfSize:18.f];
        label.textColor = [UIColor blackColor];
        // label.backgroundColor = [UIColor <#cyanColor#>];
        label.textAlignment = NSTextAlignmentLeft;
        label.lineBreakMode = NSLineBreakByCharWrapping | NSLineBreakByTruncatingTail;
        label.numberOfLines = 2;
        label.layer.borderWidth = 1.f;
        label.layer.borderColor = [UIColor cyanColor].CGColor;
        _labTitle2 = label;
    }
    return _labTitle2;
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
