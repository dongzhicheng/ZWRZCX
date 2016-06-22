//
//  SaomiaoController.h
//  GuBenTang
//
//  Created by kuajie on 16/5/3.
//  Copyright © 2016年 跨界. All rights reserved.
//

//#import <UIKit/UIKit.h>
//#import <AVFoundation/AVFoundation.h>
//@interface SaomiaoController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
//-(BOOL)startReading;
//-(void)stopReading;

////捕捉会话
//@property (nonatomic, strong) AVCaptureSession *captureSession;
////展示layer
//@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
//@property(nonatomic, assign)BOOL isReading;
//@property (strong, nonatomic) UIView *boxView;
//@property (strong, nonatomic) CALayer *scanLayer;
//
//@property (strong, nonatomic)  UIView *viewPreview;
//@property (strong, nonatomic)  UILabel *lblStatus;
//@property (strong, nonatomic)  UIButton *startBtn;
//- (void)startStopReading:(id)sender;
//@end
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol SaomiaoControllerDelegate <NSObject>

- (void)qrCodeComplete:(NSString *)codeString;
- (void)qrCodeError:(NSError *)error;

@end


@interface SaomiaoController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>

@property(assign,nonatomic)id<SaomiaoControllerDelegate> delegate;
@property (strong,nonatomic)AVCaptureDevice *device;
@property (strong,nonatomic)AVCaptureMetadataOutput *output;
@property (strong,nonatomic)AVCaptureDeviceInput *input;
@property (strong, nonatomic)AVCaptureSession *session;
@property (strong, nonatomic)AVCaptureVideoPreviewLayer *preview;

@end
