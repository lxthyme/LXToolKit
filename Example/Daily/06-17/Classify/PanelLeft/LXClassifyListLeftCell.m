//
//  LXClassifyListLeftCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyListLeftCell.h"

#import <Masonry/Masonry.h>

@interface LXClassifyListLeftCell() {
}
@property(nonatomic, strong)UILabel *labTitle;

@end

@implementation LXClassifyListLeftCell
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self prepareUI];
    }
    return self;
}
- (void)prepareForReuse {
    [super prepareForReuse];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
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
    // self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor lightGrayColor];
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [UIColor redColor];
    self.selectedBackgroundView = v;

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
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentLeft;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
@end
