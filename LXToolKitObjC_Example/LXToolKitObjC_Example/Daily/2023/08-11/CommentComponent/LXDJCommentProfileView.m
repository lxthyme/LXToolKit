//
//  LXDJCommentProfileView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/11.
//
#import "LXDJCommentProfileView.h"

#import <Masonry/Masonry.h>
#import "LXDJCommentStarView.h"

#define kDJCommentProfileAvatarWidth 30.f

@interface LXDJCommentProfileView() {
}
@property(nonatomic, strong)UIImageView *imgViewAvatar;
@property(nonatomic, strong)UILabel *labName;
@property(nonatomic, strong)UILabel *labDate;
@property(nonatomic, strong)LXDJCommentStarView *starView;

@end

@implementation LXDJCommentProfileView
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
    self.imgViewAvatar.backgroundColor = [UIColor lightGrayColor];
    self.labName.text = @"小**蛋";
    self.labDate.text = @"2023-02-28";
    NSInteger score = arc4random_uniform(5);
    [self.starView dataFill:score];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.imgViewAvatar];
    [self addSubview:self.labName];
    [self addSubview:self.starView];
    [self addSubview:self.labDate];

    [self masonry];
    [self xl_setVerticalHuggingAndCompression];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.imgViewAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labName);
        make.left.equalTo(@0.f);
        make.bottom.lessThanOrEqualTo(@0.f);
        make.width.height.equalTo(@(kDJCommentProfileAvatarWidth));
    }];
    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0.f);
        make.left.equalTo(self.imgViewAvatar.mas_right).offset(10.f);
    }];
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labName.mas_bottom).offset(5.f);
        make.left.equalTo(self.labName);
        make.bottom.lessThanOrEqualTo(@0.f);
    }];
    [self.labDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labName);
        make.right.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UIImageView *)imgViewAvatar {
    if(!_imgViewAvatar){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        iv.layer.masksToBounds = YES;
        iv.layer.cornerRadius = kDJCommentProfileAvatarWidth / 2.f;
        _imgViewAvatar = iv;
    }
    return _imgViewAvatar;
}
- (UILabel *)labName {
    if(!_labName){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
        label.textColor = [UIColor colorWithHex:0x333333];
        // label.backgroundColor = [UIColor <#cyanColor#>];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labName = label;
    }
    return _labName;
}
- (UILabel *)labDate {
    if(!_labDate){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
        label.textColor = [UIColor colorWithHex:0x999999];
        // label.backgroundColor = [UIColor <#cyanColor#>];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labDate = label;
    }
    return _labDate;
}
- (LXDJCommentStarView *)starView {
    if(!_starView){
        LXDJCommentStarView *v = [[LXDJCommentStarView alloc]init];
        // v.backgroundColor = [UIColor <#whiteColor#>];
        _starView = v;
    }
    return _starView;
}

@end
