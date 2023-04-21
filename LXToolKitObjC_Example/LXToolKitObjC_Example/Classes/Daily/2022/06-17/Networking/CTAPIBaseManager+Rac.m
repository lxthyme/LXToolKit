//
//  CTAPIBaseManager+Rac.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/5/25.
//  Copyright © 2022 lxthyme. All rights reserved.
//
// #import "CTAPIBaseManager+Rac.h"
//
// @implementation CTAPIBaseManager (Rac)
//
// #pragma mark -
// #pragma mark - 👀Public Actions
// - (RACSignal *)rac_requestSignal {
//     @weakify(self);
//     RACSignal *signal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//         @strongify(self);
//         NSInteger taskIdentifier = [self loadDataWithParams:self.finalParamsToCall success:^(CTAPIBaseManager * _Nonnull apiManager) {
//             [subscriber sendNext:apiManager];
//             [subscriber sendCompleted];
//         } fail:^(CTAPIBaseManager * _Nonnull apiManager) {
//             NSError *error = [NSError errorWithDomain:@"0" code:-1 userInfo:@{
//                 @"content": apiManager.response.content,
//                 @"errorMessage": apiManager.errorMessage,
//             }];
//             [subscriber sendError:error];
//             [subscriber sendCompleted];
//         }];
//         return [RACDisposable disposableWithBlock:^{
//             @strongify(self);
//             [self cancelRequestWithRequestId:taskIdentifier];
//         }];
//     }] takeUntil:[self rac_willDeallocSignal]];
// #if DEBUG
//     // TODO: 「lxthyme」💊
//     // [signal setNameWithFormat:@"rac-%@", RACDescription(self)];
// #endif
//     return signal;
// }
//
// @end
