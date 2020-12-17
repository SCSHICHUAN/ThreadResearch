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
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    P_thread *p;
    NSThread_loc *nsthread;
    GCD *gcd;
}
@property UITableView *table;
@property NSArray *titleArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = @[@"开始P_thread",@"结束P_thread",
                        @"开始NSThreas",@"NSThreas状态",
                        @"NSThreas cancel",@"GCD serial sync",
                        @"GCD serial async",@"GCD concurrent sync",
                        @"GCD concurrent async"];
    
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
    }
}
@end
