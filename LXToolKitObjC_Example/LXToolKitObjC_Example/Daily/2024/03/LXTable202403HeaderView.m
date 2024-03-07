//
//  LXTable202403HeaderView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2024/3/7.
//
#import "LXTable202403HeaderView.h"

#import <Masonry/Masonry.h>

@interface LXTable202403HeaderView() {
}
@property(nonatomic, strong)UILabel *labTitle;

@end

@implementation LXTable202403HeaderView
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
    self.contentView.backgroundColor = [[UIColor magentaColor] colorWithAlphaComponent:0.3];

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
        label.font = [UIFont systemFontOfSize:kWPercentage(20.f)];
        label.textColor = [UIColor blackColor];
        // label.backgroundColor = [UIColor <#cyanColor#>];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
@end
