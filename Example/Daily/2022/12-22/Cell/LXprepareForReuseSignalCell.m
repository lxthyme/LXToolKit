//
//  LXprepareForReuseSignalCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/12/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXprepareForReuseSignalCell.h"

#import <Masonry/Masonry.h>

@interface LXprepareForReuseSignalCell() {
}
@property(nonatomic, strong)UIButton *btn;

@end

@implementation LXprepareForReuseSignalCell
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self prepareUI];
        [self prepareVM];
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
    [self.btn setTitle:[NSString stringWithFormat:@"Tap %@", title] forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareVM {
    @weakify(self)
    [[[[[[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside]
          throttle:0.3]
         takeUntil:self.rac_prepareForReuseSignal]
    //     doNext:^(UIButton *x) {
    //     NSLog(@"-->doNext: %@", x.currentTitle);
    // }]
       doError:^(NSError *error) {
        NSLog(@"-->doError: %@", error);
    }]
      doCompleted:^{
        @strongify(self)
        NSLog(@"-->doCompleted: %@", self.btn.currentTitle);
    }]
     subscribeNext:^(UIButton *x) {
        NSLog(@"Tapped: %@", x.currentTitle);
    }];
}
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor whiteColor];

    [self.contentView addSubview:self.btn];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 50));
        make.center.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UIButton *)btn {
    if(!_btn){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor lightGrayColor];

        [btn setTitle:@"Tap" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        _btn = btn;
    }
    return _btn;
}
@end
