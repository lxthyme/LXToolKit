//
//  DJTagView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/5.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJTagView.h"

#import <DJBusinessTools/LXLabel.h>
#import <BLCategories/UIColor+Hex.h>

@interface DJTagView() {
}
@property(nonatomic, strong)UIImageView *imgViewLogo;
@property(nonatomic, strong)LXLabel *labTitle;

@end

@implementation DJTagView
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
- (void)dataFill:(DJGoodsPopinfosList *)popInfoItem {
    self.labTitle.attributedText = popInfoItem.f_textAttributeString;
    self.labTitle.layer.borderWidth = popInfoItem.f_borderWidth;
    self.labTitle.layer.borderColor = popInfoItem.f_borderColor.CGColor;
    self.labTitle.layer.cornerRadius = popInfoItem.f_cornerRadius;
    UIColor *bgColor = popInfoItem.f_backgroundColor;
    if(!bgColor) {
        bgColor = [UIColor whiteColor];
    }
    self.labTitle.backgroundColor = bgColor;
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
- (LXLabel *)labTitle {
    if(!_labTitle){
        LXLabel *label = [[LXLabel alloc]init];
        label.text = @"";
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.layer.borderWidth = 1.f;
        _labTitle = label;
    }
    return _labTitle;
}
@end
