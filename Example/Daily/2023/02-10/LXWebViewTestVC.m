//
//  LXWebViewTestVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2023/2/10.
//  Copyright © 2023 lxthyme. All rights reserved.
//
#import "LXWebViewTestVC.h"

#import <Masonry/Masonry.h>
#import <WebKit/WebKit.h>

@interface LXWebViewTestVC()<WKNavigationDelegate, UIGestureRecognizerDelegate> {
}
@property(nonatomic, strong)WKWebView *webView;

@end

@implementation LXWebViewTestVC
- (void)dealloc {
    NSLog(@"🎷DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // NSLog(@"🛠viewWillAppear: %@", NSStringFromClass([self class]));
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    // NSLog(@"🛠viewDidAppear: %@", NSStringFromClass([self class]));
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    // NSLog(@"🛠viewWillDisappear: %@", NSStringFromClass([self class]));
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    // NSLog(@"🛠viewDidDisappear: %@", NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    [self prepareUI];
    [self dataFill];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill {
    NSString *urlString = @"";
    urlString = @"https://zhihu.com";
    urlString = @"https://juejin.cn/ios";
    urlString = @"https://www.google.com/search?q=233";
    urlString = @"https://promotion.bl.com/nc/APP_HDGL202302090000022065_22867.html?storeCode=012044&buid=2020&merchantId=20200120441&shopId=012044&bizId=2020&platform=iOS&bl_ad=6601_-_3744021_-_1&mId=e473cfd295d239cdbd91fbe5c29ce02f&market=AppStore&newversion=Y&newFrame=Y&isDJFlag=Y&tdType=1";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)swipeBack:(UIScreenEdgePanGestureRecognizer *)recognized {
    CGPoint point = [recognized translationInView:self.view];
    if(recognized.state == UIGestureRecognizerStateEnded) {
        CGFloat fraction = fabs(point.x / self.view.bounds.size.width);
        NSLog(@"-->fraction: %f", fraction);
        if(fraction >= 0.35) {
            [self backAction:nil];
        }
    }
}
- (void)backAction:(UIBarButtonItem *)item {
    NSLog(@"-->canGoBack: %@", [self.webView canGoBack] ? @"YES" : @"NO");
    if([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
    }
}

#pragma mark -
#pragma mark - ✈️WKNavigationDelegate
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    NSLog(@"-->1. didReceiveAuthenticationChallenge");
    // SecTrustRef trustRef = challenge.protectionSpace.serverTrust;
    // if(!trustRef) {
    //     completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    // }
    // completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, [NSURLCredential credentialForTrust:trustRef]);

    // if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
    if(challenge.protectionSpace.serverTrust) {
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"-->1. didStartProvisionalNavigation:");
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"-->2. didFinishNavigation:");
    [webView evaluateJavaScript:@"document.title" completionHandler:^(NSString * _Nullable title, NSError * _Nullable error) {
        if (title.length > 0) {
            self.title = title;
        }
        // [self.navigationView.rightButton setImage:[[iBLImage imageNamed:@"DJ_share_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"-->3. didFailNavigation:");
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"-->4. didFailProvisionalNavigation:");
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
    [self.view addSubview:self.webView];

    // UIScreenEdgePanGestureRecognizer *swipe = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(swipeBack:)];
    // swipe.edges = UIRectEdgeLeft;
    // swipe.delegate = self;
    // [self.view addGestureRecognizer:swipe];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.webView.allowsBackForwardNavigationGestures = YES;
    // self.navigationItem.hidesBackButton = YES;

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (WKWebView *)webView {
    if(!_webView){
        WKWebView *v = [[WKWebView alloc]init];
        v.navigationDelegate = self;
        _webView = v;
    }
    return _webView;
}

@end
