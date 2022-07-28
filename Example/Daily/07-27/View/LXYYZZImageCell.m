//
//  LXYYZZImageCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXYYZZImageCell.h"

#import <Masonry/Masonry.h>

@interface LXYYZZImageCell() {
}
@property(nonatomic, strong)UIImageView *imgViewLogo;

@end

@implementation LXYYZZImageCell
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
- (void)dataFill:(DJYYZZInfoModel *)item isLeft:(BOOL)isLeft {
    if(item.f_isPlaceholder) {
        self.imgViewLogo.image = nil;
        self.imgViewLogo.layer.borderWidth = 0.f;
    } else {
        self.imgViewLogo.layer.borderWidth = 1.f;
        
        NSString *url = [item.imageUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.imgViewLogo bl_setImageWithUrl:[NSURL URLWithString:url]];
    }
    if(isLeft) {
        [self.imgViewLogo mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(kWPercentage(15.f)));
            make.left.equalTo(@(kWPercentage(20.f)));
            make.right.equalTo(@(kWPercentage(-7.5f)));
            make.bottom.equalTo(@0.f);
        }];
    } else {
        [self.imgViewLogo mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(kWPercentage(15.f)));
            make.left.equalTo(@(kWPercentage(7.5f)));
            make.right.equalTo(@(kWPercentage(-20.f)));
            make.bottom.equalTo(@0.f);
        }];
    }
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor whiteColor];

    [self.contentView addSubview:self.imgViewLogo];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.imgViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UIImageView *)imgViewLogo {
    if(!_imgViewLogo){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.layer.borderColor = [UIColor colorWithHex:0xDDDDDD].CGColor;
        iv.layer.borderWidth = 1.f;
        iv.layer.cornerRadius = kWPercentage(4.f);
        // iv.image = [UIImage imageNamed:@""];
        _imgViewLogo = iv;
    }
    return _imgViewLogo;
}

@end
