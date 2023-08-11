//
//  DJCommentServiceAnswerView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/11.
//
#import "DJCommentServiceAnswerView.h"

#import <Masonry/Masonry.h>

@interface DJCommentServiceAnswerView() {
}
@property(nonatomic, strong)UILabel *labTitle;
@property(nonatomic, strong)UILabel *labContent;

@end

@implementation DJCommentServiceAnswerView
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
- (void)dataFill {
    self.labContent.text = @"亲爱的顾客，感谢您的信任与支持。";
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor colorWithHex:0xF4F6FA];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.f;

    [self addSubview:self.labTitle];
    [self addSubview:self.labContent];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10.f);
        make.centerY.equalTo(@0.f);
    }];
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labTitle.mas_right).offset(10.f);
        // make.right.lessThanOrEqualTo(@-10.f);
        make.centerY.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"客服回答";
        label.font = [UIFont boldSystemFontOfSize:kWPercentage(13.f)];
        label.textColor = [UIColor colorWithHex:0x333333];
        // label.backgroundColor = [UIColor <#cyanColor#>];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
- (UILabel *)labContent {
    if(!_labContent){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:kWPercentage(13.f)];
        label.textColor = [UIColor colorWithHex:0x666666];
        // label.backgroundColor = [UIColor <#cyanColor#>];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labContent = label;
    }
    return _labContent;
}
@end
