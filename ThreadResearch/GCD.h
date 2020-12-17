//
//  GCD.h
//  ThreadResearch
//
//  Created by Stan on 2020/12/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCD : NSObject
/*
  串行队列
 */
//同步
-(void)serial_sync;
//异步
-(void)serial_async;

/*
 并发队列
*/
//同步
-(void)concurrent_sync;
//异步
-(void)concurreng_async;
@end

NS_ASSUME_NONNULL_END
