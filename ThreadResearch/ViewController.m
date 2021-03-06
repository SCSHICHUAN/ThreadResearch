//
//  ViewController.m
//  ThreadResearch
//
//  Created by Stan on 2020/9/28.
//

#import "ViewController.h"
#import "P_thread.h"
#import "NSThread_loc.h"
#import "GCD.h"
#import "NSOperation_loc.h"
#import "SCOperation.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    P_thread *p;
    NSThread_loc *nsthread;
    GCD *gcd;
    NSOperation_loc *operation;
}
@property UITableView *table;
@property NSArray *titleArray;
@end


/*
 dispatch_queut_t
 串行 并行 concurrent sercal
 同步 异步 sync async
 
 NSoperation
 串行 并行 addDependency 或者 maxConcurrentOPerationCount 来控制
 同步 异步 NSOperationQueue 控制
 */


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = @[@"开始P_thread",@"结束P_thread",
                        @"开始NSThreas",@"NSThreas状态",
                        @"NSThreas cancel",@"GCD serial sync",
                        @"GCD serial async",@"GCD concurrent sync",
                        @"GCD concurrent async",@"GCD 栅栏函数",@"GCD after 延迟函数",
                        @"GCD once 只执行一次",@"GCD 快速迭代",@"GCD group 队列组",@"operation invocation start",
    @"operation invocation cancel_loc",@"operation operation invocation cancel_loc_3",
    @"operation block sync",@"opercation block async",@"SCOpercation mainQueue",@"SCOpercation creat thread"];
    
    UITextField *filed = [[UITextField alloc] initWithFrame:CGRectMake(20, 44, 200, 44)];
    filed.backgroundColor = UIColor.grayColor;
    [self.view addSubview:filed];
    self.filed = filed;
    
    self.table = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.table.dataSource = self;
    self.table.delegate = self;
    [self.view addSubview:self.table];
    
    
    p = [[P_thread alloc] init];
    
    nsthread = [[NSThread_loc alloc] init];
    
    
    gcd = [[GCD alloc] init];
    
    operation = [[NSOperation_loc alloc] init];
    
    
}
#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = self.titleArray[indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    
    if (index == 0) {
        p.str = self.filed.text;
        [p test];
    }else if(index == 1){
        [p destroy];
    }else if(index == 2){
        
        [nsthread test];
    }else if(index == 3){
        [nsthread status];
    }else if(index == 4){
        [nsthread cancel];
    }else if(index == 5){
        [gcd serial_sync];
    }else if(index == 6){
        [gcd serial_async];
    }else if(index == 7){
        [gcd concurrent_sync];
    }else if(index == 8){
        [gcd concurreng_async];
    }else if(index == 9){
        [gcd barrier];
    }else if(index == 10){
        [gcd after];
    }else if(index == 11){
        [gcd once];
    }else if(index == 12){
        [gcd apply];
    }else if(index == 13){
        [gcd group];
    }else if(index == 14){
        [operation invocation];
    }else if(index == 15){
        [operation cancel_loc];
    }else if(index == 16){
        [operation cancel_loc_3];
    }else if(index == 17){
        [operation sync_operation];
    }else if(index == 18){
        [operation async_operation];
    }else if(index == 19){
        SCOperation *scoperation = [[SCOperation alloc] init];
        [scoperation start];
    }else if(index == 20){
        SCOperation *scoperation = [[SCOperation alloc] init];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue addOperation:scoperation];
        //监听一个任务完成
        scoperation.completionBlock = ^{
            NSLog(@"sc opercation well done!");
        };
    }
}
@end
