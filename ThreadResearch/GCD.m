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


//栅栏函数
-(void)barrier
{
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
    
    //栅栏函数之前的执行完毕之后，执行栅栏函数，然后在执行栅栏函数之后的
    dispatch_barrier_async(concurrent, ^{
        NSLog(@"我是一个栅栏函数");
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
//延迟
-(void)after
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"after  %@",[NSThread currentThread]);
    });
}
//执行一次的函数
-(void)once;
{
    //onceToken用来记录该部分的代码是否被执行过
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"我只执行一次");
    });
}

//快速迭代：开启多条线程，并发执行，相比于for循环在耗时操作中极大的提高效率和速度
-(void)apply
{
    dispatch_apply(10, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSLog(@"%zu",index);
    });
}

//队列组（同栅栏函数）
-(void)group
{
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    // 创建并行队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // 执行队列组任务
    dispatch_group_async(group, queue, ^{
        sleep(2);
        NSLog(@"下载照片一");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"下载照片二");
    });
    
    
    //队列组中的任务执行完毕之后，执行该函数
    dispatch_group_notify(group, queue, ^{
        NSLog(@"队列组任务完成 把照片一和照片二合成一张照片");
    });
}

@end
