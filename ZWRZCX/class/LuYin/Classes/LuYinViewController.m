//
//  LuYinViewController.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/7.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import "LuYinViewController.h"
#import "LVRecordView.h"

@interface LuYinViewController ()
@property(nonatomic,strong)LVRecordView *recordView;

@end

@implementation LuYinViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.recordView = [LVRecordView recordView];
    self.recordView.backgroundColor = [UIColor lightGrayColor];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.recordView.frame = CGRectMake(50, 100, width - 2 * 50, 300);
    [self.view addSubview:self.recordView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
