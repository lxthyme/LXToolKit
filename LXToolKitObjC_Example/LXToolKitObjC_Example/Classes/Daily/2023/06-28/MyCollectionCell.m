//
//  MyCollectionCell.m
//  tes
//
//  Created by lxthyme on 2023/6/19.
//
#import "MyCollectionCell.h"

#import <Masonry/Masonry.h>

@interface MyCollectionCell() {
}
@property(nonatomic, strong)UIView *wrapperView;

@end

@implementation MyCollectionCell
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
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    // Configure the view for the selected state
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor whiteColor];

    [self.wrapperView addSubview:self.labTitle];
    [self.contentView addSubview:self.wrapperView];

    [self masonry];
}
- (void)updateConstraints {
    [super updateConstraints];
    NSLog(@"-->masonry");
    // [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.top.bottom.centerX.equalTo(@0.f);
        // make.width.equalTo(@(SCREEN_WIDTH - kWPercentage(12.f * 2)));
        make.edges.equalTo(@0.f);
        make.height.equalTo(@50.f);
    }];
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kWPercentage(15.f)));
        make.left.equalTo(@(kWPercentage(10.f)));
        make.right.equalTo(@(kWPercentage(-10.f)));
        make.bottom.equalTo(@(kWPercentage(-15.f)));
        // make.height.equalTo(@50.f);
    }];
}

#pragma mark Lazy Property
- (UIView *)wrapperView {
    if(!_wrapperView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        v.layer.cornerRadius = kWPercentage(13.f);
        v.layer.masksToBounds = YES;
        _wrapperView = v;
    }
    return _wrapperView;
}
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor blackColor];
        // label.backgroundColor = [UIColor <#cyanColor#>];
        label.layer.borderWidth = kFixed0_5;
        label.layer.borderColor = [UIColor cyanColor].CGColor;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentLeft;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
@end
