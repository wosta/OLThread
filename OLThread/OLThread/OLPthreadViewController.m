//
//  OLPthreadViewController.m
//  OLThread
//
//  Created by 魏旺 on 2017/4/16.
//  Copyright © 2017年 olive. All rights reserved.
//

#import "OLPthreadViewController.h"
#import <pthread.h>

@interface OLPthreadViewController ()

@end

@implementation OLPthreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)go:(UIButton *)sender {
    pthread_t thread;
    pthread_create(&thread, NULL, task, NULL);
}

void *task(void *param)
{
    NSLog(@"%@----------", [NSThread currentThread]);
    return NULL;
}

@end
