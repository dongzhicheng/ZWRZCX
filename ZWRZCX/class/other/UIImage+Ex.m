//
//  UIImage+Ex.m
//  07-彩票
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "UIImage+Ex.h"

@implementation UIImage (Ex)

- (instancetype)orginalImage {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
