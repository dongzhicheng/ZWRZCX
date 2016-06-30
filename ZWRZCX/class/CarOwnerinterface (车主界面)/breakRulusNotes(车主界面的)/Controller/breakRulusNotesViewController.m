
//
//  breakRulusNotesViewController.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/3.
//  Copyright © 2016年 董志成. All rights reserved.
//
#import "breakRulusPicker.h"

@interface breakRulusNotesViewController ()<AVCaptureFileOutputRecordingDelegate,AVPlayerViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *carOwnerInterfaceLabel;

@property (nonatomic,strong)AVCaptureDeviceInput * inputC;
@property (nonatomic,strong)AVCaptureDeviceInput * inputM;
@property (nonatomic,strong)AVCaptureMovieFileOutput * outPut;
@property (nonatomic,strong)AVCaptureSession *session;
@property (nonatomic,strong)AVCaptureVideoPreviewLayer *layer;
@property (strong, nonatomic) IBOutlet UILabel *Textbouds;

@property (strong, nonatomic) IBOutlet UIPickerView *pickView;
@property (strong, nonatomic) IBOutlet UITextField *breakRulusTextFiled;
@property (strong,nonatomic)cunlabelModel *cunlabelModel;
@property (nonatomic, strong) AVPlayerViewController *playerVc;

@end

@implementation breakRulusNotesViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.breakRulusTextFiled.delegate = self;
    self.carOwnerInterfaceLabel.numberOfLines = 0;
    self.pickView.dataSource = self;
    self.pickView.delegate = self;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;

}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return  40;

}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{

    breakRulusPicker *breakRulusPickerView = [breakRulusPicker flagView];
    
    breakRulusPickerView.nameLabel.text = @"违规选项功能测试";
    
    return breakRulusPickerView;

}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    self.breakRulusTextFiled.text = @"违规选项功能测试";

}

- (IBAction)sureInputAndshow:(id)sender {
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
 
 NSLog(@" textFieldDidBeginEditing  %@",textField.text);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{

    self.carOwnerInterfaceLabel.numberOfLines = 0;
    
    self.carOwnerInterfaceLabel.text = textField.text;
    
    NSLog(@" textFieldDidEndEditing   %@",textField.text);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.breakRulusTextFiled resignFirstResponder];

}

- (IBAction)pictureButton:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"breakRulusNotesViewController" object:nil]; // 发送通知  别的控制器去执行
    
}
- (IBAction)vidoButton:(id)sender {
    AVCaptureDevice *deviceC = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.inputC = [AVCaptureDeviceInput deviceInputWithDevice:deviceC error:nil];
    AVCaptureDevice *deviceM = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    self.inputM = [AVCaptureDeviceInput deviceInputWithDevice:deviceM  error:nil];
    self.session = [[AVCaptureSession alloc] init];
    self.outPut = [[AVCaptureMovieFileOutput alloc] init];
    if ([self.session canAddInput:self.inputM]) {
        [self.session addInput:self.inputM];
    }
    if ([self.session canAddInput:self.inputC]) {
        [self.session addInput:self.inputC];
    }
    if ([self.session canAddOutput:self.outPut]) {
        [self.session addOutput:self.outPut];
    }
    self.layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    NSLog(@"%f",self.view.bounds.size.width);
    
    [self.layer setFrame:CGRectMake(-10, 10, 375, 404)];
    NSLog(@"这是视频按钮对应的view的frame:%f,%f,%f,%f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.bounds.size.width,self.view.bounds.size.height);
    [self.view.layer insertSublayer:self.layer above:0];
    [self.session startRunning];
    if ([self.outPut isRecording]) {
        [self.outPut stopRecording];
        [self.session stopRunning];
        [self.layer removeFromSuperlayer];
    }else{
        NSString *path  = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"RZCX.mov" ];
        [self.outPut startRecordingToOutputFileURL:[NSURL fileURLWithPath:path] recordingDelegate:self];
        NSLog(@"%@",path);
    }
}

- (IBAction)shipingBoFang:(id)sender {
    NSString *path  = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"RZCX.mov" ];
    NSURL *url = [NSURL fileURLWithPath:path];
    AVPlayerViewController *playerVc = [[AVPlayerViewController alloc]init];
    self.playerVc = playerVc;
    playerVc.showsPlaybackControls = YES;
    playerVc.player = [[AVPlayer alloc]initWithURL:url];
    playerVc.allowsPictureInPicturePlayback = YES;
    [[AVAudioSession sharedInstance]setActive:YES error:nil];
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];
    playerVc.delegate = self;
    [self presentViewController:self.playerVc animated:YES completion:nil];
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections;{
    NSLog(@"didStartRecordingToOutputFileAtURL");
}
- (IBAction)yuYinButton:(id)sender {
    
}
- (IBAction)currentlocationButton:(id)sender {
    MKMapItem *currentItem = [MKMapItem mapItemForCurrentLocation];
    [MKMapItem openMapsWithItems:@[currentItem,currentItem] launchOptions:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
