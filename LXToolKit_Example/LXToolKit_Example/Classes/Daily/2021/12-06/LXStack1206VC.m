//
//  LXStack1206VC.m
//  LXToolKit_Exam
//
//  Created by lxthyme on 2021/12/6.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import "LXStack1206VC.h"
#import <Masonry/Masonry.h>

#define kWPercentage(a) (SCREEN_WIDTH *((a)/SCREEN_WIDTH))
#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)

#define kVPadding kWPercentage(10.f)
#define kHPadding kWPercentage(20.f)
#define kDetailMaxWidth SCREEN_WIDTH / 2.f

@interface LXStack1206VC() {
}
@property(nonatomic, strong)UIStackView *wrapperStackView;
/// 标题
@property(nonatomic, strong)UILabel *labTitle;
/// 详情
@property(nonatomic, strong)UILabel *labDetail;
@property(nonatomic, strong)UIStackView *labDetailStackView;
/// 描述
@property(nonatomic, strong)UILabel *labSubtitle;
@property(nonatomic, strong)UIStackView *labSubtitleStackView;

@end

@implementation LXStack1206VC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
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
    self.view.backgroundColor = [UIColor whiteColor];

    [self prepareUI];
    [self dataFill];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)dataFill {
    self.labTitle.text = @"title";
    // self.labDetail.text = @"鲁械广审(文) 第鲁械广审(文) 第鲁2020509758289299号鲁械广审(文) 第鲁械广审(文)";
    // self.labSubtitle.text = @"鲁械广审(文) 第鲁械广审(文) 第鲁2020509758289299号鲁械广审(文) 第鲁械广审(文) 第鲁2020509758289299号鲁械广审(文) 第鲁械广审(文) 第鲁2020509758289299号鲁械广审(文) 第鲁械广审(文) 第鲁2020509758289299号鲁械广审(文) 第鲁械广审(文) 第鲁2020509758289299号鲁械广审(文) 第鲁械广审(文) 第鲁2020509758289299号";
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.labTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.wrapperStackView];
    [self.wrapperStackView addArrangedSubview:self.labTitle];
    [self.labDetailStackView addArrangedSubview:self.labDetail];
    [self.wrapperStackView addArrangedSubview:self.labDetailStackView];
    [self.labSubtitleStackView addArrangedSubview:self.labSubtitle];
    [self.wrapperStackView addArrangedSubview:self.labSubtitleStackView];
    [self masonry];
}
- (void)masonry {
    [self.wrapperStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0.f);
        make.center.equalTo(@0.f);
    }];
    // [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.top.equalTo(@0.f);
    //     make.left.equalTo(@(16.f));
    //     make.right.equalTo(@(-16.f));
    // }];
    // [self.labDetailStackView mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.top.equalTo(self.labTitle.mas_bottom).offset(10.f);
    //     make.left.right.equalTo(self.labTitle);
    // }];
    // [self.labSubtitleStackView mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.top.equalTo(self.labDetailStackView.mas_bottom).offset(10.f);
    //     make.left.right.equalTo(self.labTitle);
    //     make.bottom.equalTo(@0.f);
    // }];
}

#pragma mark -
#pragma mark - 📌Property Lazy Load
- (UIStackView *)wrapperStackView {
    if(!_wrapperStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisVertical;
        sv.spacing = 0.f;
        _wrapperStackView = sv;
    }
    return _wrapperStackView;
}
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        [label setText:@""];
        [label setNumberOfLines:1];
        [label setTextColor:[UIColor blackColor]];
        [label setLineBreakMode:NSLineBreakByWordWrapping];
        [label setTextAlignment:NSTextAlignmentCenter];
        _labTitle = label;
    }
    return _labTitle;
}
- (UIStackView *)labDetailStackView {
    if(!_labDetailStackView){
        _labDetailStackView = [[UIStackView alloc]init];
        _labDetailStackView.axis = UILayoutConstraintAxisHorizontal;
        _labDetailStackView.spacing = 0.f;
    }
    return _labDetailStackView;
}
- (UILabel *)labDetail {
    if(!_labDetail){
        UILabel *label = [[UILabel alloc]init];
        [label setText:@""];
        [label setNumberOfLines:0];
        [label setTextColor:[UIColor blackColor]];
        [label setLineBreakMode:NSLineBreakByWordWrapping];
        [label setTextAlignment:NSTextAlignmentCenter];
        _labDetail = label;
    }
    return _labDetail;
}
- (UIStackView *)labSubtitleStackView {
    if(!_labSubtitleStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisHorizontal;
        sv.spacing = 0.f;
        _labSubtitleStackView = sv;
    }
    return _labSubtitleStackView;
}
- (UILabel *)labSubtitle {
    if(!_labSubtitle){
        UILabel *label = [[UILabel alloc]init];
        [label setText:@""];
        [label setNumberOfLines:1];
        [label setTextColor:[UIColor blackColor]];
        [label setLineBreakMode:NSLineBreakByWordWrapping];
        [label setTextAlignment:NSTextAlignmentCenter];
        _labSubtitle = label;
    }
    return _labSubtitle;
}

@end
