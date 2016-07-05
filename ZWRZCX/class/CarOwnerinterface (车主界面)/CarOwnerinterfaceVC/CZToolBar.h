//
//  CZToolBar.h
//  05-键盘处理
//
//  Created by teacher on 15-7-1.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

//#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@class CZToolBar;

typedef enum : NSUInteger {
                   CZToolBarButtonTypePre,
                   CZToolBarButtonTypeNext,
                   CZToolBarButtonTypeDone,
               } CZToolBarButtonType;

@protocol CZToolBarDelegate <NSObject>

@optional
- (void)toolBar:(CZToolBar*)toolBar withButtonType:(CZToolBarButtonType)type;

@end

@interface CZToolBar : UIToolbar
@property (weak, nonatomic) IBOutlet UIBarButtonItem* doneButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem* preButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem* nextButton;

@property (nonatomic, weak) id<CZToolBarDelegate> toolBarDelegate;

+ (instancetype)toolBar;

@end
