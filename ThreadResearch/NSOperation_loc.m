//
//  NSOperation_loc.m
//  ThreadResearch
//
//  Created by Stan on 2020/12/18.
//

/*
 NSOperation 是苹果公司对 GCD 的封装，完全面向对象，
 并比GCD多了一些更简单实用的功能，所以使用起来更加方便易于理解。
 NSOperation 和NSOperationQueue 分别对应 GCD 的 任务 和 队列。

 NSOperation和NSOperationQueue实现多线程的具体步骤
 1.将需要执行的操作封装到一个NSOperation对象中
 2.将NSOperation对象添加到NSOperationQueue中
 系统会自动将NSOperationQueue中的NSOperation取出来，
 并将取出的NSOperation封装的操作放到一条新线程中执行
 */

#import "NSOperation_loc.h"
#import "AppDelegate.h"

@interface NSOperation_loc()
{
    NSOperationQueue *queue;
    NSInvocationOperation *invocation_3_operation;
}
@end
@implementation NSOperation_loc
-(void)invocation
{
    if (!queue) {
        queue = [[NSOperationQueue alloc] init]; //创建线程
//        queue = [NSOperationQueue mainQueue];//主线程
    }
    
    NSInvocationOperation *invocation_0_operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(actionOperation) object:nil];
    invocation_0_operation.name = @"invocation_0_operation";
    
    NSInvocationOperation *invocation_1_operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(actionOperation) object:nil];
    invocation_1_operation.name = @"invocation_1_operation";
    
    NSInvocationOperation *invocation_2_operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(actionOperation) object:nil];
    invocation_2_operation.name = @"invocation_2_operation";
    
    invocation_3_operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(actionOperation) object:nil];
    invocation_3_operation.name = @"invocation_3_operation";
    
    NSInvocationOperation *invocation_4_operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(actionOperation) object:nil];
    invocation_4_operation.name = @"invocation_4_operation";
    
    NSInvocationOperation *invocation_5_operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(actionOperation) object:nil];
    invocation_5_operation.name = @"invocation_5_operation";
    
    
    [invocation_0_operation addDependency:invocation_1_operation];
    [invocation_1_operation addDependency:invocation_2_operation];
    [invocation_2_operation addDependency:invocation_3_operation];
    [invocation_3_operation addDependency:invocation_4_operation];
    [invocation_4_operation addDependency:invocation_5_operation];
    
    //虽然是串行 但不一定在一个线程中执行
    [queue addOperation:invocation_0_operation];
    [queue addOperation:invocation_1_operation];
    [queue addOperation:invocation_2_operation];
    [queue addOperation:invocation_3_operation];
    [queue addOperation:invocation_4_operation];
    [queue addOperation:invocation_5_operation];
   
   
   

//    [invocation start];//main queue 中执行
}
-(void)actionOperation
{
    
    NSLog(@"\n operation count = %lu",queue.operationCount);
    
    NSArray *invocations = queue.operations;
    [invocations enumerateObjectsUsingBlock:^(NSInvocationOperation *invocation, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@  %@",invocation.name,invocation.isExecuting ? @"isExecuting YES" : @"isExecuting NO");
    }];
   
    
    
    int i = 0;
    while (1) {
        sleep(0.5);
        NSLog(@"operation %d %@",i++,[NSThread currentThread]);
        if (i == 5) {
            break;
        }
    }
}
-(void)cancel_loc
{
    /*
     正在执行的无法cancel cancel 后无法在开启
     如果想在开启 用 suspended 如果正在执行也是无法暂停
     */
    [queue cancelAllOperations];
}
-(void)cancel_loc_3
{
    //如果invocation_3没有执行 就会被cancel调 其他的不受影响
    [invocation_3_operation cancel];
}

-(void)brockOperation
{
    
    NSBlockOperation *block_0_operation = [NSBlockOperation blockOperationWithBlock:^{
        [self actionOperation];
    }];
    block_0_operation.name = @"block_0_operation";
    
    NSBlockOperation *block_1_operation = [NSBlockOperation blockOperationWithBlock:^{
        [self actionOperation];
    }];
    block_1_operation.name = @"block_1_operation";
    
    NSBlockOperation *block_2_operation = [NSBlockOperation blockOperationWithBlock:^{
        [self actionOperation];
    }];
    block_2_operation.name = @"block_2_operation";
    
    NSBlockOperation *block_3_operation = [NSBlockOperation blockOperationWithBlock:^{
        [self actionOperation];
    }];
    block_3_operation.name = @"block_3_operation";
    
    NSBlockOperation *block_4_operation = [NSBlockOperation blockOperationWithBlock:^{
        [self actionOperation];
    }];
    block_4_operation.name = @"block_4_operation";
    
    NSBlockOperation *block_5_operation = [NSBlockOperation blockOperationWithBlock:^{
        [self actionOperation];
    }];
    block_5_operation.name = @"block_5_operation";
    
    
    [queue addOperation:block_0_operation];
    [queue addOperation:block_1_operation];
    [queue addOperation:block_2_operation];
    [queue addOperation:block_3_operation];
    [queue addOperation:block_4_operation];
    [queue addOperation:block_5_operation];
    
}

-(void)sync_operation
{
    if (!queue) {
        queue = [[NSOperationQueue alloc] init];
    }
    //设置最大只在一个线程中执行 不是同一个线程
    queue.maxConcurrentOperationCount = 1;
    [self brockOperation];
}
-(void)async_operation
{
    if (!queue) {
        queue = [[NSOperationQueue alloc] init];
    }
    
    queue.maxConcurrentOperationCount = 6;
    [self brockOperation];
}
@end
