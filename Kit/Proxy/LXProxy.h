//
//  LXProxy.h
//  Alamofire
//
//  Created by LXThyme Jason on 2020/8/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXProxy : NSProxy {

}
/** weak target */
@property(nonatomic,weak)id target;

- (instancetype)initWithTarget:(id)target;
+ (instancetype)weakProxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
