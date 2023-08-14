//
//  DJCommentCell.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/11.
//
#import "DJCommentCell.h"

#import <Masonry/Masonry.h>
#import <LXToolKitObjC/LXBaseStackView.h>
#import "UICollectionViewLeftAlignedLayout.h"

#import "DJCommentProfileView.h"
#import "DJCommentServiceAnswerView.h"
#import "DJCommentAppendView.h"
#import "DJCommentUpVotedView.h"
#import "DJCommentPictureView.h"
#import "DJCommentTagCell.h"

@interface DJCommentCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
}
@property(nonatomic, strong)LXBaseStackView *wrapperStackView;
@property(nonatomic, strong)DJCommentProfileView *profileView;
@property(nonatomic, strong)UITextView *tvContent;
@property(nonatomic, strong)NSArray *tagList;
@property(nonatomic, strong)UICollectionView *tagCollectionView;
@property(nonatomic, strong)DJCommentServiceAnswerView *serviceAnswerView;
@property(nonatomic, strong)DJCommentAppendView *commentAppendView;
@property(nonatomic, strong)DJCommentUpVotedView *commentUpVotedView;
@property(nonatomic, strong)DJCommentPictureView *commentPictureView;

@property(nonatomic, strong)DJCommentTagCell *tagTestCell;

@property(nonatomic, strong)UIView *lineView;

@end

@implementation DJCommentCell
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self prepareUI];
        [self prepareCollectionView];
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
- (void)dataFill:(DJCommentType)type {
    [self.profileView dataFill];
    NSMutableString *text = [NSMutableString string];

    self.commentPictureView.hidden = YES;
    self.serviceAnswerView.hidden = YES;
    self.commentAppendView.hidden = YES;
    self.commentUpVotedView.hidden = YES;
    switch (type) {
        case DJCommentType0: {
        } break;
        case DJCommentType1: {
            self.commentPictureView.hidden = NO;
        } break;
        case DJCommentType2: {
            self.serviceAnswerView.hidden = NO;
        } break;
        case DJCommentType3: {
            self.commentAppendView.hidden = NO;
        } break;
        case DJCommentType4: {
            self.commentUpVotedView.hidden = NO;
        } break;
        case DJCommentType5: {
            self.commentPictureView.hidden = NO;
            self.serviceAnswerView.hidden = NO;
        } break;
        case DJCommentType7: {
            self.commentPictureView.hidden = NO;
            self.commentAppendView.hidden = NO;
        } break;
        case DJCommentType8: {
            self.commentPictureView.hidden = NO;
            self.commentUpVotedView.hidden = NO;
        } break;
        case DJCommentType9: {
            self.serviceAnswerView.hidden = NO;
            self.commentAppendView.hidden = NO;
        } break;
        case DJCommentType10: {
            self.serviceAnswerView.hidden = NO;
            self.commentUpVotedView.hidden = NO;
        } break;
        case DJCommentType11: {
            self.commentAppendView.hidden = NO;
            self.commentUpVotedView.hidden = NO;
        } break;
        case DJCommentType12: {
            self.commentPictureView.hidden = NO;
            self.serviceAnswerView.hidden = NO;
            self.commentAppendView.hidden = NO;
        } break;
        case DJCommentType13: {
            self.commentPictureView.hidden = NO;
            self.serviceAnswerView.hidden = NO;
            self.commentUpVotedView.hidden = NO;
        } break;
        case DJCommentType14: {
            self.commentPictureView.hidden = NO;
            self.commentAppendView.hidden = NO;
            self.commentUpVotedView.hidden = NO;
        } break;
        case DJCommentType15: {
            self.commentPictureView.hidden = NO;
            self.serviceAnswerView.hidden = NO;
            self.commentAppendView.hidden = NO;
            self.commentUpVotedView.hidden = NO;
        } break;
        case DJCommentType16: {
            self.tagCollectionView.hidden = YES;
            self.commentUpVotedView.hidden = NO;
        } break;
        case DJCommentType17: {
            self.tagCollectionView.hidden = YES;
            self.commentUpVotedView.hidden = NO;
        } break;
        case DJCommentType18: {
            self.tagCollectionView.hidden = YES;
            self.commentUpVotedView.hidden = NO;
        } break;

        default:
            break;
    }
    NSMutableArray *features = [NSMutableArray array];
    if(self.commentPictureView.hidden == NO) {
        [features addObject:@"图文"];
    }
    if(self.serviceAnswerView.hidden == NO) {
        [features addObject:@"客服回答"];
    }
    if(self.commentAppendView.hidden == NO) {
        [features addObject:@"追评"];
    }
    if(self.commentUpVotedView.hidden == NO) {
        [features addObject:@"点赞"];
    }
    [text appendString:[NSString stringWithFormat:@"[%@]", [features componentsJoinedByString:@" + "]]];
    if(type < 15) {
        NSInteger random = arc4random_uniform(10);
        for (NSInteger i = 0; i < random + 3; i++) {
            [text appendString:@"挺好吃的，有嚼劲"];
        }
    } else {
        [text appendString:@"好评!"];
    }
    self.tvContent.text = [text copy];

    self.tagList = @[
    @"包装很好",
    @"质量不错质量不错",
    @"值得推荐值得推荐值得推荐",
    ];
    [self.tagCollectionView reloadData];

    [self.serviceAnswerView dataFill];
    [self.commentAppendView dataFill];
    [self.commentUpVotedView dataFill];
    [self.commentPictureView dataFill];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)calcCommentTagWidth {
    // self.
}

