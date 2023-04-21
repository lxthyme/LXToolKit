//
//  DJSearchHotRankListCell.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/4/18.
//
#import "DJSearchHotRankListCell.h"
#import <DJRSwiftResource/DJRSwiftResource-Swift.h>
#import <Masonry/Masonry.h>

@interface DJSearchHotRankListCell()<UITableViewDataSource, UITableViewDelegate> {
}
@property(nonatomic, strong)UIImageView *imgViewBg;
@property(nonatomic, strong)UITableView *table;
@property(nonatomic, copy)NSArray<NSString *> *dataList;
@end

@implementation DJSearchHotRankListCell
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
    self.imgViewBg.image = DJTest.icon_search_bg_hotRank;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self.contentView addSubview:self.imgViewBg];
    [self.contentView addSubview:self.table];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.imgViewBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kWPercentage(40.f), kWPercentage(10.f), kWPercentage(10.f), kWPercentage(10.f)));
    }];
}

#pragma mark Lazy Property
- (UIImageView *)imgViewBg {
    if(!_imgViewBg){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        // iv.image = [UIImage imageNamed:@""];
        _imgViewBg = iv;
    }
    return _imgViewBg;
}

- (UITableView *)table {
    if(!_table) {
        UITableView *t = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        t.tableHeaderView = [UIView new];
        t.tableFooterView = [UIView new];
        t.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        t.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        t.separatorStyle = UITableViewCellSeparatorStyleNone;
        t.estimatedRowHeight = 44.0f;
        t.rowHeight = UITableViewAutomaticDimension;
        t.sectionHeaderHeight = 0.f;
        t.sectionFooterHeight = 0.f;
        t.estimatedRowHeight = 0;
        t.estimatedSectionHeaderHeight = 0;
        t.estimatedSectionFooterHeight = 0;
        t.layer.cornerRadius = kWPercentage(13.f);
        t.clipsToBounds = YES;

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
