//
//  OLGCDViewController.m
//  OLThread
//
//  Created by olive on 2017/4/16.
//  Copyright © 2017年 olive. All rights reserved.
//

#import "OLGCDViewController.h"

@interface OLGCDViewController ()

@end

@implementation OLGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self asyncConcurrent];
    
//    [self asyncSerial];
    
//    [self syncConcurrent];
    
//    [self syncSerial];
    
//    [self asyncMain];
    
    [self syncMain];
}


/**
 异步 并发 会开启线程
 */
- (void)asyncConcurrent {
    dispatch_queue_t queue = dispatch_queue_create("com.olive.asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"start--------");
    dispatch_async(queue, ^{
        NSLog(@"download01---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download02---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download03---%@", [NSThread currentThread]);
    });
    NSLog(@"end--------");
}

/**
 异步  开启一条线程，就串行
 */
- (void)asyncSerial {
    dispatch_queue_t queue = dispatch_queue_create("olive.syncSerial", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"download01------%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"download02------%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"download03------%@", [NSThread currentThread]);
    });
}

/**
  同步 不会开启线程，并行
 */
- (void)syncConcurrent {
//    dispatch_queue_t queue = dispatch_get_global_queue(long identifier, unsigned long flags)
    
    dispatch_queue_t queue = dispatch_queue_create("com.olive.syncConcurrent", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        NSLog(@"download01----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download02----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download03----%@", [NSThread currentThread]);
    });
}

/**
  同步 串行
 */
- (void)syncSerial {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(queue, ^{
        NSLog(@"download01----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download02----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download03----%@", [NSThread currentThread]);
    });
}


/**
 异步 + main函数
 */
- (void)asyncMain {
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        NSLog(@"download01-------%@", [NSThread currentThread]);
    });
    dispatch_async(mainQueue, ^{
        NSLog(@"download02-------%@", [NSThread currentThread]);
    });
    dispatch_async(mainQueue, ^{
        NSLog(@"download03-------%@", [NSThread currentThread]);
    });
}


/**
 同步 + main函数 死锁！
 */
- (void)syncMain {
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    NSLog(@"start========");
    dispatch_sync(mainQueue, ^{
        NSLog(@"download01-------%@", [NSThread currentThread]);
    });
    dispatch_sync(mainQueue, ^{
        NSLog(@"download02-------%@", [NSThread currentThread]);
    });
    dispatch_sync(mainQueue, ^{
        NSLog(@"download03-------%@", [NSThread currentThread]);
    });
    NSLog(@"end------");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
