//
//  DZCNavigationController.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/6.
//  Copyright © 2016年 董志成. All rights reserved.
//

@interface DZCNavigationController ()

@end

@implementation DZCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
    
    
}
+ (void)initialize {
    UINavigationBar *bar = [UINavigationBar appearance]; //获取到当前所有显示的导航条
    [bar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault]; //UIBarMetricsCompact横屏显示的图片；UIBarMetricsDefault  设置横屏和竖屏显示的图片
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}]; //设置标题的字体颜色
    bar.translucent = NO; //去掉导航条的半透明效果   如果有透明度，控制器的view有穿透效果。如果没有透明度，控制器的view没有穿透效果
    UIBarButtonItem *item = [UIBarButtonItem appearance]; // 导航按钮的样式
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal]; //设置导航按钮的文字颜色和大小
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated { //重写导航控制器的push方法，viewController要跳转到的控制器
    [self addBackButton:viewController];
    [super pushViewController:viewController animated:YES];
}
- (void)addBackButton:(UIViewController *)viewController { //设置自定义后退按钮
    self.interactivePopGestureRecognizer.delegate = (id)self; //设置后退的手势
    viewController.hidesBottomBarWhenPushed = YES; //当push的时候隐藏底部的tabBar
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"NavBack"] orginalImage] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)]; //自定义后退按钮
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -10; //固定的fixed  固定的间距
    viewController.navigationItem.leftBarButtonItems = @[fixed,back];
}
- (void)backClick { //点击自定义回退按钮

    [self popViewControllerAnimated:YES]; //弹到上一个控制器
}

@end
