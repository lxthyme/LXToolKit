//
//  LX3rdCategoryCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/29.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LX3rdCategoryCell.h"

@interface LX3rdCategoryCell() {
}
@property(nonatomic, strong)UILabel *labTitle;

@end

@implementation LX3rdCategoryCell
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
    self.contentView.backgroundColor = self.bgColor;
    self.labTitle.textColor = self.textNormalColor;
    self.labTitle.font = self.textNormalFont;
    self.labTitle.backgroundColor = self.textBGNormalColor;
}
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    // Configure the view for the selected state
    [self toggleStyleBy:selected];
}
#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(NSString *)title {
    [self toggleStyleBy:self.isSelected];
    NSString *f_title = title;
    if(title.length >= 4) {
        f_title = [f_title substringWithRange:NSMakeRange(0, 4)];
    }
    self.labTitle.text = f_title;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)toggleStyleBy:(BOOL)selected {
    self.contentView.backgroundColor = self.bgColor;
    if(selected) {
        self.labTitle.textColor = self.textSelectedColor;
        self.labTitle.font = self.textSelectedFont;
        self.labTitle.backgroundColor = self.textBGSelectedColor;
    } else {
        self.labTitle.textColor = self.textNormalColor;
        self.labTitle.font = self.textNormalFont;
        self.labTitle.backgroundColor = self.textBGSelectedColor;
    }
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.clipsToBounds = YES;

    [self.contentView addSubview:self.labTitle];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.labTitle)
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark getter / setter
#pragma mark Lazy Property
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
@end
