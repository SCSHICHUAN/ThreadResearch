//
//  P_thread.m
//  ThreadResearch
//
//  Created by Stan on 2020/9/28.
//
#import <sys/time.h>
#import "P_thread.h"
#import <pthread.h>

typedef struct{
    const char  *name;//指针不便，指针的内容在变
    int   age;
    char  post;
}Args;

@implementation P_thread

int ext = 0;

void * run(void *param)    // 新线程调用方法，里边为需要执行的任务
{
    
    
    char str[512] = {};
    
    int i = 0;
    while (1) {
        
        snprintf(str, 512, "run..次数%d",i);
        
        printf("%s\n",str);
        sleep(1);
        i++;
        
        
        if (ext) {
           
            Args *args;
            args = (Args*)param;
            printf("name = %s\n",args->name);
            printf("age  = %d\n",args->age);
            printf("post  = %d\n",args->post);
            printf("thread地址 =  (%p) \n", &pthread_self()->__opaque);
            free(args);
            pthread_exit(NULL);
        }
    }
    
    
    
    return NULL;
}
pthread_t thread;
-(void)test
{
    
    Args *args = malloc(sizeof(Args));
    
    printf("Args = %lu\n",sizeof(Args));
    
    args->name = [self.str UTF8String];
    args->age = 32;
    args->post = 30;
    
    
    //创建线程
   
    /*
     第一个参数pthread_t *restrict:线程对象
     第二个参数const pthread_attr_t *restrict:线程属性
     第三个参数void *(*)(void *) :指向函数的指针
     第四个参数void *restrict:函数的参数
     */
    pthread_create(&thread, NULL, run, args);
    
    
}
-(void)destroy
{
    ext = 1;
}
@end
