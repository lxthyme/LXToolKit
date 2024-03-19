//
//  LXTable202403SectionView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2024/3/7.
//
#import "LXTable202403SectionView.h"

#import <Masonry/Masonry.h>

@interface LXTable202403SectionView() {
}
@property(nonatomic, strong)UIView *topView;
@property(nonatomic, strong)UIView *rightView;
@property(nonatomic, strong)UILabel *labTitle;

@end

@implementation LXTable202403SectionView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(NSString *)title {
    self.labTitle.text = title;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor cyanColor];

    self.topView.hidden = YES;
    self.rightView.hidden = YES;

    [self addSubview:self.topView];
    [self addSubview:self.rightView];
    // [self addSubview:self.labTitle];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(@0.f);
        make.left.equalTo(@50.f);
        make.height.equalTo(@44.f);
    }];
    // [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.top.equalTo(self.topView.mas_bottom);
    //     make.left.bottom.equalTo(@0.f);
    //     make.width.equalTo(@200.f);
    // }];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(@0.f);
        // make.left.equalTo(self.labTitle.mas_right);
        // make.right.equalTo(@0.f);
        make.width.equalTo(@150.f);
    }];
}

#pragma mark Lazy Property
- (UIView *)topView {
    if(!_topView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        _topView = v;
    }
    return _topView;
}
- (UIView *)rightView {
    if(!_rightView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        _rightView = v;
    }
    return _rightView;
}
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
        label.textColor = [UIColor colorWithHex:0x666666];
        label.backgroundColor = [UIColor colorWithHex:0xF4F6FA];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
@end
