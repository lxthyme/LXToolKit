//
//  LXDJCommentAppendView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/11.
//
#import "LXDJCommentAppendView.h"

#import <Masonry/Masonry.h>

@interface LXDJCommentAppendView() {
}
@property(nonatomic, strong)UILabel *labTitle;
@property(nonatomic, strong)UITextView *tvContent;

@end

@implementation LXDJCommentAppendView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self prepareUI];
    }
    return self;
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill {
    self.labTitle.text = @"20天后追加的评论：";
    NSInteger random = arc4random_uniform(3);
    NSMutableString *text = [NSMutableString string];
    for (NSInteger i = 0; i < random + 1; i++) {
        [text appendString:@"又解冻了2块牛排，以为冻了一段时间后，口感会有所打折，结果煎完依然很美味，很嫩，汁水很足！"];
    }
    self.tvContent.text = [text copy];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.labTitle];
    [self addSubview:self.tvContent];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15.f);
        make.left.equalTo(@0.f);
    }];
    [self.tvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(10.f);
        make.left.right.bottom.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:kWPercentage(13.f)];
        label.textColor = [UIColor colorWithHex:0x999999];
        // label.backgroundColor = [UIColor <#cyanColor#>];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
- (UITextView *)tvContent {
    if(!_tvContent){
        UITextView *tv = [[UITextView alloc]init];
        tv.editable = NO;
        tv.scrollEnabled = NO;
        tv.textColor = [UIColor colorWithHex:0x666666];
        tv.font = [UIFont systemFontOfSize:15];
        tv.returnKeyType = UIReturnKeyDone;
        tv.keyboardType = UIKeyboardTypeDefault;
        tv.textAlignment = NSTextAlignmentLeft;
        tv.textContainer.maximumNumberOfLines = 0;
        tv.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
        tv.showsHorizontalScrollIndicator = NO;
        tv.showsVerticalScrollIndicator = NO;
        tv.contentInset = UIEdgeInsetsZero;
        CGFloat padding = tv.textContainer.lineFragmentPadding;
        tv.textContainerInset = UIEdgeInsetsMake(0, -padding, 0, -padding);
        _tvContent = tv;
    }
    return _tvContent;
}
@end
