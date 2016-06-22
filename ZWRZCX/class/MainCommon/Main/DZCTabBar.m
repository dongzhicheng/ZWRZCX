//
//  DZCTabBar.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/6.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import "DZCTabBar.h"
#import "UIView+Ex.h"
#import "DZCTabBarButton.h"

@interface DZCTabBar ()

@property (nonatomic, weak) UIButton *preButton; //记录上一个按钮
@end

@implementation DZCTabBar

+ (instancetype)tabBarWithSBNames:(NSArray *)sbNames {
    DZCTabBar *tabBar = [[DZCTabBar alloc] init];
    for (NSString *sbName in sbNames) { //创建图片对应的按钮 -- tabBarItem
        UIButton *btn = [DZCTabBarButton buttonWithType:UIButtonTypeCustom];
        btn.tag = tabBar.subviews.count;  //记录按钮的索引
        [tabBar addSubview:btn];
        NSString *imgName = [NSString stringWithFormat:@"TabBar_%@_new",sbName]; //加载按钮中显示的图片
        NSString *selectedImgName = [NSString stringWithFormat:@"TabBar_%@_selected_new",sbName];
        [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal]; //设置按钮的图片
        [btn setImage:[UIImage imageNamed:selectedImgName] forState:UIControlStateSelected]; //下一步设置按钮的大小和位置
        [btn sizeToFit]; //让按钮和图片的大小保持一致
        [btn addTarget:tabBar action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];  //给按钮注册点击事件
    }
    UIButton *btn = [tabBar.subviews firstObject]; //让第一个按钮选中
    [tabBar btnClick:btn];
    return tabBar;
}
- (void)btnClick:(UIButton *)sender { //点击按钮
    self.preButton.selected = NO; //让上一个按钮不选中
    sender.selected = YES; //让当前按钮选中
    self.preButton = sender; //记录上一个按钮
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedButton:selectedIndex:)]) { //合适的时机调用代理方法
        [self.delegate tabBarDidClickedButton:self selectedIndex:sender.tag];
    }
}
- (void)layoutSubviews { //设置按钮的位置
    [super layoutSubviews];
    for (int i = 0; i < self.subviews.count; i++) { //设置按钮的位置
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = i * btn.width;
    }
}


@end
