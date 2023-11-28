//
//  LXNestCell.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import "LXNestCell.h"

#import <Masonry/Masonry.h>

@interface LXNestCell() {
}
@property(nonatomic, strong)UILabel *labTitle;

@end

@implementation LXNestCell
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
    self.contentView.backgroundColor = [UIColor whiteColor];

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
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor cyanColor];
        label.layer.cornerRadius = 8.f;
        label.clipsToBounds = YES;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
@end
