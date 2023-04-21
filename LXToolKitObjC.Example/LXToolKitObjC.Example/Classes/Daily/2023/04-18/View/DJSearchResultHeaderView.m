//
//  DJSearchResultHeaderView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/4/18.
//
#import "DJSearchResultHeaderView.h"
#import <Masonry/Masonry.h>
#import <DJRSwiftResource/DJRSwiftResource-Swift.h>

@interface DJSearchResultHeaderView() {
}
@property(nonatomic, strong)UILabel *labTitle;
@property(nonatomic, strong)UIButton *btnRefresh;

@property(nonatomic, assign)DJSearchResultHeaderStyle style;

@end

@implementation DJSearchResultHeaderView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}
- (void)prepareForReuse {
    [super prepareForReuse];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(NSString *)title style:(DJSearchResultHeaderStyle)style {
    self.style = style;
    self.labTitle.text = title;
    UIImage *logo;
    switch (style) {
        case DJSearchResultHeaderStyleRefresh: {
            logo = DJTest.icon_search_refresh;
        } break;
        case DJSearchResultHeaderStyleDelete: {
            logo = DJTest.icon_search_delete;
        } break;
        default:
            break;
    }
    [self.btnRefresh setImage:logo forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)btnRefreshClick:(UIButton *)sender {
    !self.actionBlock ?: self.actionBlock(self.style);
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.labTitle];
    [self addSubview:self.btnRefresh];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kWPercentage(15.f)));
        make.bottom.equalTo(@(kWPercentage(-15.f)));
    }];
    [self.btnRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle);
        make.right.bottom.equalTo(@0.f);
        make.width.equalTo(self.btnRefresh.mas_height);
    }];
}

#pragma mark Lazy Property
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont boldSystemFontOfSize:kWPercentage(15.f)];
        label.textColor = [UIColor xl_colorWithHexString:@"#333333"];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
- (UIButton *)btnRefresh {
    if(!_btnRefresh){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];

        [btn setImage:[UIImage imageNamed:@"icon_search_refresh"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnRefreshClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnRefresh = btn;
    }
    return _btnRefresh;
}
@end
