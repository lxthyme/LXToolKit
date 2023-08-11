//
//  DJCommentCell.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/11.
//
#import "DJCommentCell.h"

#import <Masonry/Masonry.h>
#import <LXToolKitObjC/LXBaseStackView.h>

#import "DJCommentProfileView.h"
#import "DJCommentServiceAnswerView.h"

@interface DJCommentCell() {
}
@property(nonatomic, strong)LXBaseStackView *wrapperStackView;
@property(nonatomic, strong)DJCommentProfileView *profileView;
@property(nonatomic, strong)UITextView *tvContent;
@property(nonatomic, strong)DJCommentServiceAnswerView *serviceAnswerView;

@property(nonatomic, strong)UIView *lineView;

@end

@implementation DJCommentCell
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self prepareUI];
    }
    return self;
}
- (void)prepareForReuse {
    [super prepareForReuse];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill {
    [self.profileView dataFill];
    NSInteger random = arc4random_uniform(10);
    NSMutableString *text = [NSMutableString string];
    for (NSInteger i = 0; i < random + 3; i++) {
        [text appendString:@"挺好吃的，有嚼劲"];
    }
    self.tvContent.text = [text copy];

    [self.serviceAnswerView dataFill];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor whiteColor];

    [self.wrapperStackView addArrangedSubview:self.profileView];
    [self.wrapperStackView addArrangedSubview:self.tvContent];
    [self.wrapperStackView addArrangedSubview:self.serviceAnswerView];
    [self.contentView addSubview:self.wrapperStackView];
    [self.contentView addSubview:self.lineView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.wrapperStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(15.f, 15.f, 17.f, 15.f));
    }];
    [self.serviceAnswerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@38.f);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15.f);
        make.right.equalTo(@-15.f);
        make.bottom.equalTo(@0.f);
        make.height.equalTo(@(kFixed0_5));
    }];
}

#pragma mark Lazy Property
- (LXBaseStackView *)wrapperStackView {
    if(!_wrapperStackView){
        LXBaseStackView *sv = [[LXBaseStackView alloc]init];
        sv.axis = UILayoutConstraintAxisVertical;
        sv.alignment = UIStackViewAlignmentFill;
        // sv.distribution = UIStackViewDistributionFillProportionally;
        sv.spacing = 0.f;
        _wrapperStackView = sv;
    }
    return _wrapperStackView;
}
- (DJCommentProfileView *)profileView {
    if(!_profileView){
        DJCommentProfileView *v = [[DJCommentProfileView alloc]init];
        _profileView = v;
    }
    return _profileView;
}
- (UIView *)lineView {
    if(!_lineView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
        _lineView = v;
    }
    return _lineView;
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
        tv.textContainerInset = UIEdgeInsetsMake(13.f, -padding, 10.f, -padding);
        _tvContent = tv;
    }
    return _tvContent;
}
- (DJCommentServiceAnswerView *)serviceAnswerView {
    if(!_serviceAnswerView){
        DJCommentServiceAnswerView *v = [[DJCommentServiceAnswerView alloc]init];
        _serviceAnswerView = v;
    }
    return _serviceAnswerView;
}
@end
