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
    [self prepareUI];
}

- (void)prepareUI {
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.labelRight];
}

- (void)masonry {
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100.f);
        make.left.greaterThanOrEqualTo(@16.f);
        make.height.equalTo(@44.f);
    }];
    [self.labelRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftView.mas_right).offset(30.f);
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
        _labelRight.text = @"233";
    }
    return _labelRight;
}
@end
