//
//  LXButton.m
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/5/27.
//

#import "LXButton.h"
#import <Masonry/Masonry.h>

@interface LXButton() {
    NSString *__btnTitle;
}
@property(nonatomic, strong)UIActivityIndicatorView *indicatorView;

@end

@implementation LXButton
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
#pragma mark - 👀Public Actions
- (void)startLoading {
    __btnTitle = [self titleForState:UIControlStateNormal];
    [self setTitle:@"" forState:UIControlStateNormal];

    [self.indicatorView startAnimating];
}
- (void)stopLoading {
    [self setTitle:__btnTitle forState:UIControlStateNormal];

    [self.indicatorView stopAnimating];
}

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.indicatorView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UIActivityIndicatorView *)indicatorView {
    if(!_indicatorView){
        UIActivityIndicatorView *v = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        _indicatorView = v;
    }
    return _indicatorView;
}
@end
