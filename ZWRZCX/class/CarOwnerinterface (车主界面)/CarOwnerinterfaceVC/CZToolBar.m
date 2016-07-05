//
//  CZToolBar.m
//  05-键盘处理
//
//  Created by teacher on 15-7-1.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CZToolBar.h"

@implementation CZToolBar

+ (instancetype)toolBar
{
    return [[NSBundle mainBundle] loadNibNamed:@"CZToolBar" owner:nil options:nil][0];
}
- (IBAction)doneClick:(id)sender
{
    // 判断 能不能 响应
    if ([self.toolBarDelegate respondsToSelector:@selector(toolBar:withButtonType:)]) {
        // 执行
        [_toolBarDelegate toolBar:self withButtonType:CZToolBarButtonTypeDone];
    }
}

- (IBAction)preClick:(id)sender
{
    // 判断 能不能 响应
    if ([self.toolBarDelegate respondsToSelector:@selector(toolBar:withButtonType:)]) {
        // 执行
        [_toolBarDelegate toolBar:self withButtonType:CZToolBarButtonTypePre];
    }
}

- (IBAction)nextClick:(id)sender
{
    // 判断 能不能 响应
    if ([self.toolBarDelegate respondsToSelector:@selector(toolBar:withButtonType:)]) {
        // 执行
        [_toolBarDelegate toolBar:self withButtonType:CZToolBarButtonTypeNext];
    }
}

@end
