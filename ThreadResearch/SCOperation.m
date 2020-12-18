//
//  SCOperation.m
//  ThreadResearch
//
//  Created by Stan on 2020/12/18.
//

#import "SCOperation.h"

@implementation SCOperation
-(void)main
{
    [self actionOperation];
}

-(void)actionOperation
{
    int i = 0;
    while (1) {
        sleep(0.5);
        NSLog(@"operation %d %@",i++,[NSThread currentThread]);
        if (i == 5) {
            break;
        }
    }
}
@end
