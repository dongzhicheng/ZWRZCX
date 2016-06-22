//
//  DZCTabBar.h
//  ZWRZCX
//
//  Created by 董志成 on 16/6/6.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZCTabBar;

@protocol CZTabBarDelegate <NSObject>
- (void)tabBarDidClickedButton:(DZCTabBar *)tabBar selectedIndex:(NSInteger)selectedIndex;
@end

@interface DZCTabBar : UIView
+ (instancetype)tabBarWithSBNames:(NSArray *)sbNames;
@property (nonatomic, weak) id<CZTabBarDelegate> delegate;

@end