#pragma mark - ✈️UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tagList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DJCommentTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DJCommentTagCell.xl_identifier forIndexPath:indexPath];
    NSString *title = self.tagList[indexPath.row];
    [cell dataFill:title];
    return cell;
}
#pragma mark -
#pragma mark - ✈️UICollectionViewDelegateFlowLayout

#pragma mark - ✈️UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareCollectionView {
    [self.tagCollectionView xl_registerForCell:[DJCommentTagCell class]];
}
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor whiteColor];

    [self.wrapperStackView addArrangedSubview:self.profileView];
    [self.wrapperStackView addArrangedSubview:self.tagCollectionView];
    [self.wrapperStackView addArrangedSubview:self.tvContent];
    [self.wrapperStackView addArrangedSubview:self.commentPictureView];
    [self.wrapperStackView addArrangedSubview:self.serviceAnswerView];
    [self.wrapperStackView addArrangedSubview:self.commentAppendView];
    [self.wrapperStackView addArrangedSubview:self.commentUpVotedView];
    [self.contentView addSubview:self.wrapperStackView];
    [self.contentView addSubview:self.lineView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.wrapperStackView, self.lineView,
                  self.profileView, self.tvContent,
                  self.commentPictureView, self.serviceAnswerView,
                  self.commentAppendView, self.commentUpVotedView)
    [self.wrapperStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(15.f, 15.f, 17.f, 15.f));
    }];
    [self.tagCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@33.f);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15.f);
        make.right.equalTo(@-15.f);
        make.bottom.equalTo(@0.f);
        make.height.equalTo(@(kFixed0_5));
    }];
}

#pragma mark Lazy Property
- (LXBaseStackView *)wrapperStackView {
    if(!_wrapperStackView){
        LXBaseStackView *sv = [[LXBaseStackView alloc]init];
        sv.axis = UILayoutConstraintAxisVertical;
        sv.alignment = UIStackViewAlignmentFill;
        // sv.distribution = UIStackViewDistributionFillProportionally;
        sv.spacing = 0.f;
        _wrapperStackView = sv;
    }
    return _wrapperStackView;
}
- (DJCommentProfileView *)profileView {
    if(!_profileView){
        DJCommentProfileView *v = [[DJCommentProfileView alloc]init];
        _profileView = v;
    }
    return _profileView;
}
- (UIView *)lineView {
    if(!_lineView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
        _lineView = v;
    }
    return _lineView;
}
- (UITextView *)tvContent {
    if(!_tvContent){
        UITextView *tv = [[UITextView alloc]init];
        tv.editable = NO;
        tv.scrollEnabled = NO;
        tv.textColor = [UIColor colorWithHex:0x666666];
        tv.font = [UIFont systemFontOfSize:15];
        tv.returnKeyType = UIReturnKeyDone;
        tv.keyboardType = UIKeyboardTypeDefault;
        tv.textAlignment = NSTextAlignmentLeft;
        tv.textContainer.maximumNumberOfLines = 0;
        tv.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
        tv.showsHorizontalScrollIndicator = NO;
        tv.showsVerticalScrollIndicator = NO;
        tv.contentInset = UIEdgeInsetsZero;
        CGFloat padding = tv.textContainer.lineFragmentPadding;
        tv.textContainerInset = UIEdgeInsetsMake(13.f, -padding, 0, -padding);
        _tvContent = tv;
    }
    return _tvContent;
}
- (UICollectionView *)tagCollectionView {
    if(!_tagCollectionView) {
        CGRect collectFrame = CGRectZero;
        // CGSize itemSize = CGSizeZero;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        // flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
        flowLayout.itemSize = CGSizeMake(60, 18);
        flowLayout.minimumLineSpacing = 10.f;
        flowLayout.minimumInteritemSpacing = 0.f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // flowLayout.sectionHeadersPinToVisibleBounds = YES;
        // flowLayout.sectionFootersPinToVisibleBounds = YES;
        // flowLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#HeaderSectionHeight#>);
        // flowLayout.footerReferenceSize = CGSizeMake(CGRectGetWidth(collectFrame), <#FooterSectionHeight#>);
        flowLayout.sectionInset = UIEdgeInsetsZero;

        UICollectionView *cv = [[UICollectionView alloc]initWithFrame:collectFrame collectionViewLayout:flowLayout];
        cv.backgroundColor = [UIColor whiteColor];
        cv.showsHorizontalScrollIndicator = NO;
        cv.showsVerticalScrollIndicator = NO;
        cv.contentInset = UIEdgeInsetsMake(13.f, 0.f, 2.f, 0);
        // cv.pagingEnabled = YES;

        cv.delegate = self;
        cv.dataSource = self;

        _tagCollectionView = cv;
    }
    return _tagCollectionView;
}
- (DJCommentServiceAnswerView *)serviceAnswerView {
    if(!_serviceAnswerView){
        DJCommentServiceAnswerView *v = [[DJCommentServiceAnswerView alloc]init];
        _serviceAnswerView = v;
    }
    return _serviceAnswerView;
}
- (DJCommentAppendView *)commentAppendView {
    if(!_commentAppendView){
        DJCommentAppendView *v = [[DJCommentAppendView alloc]init];
        _commentAppendView = v;
    }
    return _commentAppendView;
}
- (DJCommentUpVotedView *)commentUpVotedView {
    if(!_commentUpVotedView){
        DJCommentUpVotedView *v = [[DJCommentUpVotedView alloc]init];
        _commentUpVotedView = v;
    }
    return _commentUpVotedView;
}
- (DJCommentPictureView *)commentPictureView {
    if(!_commentPictureView){
        DJCommentPictureView *v = [[DJCommentPictureView alloc]init];
        _commentPictureView = v;
    }
    return _commentPictureView;
}
@end
