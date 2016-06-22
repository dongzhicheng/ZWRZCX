//
//  DZCTabBarController.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/6.
//  Copyright © 2016年 董志成. All rights reserved.

//当调用tabBarController的addChildViewControllers方法添加子控制器的话，不会立即添加子控制器对应的UITabBarButton。
//当调用tabBarController的viewControllers一次性设置tabBarController的所有子控制器，此时会自动生成子控制器对应的UITabBarButton


#import "DZCTabBarController.h"
#import "UIImage+Ex.h"
#import "DZCTabBar.h"
@interface DZCTabBarController ()<CZTabBarDelegate>
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation DZCTabBarController

- (NSMutableArray *)array {
    
    if (!_array) {
        _array = [NSMutableArray arrayWithCapacity:5];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *sbNames = @[  // 添加tabBarController的子控制器
                         @"MainMapSto",
                         @"BusInquiry",
                         @"CarOwnerInterfaceSto",
                         @"travelInformationSto",
                         @"LogSto"
                         ];
    
    for (NSString *name in sbNames) {
        [self addChildControllerWithName:name];
    }
    self.viewControllers = self.array;  //设置tabBarController的所有子控制器
    for (UIView *view in self.tabBar.subviews) { //删除UITabBarButton,UITabBarButton内部类，我们访问不了
        [view removeFromSuperview];
    }
    DZCTabBar *tabBar = [DZCTabBar tabBarWithSBNames:sbNames];  //设置自定义tabBar
    tabBar.delegate = self; //设置代理
    [self.tabBar addSubview:tabBar];
    tabBar.frame = self.tabBar.bounds;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}
- (void)tabBarDidClickedButton:(DZCTabBar *)tabBar selectedIndex:(NSInteger)selectedIndex { //自定义tabBar的代理方法
    self.selectedIndex = selectedIndex;  //让tabBarController中的对应子控制器显示
}
//添加到tabBarController中---如果一个一个添加子控制器，是不会在此位置生成UITabBarButton    [self addChildViewController:navC];
- (void)addChildControllerWithName:(NSString *)sbName { //给tabBarController添加子控制器
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil]; //从sb中加载导航控制器
    UINavigationController *navC = [sb instantiateInitialViewController]; //加载箭头指向的控制器
    [self.array addObject:navC];
}


@end
