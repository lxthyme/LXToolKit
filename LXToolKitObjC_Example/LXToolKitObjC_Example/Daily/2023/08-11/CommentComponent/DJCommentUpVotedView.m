//
//  DJCommentUpVotedView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/11.
//
#import "DJCommentUpVotedView.h"

#import <Masonry/Masonry.h>

@interface DJCommentUpVotedView() {
}
@property(nonatomic, strong)UIImageView *imgViewVoted;
@property(nonatomic, strong)UILabel *labCount;

@end

@implementation DJCommentUpVotedView
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
    NSInteger random = arc4random_uniform(10000);
    self.imgViewVoted.image = [UIImage imageNamed:random % 2 == 0 ? @"icon_not_upvoted" : @"icon_upvoted"];
    self.labCount.text = [@(random) stringValue];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.imgViewVoted];
    [self addSubview:self.labCount];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.imgViewVoted mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labCount);
    }];
    [self.labCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15.f);
        make.bottom.right.equalTo(@0.f);
        make.left.equalTo(self.imgViewVoted.mas_right).offset(7.f);
    }];
}

#pragma mark Lazy Property
- (UIImageView *)imgViewVoted {
    if(!_imgViewVoted){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewVoted = iv;
    }
    return _imgViewVoted;
}
- (UILabel *)labCount {
    if(!_labCount){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont boldSystemFontOfSize:kWPercentage(13.f)];
        label.textColor = [UIColor colorWithHex:0x333333];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labCount = label;
    }
    return _labCount;
}

@end
