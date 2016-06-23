//
//  AppDelegate.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/1.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import <SMS_SDK/SMSSDK.h>
#import "MMZCViewController.h"
#import "NewRecordScreen.h"
#import "UserGuidViewController.h"
#import "DZCTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    CGFloat version = [[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] floatValue]; //从info.plust中加载app安装的Version

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults]; //创建沙盒对象
    
    CGFloat oldVersion = [userDefaults floatForKey:@"version"]; //获取存储的上一个版本
    
    if (version >oldVersion) { //判断是否是第一次安装

        UIStoryboard * UserGuidStoryB = [UIStoryboard storyboardWithName:@"UserGuidViewController" bundle:nil];
        
        UserGuidViewController * vc = [UserGuidStoryB instantiateInitialViewController]; //用storB来来创建控制器
        
        self.window.rootViewController = vc; //设置根控制器
        
        [userDefaults setFloat:version forKey:@"version"]; //保存数据
        
        [userDefaults synchronize];  //synchronize 同步
        
    }else {
        
        DZCTabBarController *tabBarC = [[DZCTabBarController alloc] init];  // 当前的版本号 <= 上一次的版本号  打开主界面
        
        self.window.rootViewController = tabBarC; //设置根控制器为tabBarC
        
    }

    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]]; //统一设置Bar的颜色
    
    [SMSSDK registerApp:@"1386e8598b474"
             withSecret:@"4e0796c9089f7e07a9b16de613cc275a"];  //处理短信验证码

    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


/*
 // Override point for customization after application launch.
 //    MKMapItem *currentItem = [MKMapItem mapItemForCurrentLocation];
 //    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
 //    [MKMapItem openMapsWithItems:@[currentItem,currentItem] launchOptions:nil];
 
 //设置NavigationBar背景颜色
 [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
 //    MMZCViewController *login=[[MMZCViewController alloc]init];
 //    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:login];
 //    self.window.rootViewController=nav;  //设置根控制器
 //    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1],NSForegroundColorAttributeName,nil];
 //    [nav.navigationBar setTitleTextAttributes:attributes];
 
 */


@end
