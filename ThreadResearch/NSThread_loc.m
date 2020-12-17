//
//  NSThread_loc.m
//  ThreadResearch
//
//  Created by Stan on 2020/12/17.
//

#import "NSThread_loc.h"
@interface NSThread_loc()
{
    NSThread *thread;
}
@end
@implementation NSThread_loc
-(void)test
{
    thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [thread start];
}
-(void)run
{
    int i = 0;
    while (1) {
        i++;
        NSLog(@"%d",i);
        sleep(1);
        if (i == 5) {
            break;
        }
    }
}

-(void)status
{
    NSLog(@"\n\n%@",[thread isExecuting] ? @"正在执行" : @"没有执行");
    NSLog(@"%@",[thread isFinished] ? @"完成" : @"未完成");
    NSLog(@"%@",[thread isCancelled] ? @"取消" : @"未取消");
}
-(void)cancel
{
    [thread cancel];
}
@end
