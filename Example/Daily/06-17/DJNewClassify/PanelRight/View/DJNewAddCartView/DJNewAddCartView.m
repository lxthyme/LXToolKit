//
//  DJNewAddCartView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/5.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJNewAddCartView.h"

#import <DJBusinessTools/LXLabel.h>
#import "DJClassifyMacro.h"

@interface DJNewAddCartView() {
}
@property(nonatomic, strong)UIImageView *imgViewLogo;
@property(nonatomic, strong)LXLabel *labNum;

@end

@implementation DJNewAddCartView
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
- (void)dataFill:(NSInteger)num {
    self.labNum.text = [NSString stringWithFormat:@"%ld", num];
    self.labNum.hidden = !(num > 0);
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.imgViewLogo];
    [self addSubview:self.labNum];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.imgViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kAddCartTopHeight));
        make.left.bottom.equalTo(@0.f);
        make.right.equalTo(@(kWPercentage(-5.f)));
        make.width.height.equalTo(@(kAddCartLogoHeight));
    }];
    [self.labNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(@0.f);
        make.width.greaterThanOrEqualTo(@(kAddCartNumHeight));
        make.height.equalTo(@(kAddCartNumHeight));
    }];
}

#pragma mark Lazy Property
- (UIImageView *)imgViewLogo {
    if(!_imgViewLogo){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [iBLImage imageNamed:@"icon_addCart"];
        _imgViewLogo = iv;
    }
    return _imgViewLogo;
}
- (LXLabel *)labNum {
    if(!_labNum){
        LXLabel *label = [[LXLabel alloc]init];
        label.x_insets = UIEdgeInsetsMake(0, kWPercentage(4.5f), 0, kWPercentage(4.5f));
        label.text = @"";
        label.font = [UIFont boldSystemFontOfSize:kWPercentage(9.f)];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor colorWithHex:0xFF774F];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.layer.cornerRadius = kAddCartNumHeight / 2.f;
        label.layer.borderColor = [UIColor whiteColor].CGColor;
        label.layer.borderWidth = 1.f;
        label.clipsToBounds = YES;
        _labNum = label;
    }
    return _labNum;
}

@end
