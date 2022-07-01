//
//  LXFirstCategoryCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXFirstCategoryCell.h"

static const kCellWidth = 42.f;

@interface LXFirstCategoryCell() {
}
@property(nonatomic, strong)UIStackView *wrapperStackView;
@property(nonatomic, strong)UIImageView *imgViewLogo;
@property(nonatomic, strong)YYLabel *labTitle;

@end

@implementation LXFirstCategoryCell
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
    if(selected) {
        self.imgViewLogo.layer.borderColor = [UIColor colorWithHex:0xFF774F].CGColor;
        self.labTitle.backgroundColor = [UIColor colorWithHex:0xFF774F];
        self.labTitle.layer.cornerRadius = CGRectGetHeight(self.labTitle.frame) / 2.f;
    } else {
        self.imgViewLogo.layer.borderColor = [UIColor whiteColor].CGColor;
        self.labTitle.backgroundColor = [UIColor clearColor];
        self.labTitle.layer.cornerRadius = 0.f;
    }
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill {
    self.labTitle.text = @"title";
    [self.imgViewLogo bl_setImageWithUrl:[NSURL URLWithString:@"https://loremflickr.com/200/200?random=1"] placeholderImage:nil];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    [self.wrapperStackView addArrangedSubview:self.imgViewLogo];
    [self.wrapperStackView addArrangedSubview:self.labTitle];
    [self.contentView addSubview:self.wrapperStackView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.wrapperStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
    [self.imgViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(kCellWidth));
    }];
}

#pragma mark Lazy Property
- (UIStackView *)wrapperStackView {
    if(!_wrapperStackView){
        UIStackView *sv = [[UIStackView alloc]init];
        sv.axis = UILayoutConstraintAxisVertical;
        sv.spacing = 2.5f;
        sv.alignment = UIStackViewAlignmentCenter;
        _wrapperStackView = sv;
    }
    return _wrapperStackView;
}
- (UIImageView *)imgViewLogo {
    if(!_imgViewLogo){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        iv.backgroundColor = [UIColor lightGrayColor];
        iv.layer.borderColor = [UIColor whiteColor].CGColor;
        iv.layer.borderWidth = 2.f;
        iv.layer.cornerRadius = kCellWidth / 2.f;
        iv.clipsToBounds = YES;
        _imgViewLogo = iv;
    }
    return _imgViewLogo;
}
- (YYLabel *)labTitle {
    if(!_labTitle){
        YYLabel *label = [[YYLabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor blackColor];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.clipsToBounds = YES;
        // label.textContainerInset = UIEdgeInsetsMake(2, 5, 2, 5);
        _labTitle = label;
    }
    return _labTitle;
}
@end
