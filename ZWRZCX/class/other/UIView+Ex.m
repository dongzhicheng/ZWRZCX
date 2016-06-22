//
//  UIView+Ex.m
//  07-彩票
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "UIView+Ex.h"

@implementation UIView (Ex)


//重写x属性的getter
- (CGFloat)x{
    return self.frame.origin.x;
}

//重写x属性的setter
- (void)setX:(CGFloat)x {
    //当同时重写了属性的setter和getter方法之后，不会自动生成成员变量（直接属于类的变量）
    //分类中是不能增加成员变量的
    CGRect frame = self.frame;
    
    frame.origin.x = x;
    
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    
    frame.origin.y = y;
    
    self.frame = frame;
}


- (CGFloat)width {
    return self.bounds.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    
    frame.size.width = width;
    
    self.frame = frame;
}


- (CGFloat)height {
    return self.bounds.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    
    frame.size.height = height;
    
    self.frame = frame;
}

@end
