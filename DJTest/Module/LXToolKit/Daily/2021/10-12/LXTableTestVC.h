//
//  LXTableTestVC.h
//  LXToolKit_Exam
//
//  Created by lxthyme on 2021/10/12.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXTableTestVC : UIViewController {
}

- (void)viewWillAppear:(BOOL)animated __attribute__((objc_requires_super));
- (void)viewDidAppear:(BOOL)animated __attribute__((objc_requires_super));
- (void)viewWillDisappear:(BOOL)animated __attribute__((objc_requires_super));
- (void)viewDidDisappear:(BOOL)animated NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
