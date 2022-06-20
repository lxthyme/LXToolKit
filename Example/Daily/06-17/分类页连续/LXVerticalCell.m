//
//  LXVerticalCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/20.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXVerticalCell.h"

#import "LXClassifyListVC.h"

@interface LXVerticalCell() {
}
@property(nonatomic, strong)LXClassifyListVC *classifyListVC;

@end

@implementation LXVerticalCell
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
- (void)dataFill {
    [self.classifyListVC viewDidLoad];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor whiteColor];

    [self.contentView addSubview:self.classifyListVC.view];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.classifyListVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (LXClassifyListVC *)classifyListVC {
    if(!_classifyListVC){
        LXClassifyListVC *v = [[LXClassifyListVC alloc]init];
        _classifyListVC = v;
    }
    return _classifyListVC;
}
@end
