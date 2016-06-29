////
////  SaomiaoController.h
////  GuBenTang
////
////  Created by kuajie on 16/5/3.
////  Copyright © 2016年 跨界. All rights reserved.
////
//
//
//#import "SaomiaoController.h"
//@interface SaomiaoController ()
//

//@end
//
//@implementation SaomiaoController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    
//    _captureSession = nil;
//    _isReading = NO;
//    [self startReading];
//    
//}
//-(BOOL)startReading {
//    _viewPreview = [[UIView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:_viewPreview];
//    NSError *error;
//    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
//    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    //2.用captureDevice创建输入流
//    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
//    if (!input) {
//        NSLog(@"%@", [error localizedDescription]);
//        return NO;
//    }
//    //3.创建媒体数据输出流
//    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
//    //4.实例化捕捉会话
//    _captureSession = [[AVCaptureSession alloc] init];
//    //4.1.将输入流添加到会话
//    [_captureSession addInput:input];
//    //4.2.将媒体输出流添加到会话中
//    [_captureSession addOutput:captureMetadataOutput];
//    //5.创建串行队列，并加媒体输出流添加到队列当中
//    dispatch_queue_t dispatchQueue;
//    dispatchQueue = dispatch_queue_create("myQueue", NULL);
//    //5.1.设置代理
//    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
//    //5.2.设置输出媒体数据类型为所有类型
//    captureMetadataOutput.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
//    //6.实例化预览图层
//    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
//    //7.设置预览图层填充方式
//    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
//    //8.设置图层的frame
//    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
//    //9.将图层添加到预览view的图层上
//    [_viewPreview.layer addSublayer:_videoPreviewLayer];
//    //10.设置扫描范围
//    captureMetadataOutput.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
//    //10.1.扫描框
//    _boxView = [[UIView alloc] initWithFrame:CGRectMake(_viewPreview.bounds.size.width * 0.2f, _viewPreview.bounds.size.height * 0.2f, _viewPreview.bounds.size.width - _viewPreview.bounds.size.width * 0.4f, _viewPreview.bounds.size.height - _viewPreview.bounds.size.height * 0.4f)];
//    _boxView.layer.borderColor = [UIColor greenColor].CGColor;
//    _boxView.layer.borderWidth = 1.0f;
//    [_viewPreview addSubview:_boxView];
//    //10.2.扫描线
//    _scanLayer = [[CALayer alloc] init];
//    _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, 1);
//    _scanLayer.backgroundColor = [UIColor brownColor].CGColor;
//    [_boxView.layer addSublayer:_scanLayer];
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
//    [timer fire];
//    
//    //10.开始扫描
//    [_captureSession startRunning];
//    return YES;
//}
//
//#pragma mark - AVCaptureMetadataOutputObjectsDelegate协议方法
//- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
//{
//    //判断是否有数据
//    if (metadataObjects != nil && [metadataObjects count] > 0) {
//        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
//        //判断回传的数据类型  captureMetadataOutput.metadataObjectTypes  数组里的类型进行遍历对比 添加if判断类型，
//        //        下面只以AVMetadataObjectTypeQRCode 为例子
//        //        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
//        //            [_lblStatus performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
//        //            NSLog(@"11111 = %@", _lblStatus.text);
//        //            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
//        //            _isReading = NO;
//        //        }
//        
//    }
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//        
//    }];
//    
//}
//- (void)moveScanLayer:(NSTimer *)timer
//{
//    CGRect frame = _scanLayer.frame;
//    if (_boxView.frame.size.height < _scanLayer.frame.origin.y) {
//        frame.origin.y = 0;
//        _scanLayer.frame = frame;
//    }else{
//        frame.origin.y += 5;
//        [UIView animateWithDuration:0.1 animations:^{
//            _scanLayer.frame = frame;
//        }];
//    }
//}
//- (void)startStopReading:(id)sender {
//    if (!_isReading) {
//        if ([self startReading]) {
//            [_startBtn setTitle:@"Stop" forState:UIControlStateNormal];
//            [_lblStatus setText:@"Scanning for QR Code"];
//        }
//    }
//    else{
//        [self stopReading];
//        [_startBtn setTitle:@"Start!" forState:UIControlStateNormal];
//    }
//    _isReading = !_isReading;
//}
//-(void)stopReading{
//    [_captureSession stopRunning];
//    _captureSession = nil;
//    [_scanLayer removeFromSuperlayer];
//    [_videoPreviewLayer removeFromSuperlayer];
//}
//@end

#import "SaomiaoController.h"

@interface SaomiaoController ()
{
    NSTimer *_timer;
    UIImageView *_imageView;
    UIImageView *_lineImageView;
}
@end

@implementation SaomiaoController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"二维码扫描";
    self.view.autoresizingMask = YES;
    self.view.backgroundColor = [UIColor grayColor];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];//处理navigationBar的颜色
    [self initUiConfig];
    
    
    
}
- (void)initUI:(CGRect)previewFrame{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    if (error) {
        if ([self.delegate respondsToSelector:@selector(qrCodeError:)]) {
            [self.delegate qrCodeError:error];
        }
        NSLog(@"你手机不支持二维码扫描!");
        return;
    }
    self.output = [[AVCaptureMetadataOutput alloc]init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    self.session = [[AVCaptureSession alloc]init];
    if ([self.session canAddInput:self.input]){
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]){
        [self.session addOutput:self.output];
    }
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode];
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = previewFrame;
    [self.view.layer addSublayer:self.preview];
    if ([UIScreen mainScreen].bounds.size.height == 480){
        [self.session setSessionPreset:AVCaptureSessionPreset640x480];
    }
    else{
        [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    [self.session startRunning];
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    [self.session stopRunning];
    [self.preview removeFromSuperlayer];
    NSString *val = nil;
    if (metadataObjects.count > 0){
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        val = obj.stringValue;
        NSLog(@"这是扫一扫的打印输出%@",obj.stringValue);
        if ([self.delegate respondsToSelector:@selector(qrCodeComplete:)]) {
            [self.delegate qrCodeComplete:val];
        }
    }
}
- (void)initUiConfig{
    [self initUI:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height)];
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg.png"]];
    _imageView.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 140, self.view.bounds.size.height * 0.5 - 140, 280, 280);
    [self.view addSubview:_imageView];
    _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 220, 2)];
    _lineImageView.image = [UIImage imageNamed:@"line.png"];
    [_imageView addSubview:_lineImageView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelBtnClick:)];
  _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}
- (void)animation{
    [UIView animateWithDuration:2.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _lineImageView.frame = CGRectMake(30, 260, 220, 2);
    } completion:^(BOOL finished) {
        _lineImageView.frame = CGRectMake(30, 10, 220, 2);
    }];
}
- (void)cancelBtnClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

 }

@end

