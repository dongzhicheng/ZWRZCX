//
//  BusInquiryViewController.h
//  ZWRZCX
//
//  Created by 董志成 on 16/6/3.
//  Copyright © 2016年 董志成. All rights reserved.
//

@interface BusInquiryViewController : UIViewController<UIGestureRecognizerDelegate,UIAlertViewDelegate>{
    NewRecordScreen *newRecordObj;
    UITapGestureRecognizer *myTapGesture;
    
}
@property (strong, nonatomic) IBOutlet UITextField *BusinquirynameLabel;


@end
