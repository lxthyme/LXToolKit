//
//  LXDJCommentPictureCell.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/11.
//
#import "LXDJCommentPictureCell.h"

#import <SDWebImage/SDWebImage.h>

@interface LXDJCommentPictureCell() {
}
@property(nonatomic, strong)UIImageView *imgViewLogo;

@end

@implementation LXDJCommentPictureCell
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
- (void)dataFill:(NSString *)urlString {
    [self.imgViewLogo sd_setImageWithURL:[NSURL URLWithString:urlString]
                        placeholderImage:[UIImage imageNamed:@"icon_search_placeholder"]
                               completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(error) {
            dlog(@"-->error: %@", error);
        }
    }];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor whiteColor];

    [self.contentView addSubview:self.imgViewLogo];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.imgViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
        make.width.height.equalTo(@(kLXDJCommentPictureCellWidth));
    }];
}

#pragma mark Lazy Property
- (UIImageView *)imgViewLogo {
    if(!_imgViewLogo){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.backgroundColor = [UIColor colorWithHex:0xD8D8D8];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        iv.layer.masksToBounds = YES;
        iv.layer.cornerRadius = 5.f;
        _imgViewLogo = iv;
    }
    return _imgViewLogo;
}

@end
