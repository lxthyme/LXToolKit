//
//  LXDJSearchHotRankListCell.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/4/18.
//
#import "LXDJSearchHotRankListCell.h"
#import <DJRSwiftResource/DJRSwiftResource-Swift.h>
#import <Masonry/Masonry.h>

#import "LXDJSearchRankItemCell.h"

@interface LXDJSearchHotRankListCell()<UITableViewDataSource, UITableViewDelegate> {
}
@property(nonatomic, strong)UIImageView *imgViewBg;
@property(nonatomic, strong)UIImageView *imgViewLogo;
@property(nonatomic, strong)UIImageView *imgViewTitle;
@property(nonatomic, strong)UITableView *table;
@property(nonatomic, copy)NSArray<NSDictionary *> *dataList;
@end

@implementation LXDJSearchHotRankListCell
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
        [self prepareTableView];
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
- (void)dataFill:(NSArray *)list {
    UIImage *img = DJTest.icon_search_bg_hotRank;
    self.imgViewBg.image = [img stretchableImageWithLeftCapWidth:img.size.width / 2.f topCapHeight:img.size.height / 2.f];
    self.imgViewLogo.image = DJTest.icon_search_hot;
    self.imgViewTitle.image = DJTest.icon_search_rankTitle;
    self.dataList = list;
    [self.table reloadData];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXDJSearchRankItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXDJSearchRankItemCell" forIndexPath:indexPath];
    NSDictionary *item = self.dataList[indexPath.row];
    [cell dataFill:item];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareTableView {
    [self.table registerClass:[LXDJSearchRankItemCell class] forCellReuseIdentifier:@"LXDJSearchRankItemCell"];
}
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self.imgViewBg addSubview:self.imgViewLogo];
    [self.imgViewBg addSubview:self.imgViewTitle];
    [self.imgViewBg addSubview:self.table];
    [self.contentView addSubview:self.imgViewBg];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    [self setMas_key:@"LXDJSearchHotRankListCell"];
    [self.contentView setMas_key:@"LXDJSearchHotRankListCell.contentView"];
    MASAttachKeys(self.table, self.imgViewBg)
    [self.imgViewBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0.f);
        make.left.equalTo(@(kWPercentage(15.f)));
        make.right.equalTo(@(kWPercentage(-15.f)));
        make.width.equalTo(@(SCREEN_WIDTH - kWPercentage(15.f * 2)));
        // make.height.equalTo(@(kWPercentage(505.f)));
        // make.height.equalTo(@505.f);
    }];
    [self.imgViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kWPercentage(10.f)));
        make.centerY.equalTo(self.imgViewTitle);
    }];
    [self.imgViewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kWPercentage(13.f)));
        make.left.equalTo(self.imgViewLogo.mas_right).offset(kWPercentage(8.f));
    }];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kWPercentage(40.f), kWPercentage(10.f), kWPercentage(10.f), kWPercentage(10.f)));
    }];
}

#pragma mark Lazy Property
- (UIImageView *)imgViewBg {
    if(!_imgViewBg){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleToFill;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewBg = iv;
    }
    return _imgViewBg;
}
- (UIImageView *)imgViewLogo {
    if(!_imgViewLogo){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewLogo = iv;
    }
    return _imgViewLogo;
}
- (UIImageView *)imgViewTitle {
    if(!_imgViewTitle){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewTitle = iv;
    }
    return _imgViewTitle;
}

- (UITableView *)table {
    if(!_table) {
        UITableView *t = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        t.tableHeaderView = [UIView new];
        t.tableFooterView = [UIView new];
        t.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        t.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        t.separatorStyle = UITableViewCellSeparatorStyleNone;
        t.estimatedRowHeight = kWPercentage(75.f);
        t.rowHeight = kWPercentage(75.f);
        t.sectionHeaderHeight = 0.f;
        t.sectionFooterHeight = 0.f;
        t.contentInset = UIEdgeInsetsMake(kWPercentage(10.f), 0, 0, kWPercentage(10.f));
        t.estimatedRowHeight = 0;
        t.estimatedSectionHeaderHeight = 0;
        t.estimatedSectionFooterHeight = 0;
        t.layer.cornerRadius = kWPercentage(13.f);
        t.clipsToBounds = YES;
        t.scrollEnabled = NO;

        t.delegate = self;
        t.dataSource = self;

        if (@available(iOS 11.0, *)) {
            t.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if(@available(iOS 13.0, *)) {
            t.automaticallyAdjustsScrollIndicatorInsets = NO;
        }
        if(@available(iOS 15.0, *)) {
            t.sectionHeaderTopPadding = 0.f;
        }
        _table = t;
    }
    return _table;
}
@end
