//
//  GCD.m
//  ThreadResearch
//
//  Created by Stan on 2020/12/17.
//

#import "GCD.h"

@implementation GCD
/*
  串行队列  只在一个线程中执行
 */
//同步 GCD serial sync
-(void)serial_sync
{
    //串行队列
    dispatch_queue_t serial = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(serial, ^{
        NSLog(@"block 1 %@",[NSThread currentThread]);
    });
    dispatch_sync(serial, ^{
        sleep(2);
        NSLog(@"block 2 %@",[NSThread currentThread]);
    });
    dispatch_sync(serial, ^{
        NSLog(@"block 3 %@",[NSThread currentThread]);
    });
}
//异步 GCD serial async
-(void)serial_async
{
    //串行队列
    dispatch_queue_t serial = dispatch_queue_create("seraial", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(serial, ^{
        NSLog(@"block 1 %@",[NSThread currentThread]);
    });
    dispatch_async(serial, ^{
        sleep(2);
        NSLog(@"block 2 %@",[NSThread currentThread]);
    });
    dispatch_async(serial, ^{
        NSLog(@"block 3 %@",[NSThread currentThread]);
    });
    
    
}

/*
 并发队列 可能会在多个线程执行
*/
//同步 GCD concurrent sync
-(void)concurrent_sync
{
    //并发队列
    dispatch_queue_t concurrent = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(concurrent, ^{
        NSLog(@"block 1 %@",[NSThread currentThread]);
    });
    dispatch_sync(concurrent, ^{
        NSLog(@"block 2 %@",[NSThread currentThread]);
    });
    dispatch_sync(concurrent, ^{
        sleep(2);
        NSLog(@"block 3 %@",[NSThread currentThread]);
    });
    dispatch_sync(concurrent, ^{
        NSLog(@"block 4 %@",[NSThread currentThread]);
    });
    dispatch_sync(concurrent, ^{
        NSLog(@"block 5 %@",[NSThread currentThread]);
    });
    dispatch_sync(concurrent, ^{
        NSLog(@"block 6 %@",[NSThread currentThread]);
    });
   
}
//异步 GCD concurrent sync
-(void)concurreng_async
{
    //并发队列
    dispatch_queue_t concurrent = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(concurrent, ^{
        NSLog(@"block 1 %@",[NSThread currentThread]);
    });
    dispatch_async(concurrent, ^{
        NSLog(@"block 2 %@",[NSThread currentThread]);
    });
    dispatch_async(concurrent, ^{
        sleep(2);
        NSLog(@"block 3 %@",[NSThread currentThread]);
    });
    dispatch_async(concurrent, ^{
        NSLog(@"block 4 %@",[NSThread currentThread]);
    });
    dispatch_async(concurrent, ^{
        NSLog(@"block 5 %@",[NSThread currentThread]);
    });
    dispatch_async(concurrent, ^{
        NSLog(@"block 6 %@",[NSThread currentThread]);
    });
}

@end
