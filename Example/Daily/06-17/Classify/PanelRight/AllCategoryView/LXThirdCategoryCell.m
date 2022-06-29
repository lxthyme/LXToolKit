//
//  LXThirdCategoryCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/29.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXThirdCategoryCell.h"

@interface LXThirdCategoryCell() {
}
@property(nonatomic, strong)UILabel *labTitle;

@end

@implementation LXThirdCategoryCell
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
        self.labTitle.textColor = [UIColor colorWithHex:0xFF774F];
        self.contentView.backgroundColor = [UIColor colorWithHex:0xFF774F alpha:0.1];
    } else {
        self.labTitle.textColor = [UIColor colorWithHex:0x666666];
        self.contentView.backgroundColor = [UIColor colorWithHex:0xF6F6F6];
    }
}
#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(NSString *)title {
    self.labTitle.text = title;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor colorWithHex:0xF6F6F6];
    self.contentView.layer.cornerRadius = kWPercentage(4.f);
    self.contentView.clipsToBounds = YES;

    [self.contentView addSubview:self.labTitle];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:kWPercentage(12.f)];
        label.textColor = [UIColor colorWithHex:0x666666];
        label.backgroundColor = [UIColor colorWithHex:0xF6F6F6];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
@end
