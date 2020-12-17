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


//栅栏函数
-(void)barrier;
//延迟
-(void)after;
//执行一次的函数
-(void)once;
//快速迭代：开启多条线程，并发执行，相比于for循环在耗时操作中极大的提高效率和速度
-(void)apply;
//队列组（同栅栏函数）
-(void)group;
@end

NS_ASSUME_NONNULL_END
