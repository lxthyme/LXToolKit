//
//  LXSectionHeaderTestView.m
//  LXToolKit_Exam
//
//  Created by lxthyme on 2021/10/12.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import "LXSectionHeaderTestView.h"
#import <Masonry/Masonry.h>

@interface LXSectionHeaderTestView() {
}
@property(nonatomic, strong)UILabel *labSearch;

@end

@implementation LXSectionHeaderTestView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self prepareUI];
    }
    return self;
}

#pragma mark -
#pragma mark - 👀Public Actions
- (void)changeType:(NSInteger)type {
    if(type == 2) {
        [self.labSearch mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0.f);
            make.height.equalTo(@20.f);
        }];
    } else {
        [self.labSearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0.f);
        }];
    }
}

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.labSearch];
    [self masonry];
}
- (void)masonry {
    [self.labSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark -
#pragma mark - 📌Property Lazy Load
- (UILabel *)labSearch {
    if(!_labSearch){
        _labSearch = [[UILabel alloc]init];
        [_labSearch setFrame:CGRectZero];
        [_labSearch setText:@"Search"];
        [_labSearch setNumberOfLines:0];
        [_labSearch setBackgroundColor:[UIColor cyanColor]];
    }
    return _labSearch;
}
@end
