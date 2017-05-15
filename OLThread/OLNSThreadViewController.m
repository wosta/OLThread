
//
//  OLNSThreadViewController.m
//  OLThread
//
//  Created by olive on 2017/4/16.
//  Copyright © 2017年 olive. All rights reserved.
//

#import "OLNSThreadViewController.h"
#import "OLThread.h"

@interface OLNSThreadViewController ()

@end

@implementation OLNSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self createThread00];
    
    [self createThread01];
    
//    [self createThread02];
    
//    [self createThread03];
}

- (void)createThread00 {
    // 自己琢磨的
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        [self go:@"threadWithTarget"];
        NSLog(@"thread block");
    }];
    [thread start];
}

- (void)createThread01 {
    OLThread *thread = [[OLThread alloc] initWithTarget:self selector:@selector(go:) object:@"threadWithTarget"];
    thread.name = @"thread A";
    [thread start];
}

- (void)createThread02 {
    // 这个是类方法。。。也就是没有线程对象，没有对象就拿不到线程的优先级
    [NSThread detachNewThreadSelector:@selector(go:) toTarget:self withObject:@"threadWithDetach"];
}

- (void)createThread03 {
    [self performSelector:@selector(go:) withObject:@"threadWithPerform" afterDelay:0]; // 这是主线程。。。
    [self performSelectorOnMainThread:@selector(go:) withObject:@"threadMain" waitUntilDone:NO];// 切主线程
    
    [self performSelectorInBackground:@selector(go:) withObject:@"threadWithBackground"]; // 这才是开启一个线程
}

- (void)go:(NSObject *)obj {
    for (int i = 0; i<10000; i++) {
        // 用来演示线程生命周期:只要子线程有任务再执行，那么对象就不会被销毁
        NSLog(@"----%d-----", i);
    }
    NSLog(@"%@------%@", [NSThread currentThread], obj);
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
