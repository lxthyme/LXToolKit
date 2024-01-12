//
//  LXDJCommentTagCell.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/12.
//
#import "LXDJCommentTagCell.h"

#define kDJTagContentInsets UIEdgeInsetsMake(2.f, 5.f, 2.f, 5.f)

@interface LXDJCommentTagCell() {
}
@property(nonatomic, strong)UILabel *labTitle;

@end

@implementation LXDJCommentTagCell
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
- (void)dataFill:(NSString *)title {
    self.labTitle.text = title;
}

#pragma mark -
#pragma mark - 👀Public Actions
- (CGFloat)calcCellWidth {
    CGFloat w = 0.f;
    CGSize size = [self.labTitle textRectForBounds:CGRectMake(0, 0, CGFLOAT_MAX, 18.f)
                            limitedToNumberOfLines:0].size;
    w += ceilf(size.width);
    w += kDJTagContentInsets.left + kDJTagContentInsets.right;
    return w;
}

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [[UIColor colorWithHex:0xFF4515] colorWithAlphaComponent:0.05f];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 4.f;

    [self.contentView addSubview:self.labTitle];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(kDJTagContentInsets);
    }];
}

#pragma mark Lazy Property
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:kWPercentage(11.f)];
        label.textColor = [UIColor colorWithHex:0xFF4515];
        // label.backgroundColor = [UIColor <#whiteColor#>];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
@end
