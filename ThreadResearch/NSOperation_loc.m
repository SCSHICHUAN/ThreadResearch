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
    NSInvocationOperation *invocation_3;
}
@end
@implementation NSOperation_loc
-(void)invocation
{
    if (!queue) {
        queue = [[NSOperationQueue alloc] init];
    }
    
    NSInvocationOperation *invocation_0 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocate) object:nil];
    invocation_0.name = @"invocation_0";
    
    NSInvocationOperation *invocation_1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocate) object:nil];
    invocation_1.name = @"invocation_1";
    
    NSInvocationOperation *invocation_2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocate) object:nil];
    invocation_2.name = @"invocation_2";
    
    invocation_3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocate) object:nil];
    invocation_3.name = @"invocation_3";
    
    NSInvocationOperation *invocation_4 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocate) object:nil];
    invocation_4.name = @"invocation_4";
    
    NSInvocationOperation *invocation_5 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocate) object:nil];
    invocation_5.name = @"invocation_5";
    
    
    [invocation_0 addDependency:invocation_1];
    [invocation_1 addDependency:invocation_2];
    [invocation_2 addDependency:invocation_3];
    [invocation_3 addDependency:invocation_4];
    [invocation_4 addDependency:invocation_5];
    
    //虽然是串行 但不一定在一个线程中执行
    [queue addOperation:invocation_0];
    [queue addOperation:invocation_1];
    [queue addOperation:invocation_2];
    [queue addOperation:invocation_3];
    [queue addOperation:invocation_4];
    [queue addOperation:invocation_5];
   
   
   

//    [invocation start];//main queue 中执行
}
-(void)invocate
{
    
    NSLog(@"\n operation count = %lu",queue.operationCount);
    
    NSArray *invocations = queue.operations;
    [invocations enumerateObjectsUsingBlock:^(NSInvocationOperation *invocation, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@  %@",invocation.name,invocation.isExecuting ? @"isExecuting YES" : @"isExecuting NO");
    }];
   
    
    
    int i = 0;
    while (1) {
        sleep(1);
        NSLog(@"invocation %d %@",i++,[NSThread currentThread]);
        if (i == 5) {
            break;
        }
    }
}
-(void)cancel_loc
{
    //正在执行的无法calcel
    [queue cancelAllOperations];
}
-(void)cancel_loc_3
{
    //如果invocation_3没有执行 就会被cancel调 其他的不受影响
    [invocation_3 cancel];
}
@end
