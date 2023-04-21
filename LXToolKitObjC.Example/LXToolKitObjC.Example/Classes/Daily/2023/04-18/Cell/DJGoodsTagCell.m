//
//  DJGoodsTagCell.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/4/18.
//
#import "DJGoodsTagCell.h"
#import <Masonry/Masonry.h>
#import <LXToolKitObjC/LXLabel.h>
#import <DJRSwiftResource/DJRSwiftResource-Swift.h>

@interface DJGoodsTagCell() {
}
@property(nonatomic, strong)UILabel *labTag;
@property(nonatomic, strong)UIImageView *imgViewTag;
@property(nonatomic, strong)LXLabel *labContent;

@end

@implementation DJGoodsTagCell
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
- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"-->layoutSubviews: %@\t%@", NSStringFromCGRect(self.contentView.frame), self);
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(NSDictionary *)item {
    self.labTag.hidden = YES;
    self.imgViewTag.hidden = YES;

    NSString *tag = item[@"tag"];
    self.labTag.hidden = ![tag isEmpty];
    // self.imgViewTag.image =
    NSString *plus = item[@"tagPlus"];
    self.imgViewTag.hidden = YES;
    self.labTag.hidden = YES;
    if(![plus isEmpty]) {
        self.imgViewTag.hidden = NO;
        self.imgViewTag.image = DJTest.dj_plus_member;
        self.backgroundColor = [UIColor xl_colorWithHexString:@"#F9C5A9"];
        self.labContent.textColor = [UIColor xl_colorWithHexString:@"#191B22"];
        self.contentView.layer.borderWidth = 0.f;
        self.labContent.text = plus;
    } else {
        self.labTag.hidden = NO;
        self.labTag.text = tag;
        self.backgroundColor = [[UIColor xl_colorWithHexString:@"#FF4515"]colorWithAlphaComponent:0.05f];
        self.labContent.textColor = [UIColor xl_colorWithHexString:@"#FF4515"];
        self.contentView.layer.borderWidth = kFixed0_5;
        self.labContent.text = item[@"content"];
    }
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = kWPercentage(3.f);
    self.contentView.layer.borderColor = [UIColor xl_colorWithHexString:@"#FF4515"].CGColor;
    self.contentView.layer.borderWidth = kFixed0_5;
    self.contentView.clipsToBounds = YES;

    [self.contentStackView addArrangedSubview:self.labTag];
    [self.contentStackView addArrangedSubview:self.imgViewTag];
    [self.contentStackView addArrangedSubview:self.labContent];
    [self.contentView addSubview:self.contentStackView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.contentStackView, self.labTag,
                  self.imgViewTag, self.labContent)
    [self.contentStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
        make.height.equalTo(@(kDJGoodsTagViewHeight));
    }];
    [self.labTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kWPercentage(14.f)));
    }];
}

#pragma mark Lazy Property
- (UIStackView *)contentStackView {
    if(!_contentStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisHorizontal;
        sv.alignment = UIStackViewAlignmentFill;
        // sv.distribution = UIStackViewDistributionFillProportionally;
        sv.spacing = 0.f;
        _contentStackView = sv;
    }
    return _contentStackView;
}
- (UILabel *)labTag {
    if(!_labTag){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont boldSystemFontOfSize:kWPercentage(9.f)];
        label.textColor = [UIColor xl_colorWithHexString:@"#FFFFFF"];
        label.backgroundColor = [UIColor xl_colorWithHexString:@"#FF4515"];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.hidden = YES;
        _labTag = label;
    }
    return _labTag;
}
- (UIImageView *)imgViewTag {
    if(!_imgViewTag){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        iv.hidden = YES;
        _imgViewTag = iv;
    }
    return _imgViewTag;
}
- (LXLabel *)labContent {
    if(!_labContent){
        LXLabel *label = [[LXLabel alloc]init];
        CGFloat padding = kWPercentage(2.5f);
        label.x_insets = UIEdgeInsetsMake(padding, padding, padding, padding);
        label.text = @"";
        label.font = [UIFont systemFontOfSize:kWPercentage(9.f)];
        label.textColor = [UIColor xl_colorWithHexString:@"#FF4515"];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labContent = label;
    }
    return _labContent;
}

@end
