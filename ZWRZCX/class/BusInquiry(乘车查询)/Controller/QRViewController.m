//
//  QRViewController.m
//  QRWeiXinDemo
//
//  Created by lovelydd on 15/4/25.
//  Copyright (c) 2015年 lovelydd. All rights reserved.
//

#import "QRViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRView.h"
#import <objc/runtime.h>


#define qrRectViewWH [UIScreen mainScreen].bounds.size.width * 0.8

@interface QRViewController ()<AVCaptureMetadataOutputObjectsDelegate,QRViewDelegate>

@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureDeviceInput * input;
@property (strong, nonatomic) AVCaptureMetadataOutput * output;
@property (strong, nonatomic) AVCaptureSession * session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic,weak) QRView *rview;
@property (nonatomic,assign) BOOL isOpenOrClose;



@end

@implementation QRViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isOpenOrClose = NO;
    
//    [self creatLeftButton:@selector(pop:) image:@"icon-arrow-back" title:@"返回"];
//    
//    self.customTitleLabel.text =
    self.title = @"扫一扫";

    
    
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
        
   
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,
                                   AVMetadataObjectTypeEAN8Code,
                                   AVMetadataObjectTypeCode128Code];
    
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResize;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    //添加闪光灯button
    
    
    
    [_session startRunning];
    
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    QRView *qrRectView = [[QRView alloc] initWithFrame:screenRect];
    _rview = qrRectView;
    qrRectView.transparentArea = CGSizeMake(qrRectViewWH, qrRectViewWH);
    qrRectView.backgroundColor = [UIColor clearColor];
    qrRectView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    qrRectView.delegate = self;
    [self.view addSubview:qrRectView];
    
    //修正扫描区域
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    CGRect cropRect = CGRectMake((screenWidth - qrRectView.transparentArea.width) / 2,
                                 (screenHeight - qrRectView.transparentArea.height) / 2,
                                 qrRectView.transparentArea.width,
                                 qrRectView.transparentArea.height);

    [_output setRectOfInterest:CGRectMake(cropRect.origin.y / screenHeight,
                                          cropRect.origin.x / screenWidth,
                                          cropRect.size.height / screenHeight,
                                          cropRect.size.width / screenWidth)];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0 , (self.view.bounds.size.height - qrRectViewWH)/2.f -60, self.view.bounds.size.width, 60)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.numberOfLines = 0;
    [_label setText:@"将取景框对准二维码或者条形码\n即可自动扫描"];
    [_label setTintColor:[UIColor yellowColor]];
    [self.view addSubview:_label];
    
    
    [self addTorchButton];
}


#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] > 0){
        //停止扫描
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        _stringValue = stringValue;
        
        
        NSData *data = [_stringValue dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",data.description);
        
    }

    [self pop:nil];
    
    if (self.qrUrlBlock) {
        self.qrUrlBlock(stringValue);
    }
    
    NSLog(@"🍌🍌🍌🍌%@",connection.inputPorts);
    
    
    
    
}

- (void)pop:(UIButton *)button {
//    [NOTIFICATION_CENTER postNotificationName:@"track" object:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear: animated];
    
    [_rview addTimer];
    
   

}
-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear: animated];
    
    [_rview pauseTiemr];
}
-(void)addTorchButton{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button addTarget:self action:@selector(onOrOff:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:@"开灯" forState:UIControlStateNormal];
    
    button.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:button];
    
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-10-50,[UIScreen mainScreen].bounds.size.height-10-30-55, 50, 30);


}
-(void)onOrOff:(UIButton *)button{

    if (!_isOpenOrClose) {
        
        [_device lockForConfiguration:nil];
        
        _device.torchMode = AVCaptureTorchModeOn;
        
        [_device unlockForConfiguration];
        
        [button setTitle:@"关闭" forState:UIControlStateNormal];
        
        _isOpenOrClose = YES;
    }else{
    
        [_device lockForConfiguration:nil];
        
        _device.torchMode = AVCaptureTorchModeOff;
        
        [_device unlockForConfiguration];
    
        [button setTitle:@"开灯" forState:UIControlStateNormal];
        
        _isOpenOrClose = NO;
    }


}
@end





