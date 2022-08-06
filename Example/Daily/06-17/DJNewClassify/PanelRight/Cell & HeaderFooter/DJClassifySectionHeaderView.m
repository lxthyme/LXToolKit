//
//  DJClassifySectionHeaderView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJClassifySectionHeaderView.h"

#import <DJBusinessTools/LXLabel.h>

@interface DJClassifySectionHeaderView() {
}
@property(nonatomic, strong)LXLabel *labTitle;

@end

@implementation DJClassifySectionHeaderView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
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
- (void)dataFill:(DJClassifyBaseCategoryModel *)model {
    self.labTitle.text = model.categoryName;
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
        make.edges.equalTo(self).inset(kWPercentage(10.f));
    }];
}

#pragma mark Lazy Property
- (LXLabel *)labTitle {
    if(!_labTitle){
        LXLabel *label = [[LXLabel alloc]init];
        label.x_insets = UIEdgeInsetsMake(0, kWPercentage(10.f), 0, 0);
        label.text = @"";
        label.font = [UIFont systemFontOfSize:12.f];
        label.backgroundColor = [UIColor colorWithHex:0xF6F6F6];
        label.textColor = [UIColor colorWithHex:0x666666];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentLeft;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.layer.cornerRadius = kWPercentage(4.f);
        label.clipsToBounds = YES;
        _labTitle = label;
    }
    return _labTitle;
}
@end
