//
//  CTAPIBaseManager+Rac.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/5/25.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import <BLNetworking/CTAPIBaseManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTAPIBaseManager (Rac)

- (RACSignal *)rac_requestSignal;

@end

NS_ASSUME_NONNULL_END
