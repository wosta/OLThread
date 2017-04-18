//
//  ViewController.m
//  OLThread
//
//  Created by olive on 2017/4/15.
//  Copyright © 2017年 olive. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>
#import "OLPthreadViewController.h"
#import "OLNSThreadViewController.h"
#import "OLGCDViewController.h"
#import "OLNSOperationViewController.h"
#import "OLLoadImageViewController.h"

static NSString  *ViewControllerReusableCellWithIdentifierID = @"ViewControllerReusableCellWithIdentifierID";
static NSInteger tableNumber = 5;

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
/** name */
@property (nonatomic, strong) UITableView *tableView;
/** name */
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = ({
        UITableView *tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        [tbView registerClass:[UITableViewCell class] forCellReuseIdentifier:ViewControllerReusableCellWithIdentifierID];
        tbView.delegate = self;
        tbView.dataSource = self;
        tbView;
    });
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableNumber;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ViewControllerReusableCellWithIdentifierID forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        OLPthreadViewController *vc = [[OLPthreadViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1) {
        OLNSThreadViewController *vc = [[OLNSThreadViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2) {
        OLGCDViewController *vc = [[OLGCDViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
        OLNSOperationViewController *vc = [[OLNSOperationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4) {
        OLLoadImageViewController *vc = [[OLLoadImageViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSArray alloc] initWithObjects:@"pthread", @"NSThread", @"GCD", @"NSOperation", @"loadImage", nil];
    }
    return _dataArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
