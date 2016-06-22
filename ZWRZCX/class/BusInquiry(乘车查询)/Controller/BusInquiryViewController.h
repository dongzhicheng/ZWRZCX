//
//  BusInquiryViewController.h
//  ZWRZCX
//
//  Created by 董志成 on 16/6/3.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ScreenCaptureView.h"
#import "PlayBackViewController.h"
#import "NewRecordScreen.h"
@interface BusInquiryViewController : UIViewController<UIGestureRecognizerDelegate,UIAlertViewDelegate>{
    NewRecordScreen *newRecordObj;
    UITapGestureRecognizer *myTapGesture;
    
}


@end
