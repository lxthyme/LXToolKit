//
//  DJYYZZInfoCell.m
//  DJBusinessModule
//
//  Created by lxthyme on 2022/7/20.
//
#import "DJYYZZInfoCell.h"

#import <DJBusinessTools/UIView+ex.h>

@interface DJYYZZInfoCell() {
}
@property (nonatomic, strong)UILabel *labTitle;
@property (nonatomic, strong)UITextView *subtitleTextView;

@end

@implementation DJYYZZInfoCell
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
#pragma mark - 🌎LoadData
- (void)dataFill:(DJYYZZInfoModel *)item {
    self.labTitle.text = [NSString stringWithFormat:@"%@:", item.certificateTypeName];
    self.subtitleTextView.text = item.extInfo;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor whiteColor];

    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.subtitleTextView];

    [self.contentView xl_addBorder:UIRectEdgeTop
                             color:[UIColor colorWithHex:0xEEEEEE]
                         thickness:1.f];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kWPercentage(18.f)));
        make.left.equalTo(@(kWPercentage(30.f)));
        make.right.lessThanOrEqualTo(@(kWPercentage(-30.f)));
        make.height.greaterThanOrEqualTo(@(kWPercentage(20.f)));
    }];
    [self.subtitleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(kWPercentage(4.f));
        make.left.equalTo(@(kWPercentage(30.f)));
        make.right.equalTo(@(kWPercentage(-30.f)));
        make.bottom.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:kWPercentage(14.f)];
        label.textColor = [UIColor colorWithHex:0x737373];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
- (UITextView *)subtitleTextView {
    if(!_subtitleTextView){
        UITextView *v = [[UITextView alloc]init];
        v.editable = NO;
        v.font = [UIFont systemFontOfSize:kWPercentage(14.f)];
        v.textColor = [UIColor colorWithHex:0x333333];
        v.textAlignment = NSTextAlignmentLeft;
        v.textContainerInset = UIEdgeInsetsZero;
        _subtitleTextView = v;
    }
    return _subtitleTextView;
}
@end
