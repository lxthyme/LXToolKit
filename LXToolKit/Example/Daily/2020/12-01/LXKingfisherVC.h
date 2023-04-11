//
//  LXKingfisherVC.h
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/12/3.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXKingfisherVC : UIViewController {
}

- (void)viewWillAppear:(BOOL)animated __attribute__((objc_requires_super));
- (void)viewDidAppear:(BOOL)animated __attribute__((objc_requires_super));
- (void)viewWillDisappear:(BOOL)animated __attribute__((objc_requires_super));
- (void)viewDidDisappear:(BOOL)animated NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
