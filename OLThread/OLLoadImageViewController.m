//
//  OLLoadImageViewController.m
//  OLThread
//
//  Created by olive on 2017/4/16.
//  Copyright © 2017年 olive. All rights reserved.
//

#import "OLLoadImageViewController.h"

@interface OLLoadImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imVm;
/** img */
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation OLLoadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imgView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
        imageView.backgroundColor = [UIColor cyanColor];
        imageView;
    });
    [self.view addSubview:self.imgView];
//    [self downLoad01];
    [self downloadImgWithGCD];
    
}

- (void)downLoad01 {
    NSDate *start = [NSDate new];
    CFTimeInterval startTime = CFAbsoluteTimeGetCurrent();
    
    [self performSelectorInBackground:@selector(downLoad02) withObject:nil];
    
    NSDate *end = [NSDate new];
    NSLog(@"----%f----", [end timeIntervalSinceDate:start]);
    // ----0.210575----
    
    CFTimeInterval endTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"-----%f------", endTime - startTime);
}

- (void)downLoad02 {
    NSLog(@"||||%s||||----%@----",__func__, [NSThread currentThread]);
    
    NSURL *url = [NSURL URLWithString:@"http://img4.duitang.com/uploads/blog/201310/18/20131018213446_smUw4.thumb.700_0.jpeg"];
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imgData];
//    self.imgView.image = image;
    
    
    // 回到主线程去更新图片
    // 这是一种回到主线程的方法
//    [self performSelectorOnMainThread:@selector(viewImageView:) withObject:image waitUntilDone:NO];
    
    // 该方法是 NSObject的一个分类
    // - (void)performSelectorOnMainThread:(SEL)aSelector withObject:(nullable id)arg waitUntilDone:(BOOL)wait;
    
    // 所以下面这种方法会更简便 // 这样的话我们就不用调用下面的方法了。
    [self.imgView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    
}

- (void)downloadImgWithGCD {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://img4.duitang.com/uploads/blog/201310/18/20131018213446_smUw4.thumb.700_0.jpeg"];
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:imgData];
        
        NSLog(@"===%@", [NSThread currentThread]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self viewImageView:img];
        });
    });
}

- (void)viewImageView:(UIImage *)image {
    NSLog(@"done ~ %@", [NSThread currentThread]);
    
    self.imgView.image = image;
    
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
