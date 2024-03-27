//
//  DJQuickHomeVC.m
//  DJTest
//
//  Created by lxthyme on 2024/1/31.
//
#import "DJQuickHomeVC.h"

#import "DJModuleClassifyO2OCell.h"

#define kDJClassifyModuleSection 2

@interface DJClassifyQuicklyListLeftMainTableView : UITableView<UIGestureRecognizerDelegate> {
}
@end
@implementation DJClassifyQuicklyListLeftMainTableView
// - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//     return YES;
// }
// - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//     return YES;
// }
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}
@end

@interface DJQuickHomeVC()<UITableViewDelegate, UITableViewDataSource> {
}
@property(nonatomic, strong)DJClassifyQuicklyListLeftMainTableView *table;
@property(nonatomic, strong)DJModuleClassifyO2OCell *classifyView;

@end

@implementation DJQuickHomeVC
- (void)dealloc {
    NSLog(@"🎷DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    [self prepareUI];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kDJClassifyModuleSection + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == kDJClassifyModuleSection) {
        return 1;
    }
    if(section == 0) {
        return 2;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == kDJClassifyModuleSection) {
        DJJSCateSlideModel *quicklyModel = [[DJJSCateSlideModel alloc]init];
        quicklyModel.resourceId = @"20221114";
        [self.classifyView dataFill:quicklyModel];
        return self.classifyView;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.xl_identifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Custom cell:%ld-%ld", indexPath.section, indexPath.row];
    if(indexPath.section == 0) {
        cell.textLabel.textColor = [UIColor redColor];
    } else {
        cell.textLabel.textColor = [UIColor blueColor];
    }
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == kDJClassifyModuleSection) {
        return SCREEN_HEIGHT;
    }
    if(indexPath.section == 0) {
        return 70;
    }
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// - (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//     CGFloat offsetY = scrollView.contentOffset.y;
//     CGFloat fitOffsetY = scrollView.contentSize.height - SCREEN_HEIGHT;
//     NSLog(@"-->offsetY[%f]: %f", fitOffsetY, offsetY);
//     if(offsetY >= fitOffsetY) {
//         CGPoint offset = CGPointMake(0, fitOffsetY);
//         scrollView.contentOffset = offset;
//     }
// }

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    // navigationItem.title = @"";

    [self.view addSubview:self.table];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (DJClassifyQuicklyListLeftMainTableView *)table {
    if(!_table) {
        DJClassifyQuicklyListLeftMainTableView *t = [[DJClassifyQuicklyListLeftMainTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        t.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        t.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        // t.backgroundColor = [UIColor <#whiteColor#>];
        t.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        t.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        t.separatorStyle = UITableViewCellSeparatorStyleNone;
        t.estimatedRowHeight = UITableViewAutomaticDimension;
        t.rowHeight = 44.f;
        t.sectionHeaderHeight = 0.f;
        t.sectionFooterHeight = 0.f;
        t.estimatedSectionHeaderHeight = 0;
        t.estimatedSectionFooterHeight = 0;
        t.showsHorizontalScrollIndicator = NO;
        t.showsVerticalScrollIndicator = NO;

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

        [t xl_registerForCell:[DJModuleClassifyO2OCell class]];
        [t xl_registerForCell:[UITableViewCell class]];

        _table = t;
    }
    return _table;
}
- (DJModuleClassifyO2OCell *)classifyView {
    if(!_classifyView){
        WEAKSELF(self)
        DJModuleClassifyO2OCell *v = [[DJModuleClassifyO2OCell alloc]init];
        v.classifyO2OVC.scrollToTopBlock = ^{
            if([weakSelf.table numberOfSections] > kDJClassifyModuleSection &&
               [weakSelf.table numberOfRowsInSection:kDJClassifyModuleSection] > 0) {
                [weakSelf.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:kDJClassifyModuleSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        };
        _classifyView = v;
    }
    return _classifyView;
}
@end
