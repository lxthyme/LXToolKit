//
//  LXHugTestVC.m
//  LXToolKit_Exam
//
//  Created by lxthyme on 2021/11/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import "LXHugTestVC.h"
#import <Masonry/Masonry.h>

@interface LXHugTestVC () {
}
@property(nonatomic, strong)UIView *leftView;
@property(nonatomic, strong)UILabel *labelRight;

@end

@implementation LXHugTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareUI];
}

- (void)prepareUI {
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.labelRight];

    [self masonry];
}

- (void)masonry {
    [self.leftView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.leftView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.labelRight setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.labelRight setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100.f);
        make.left.equalTo(@16.f);
        make.height.equalTo(@44.f);
    }];
    [self.labelRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftView.mas_right);
        make.right.equalTo(@(-15.f));
        make.centerY.equalTo(self.leftView);
    }];
}

- (UIView *)leftView {
    if(!_leftView){
        _leftView = [[UIView alloc]init];
        _leftView.backgroundColor = [UIColor magentaColor];
    }
    return _leftView;
}
- (UILabel *)labelRight {
    if(!_labelRight){
        _labelRight = [[UILabel alloc]init];
        _labelRight.text = @"233233233233";
        _labelRight.backgroundColor = [UIColor cyanColor];
    }
    return _labelRight;
}
@end
