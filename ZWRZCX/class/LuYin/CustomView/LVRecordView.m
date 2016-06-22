


@interface LVRecordView () <LVRecordToolDelegate>

@property (nonatomic, strong) LVRecordTool *recordTool;/** 录音工具 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;/** 录音时的图片 */
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;/** 录音按钮 */
@property (weak, nonatomic) IBOutlet UIButton *playBtn;/** 播放按钮 */
@property (strong, nonatomic) IBOutlet UITextField *recordTimeField;

@end

@implementation LVRecordView

+ (instancetype)recordView {
    LVRecordView *recordView = [[[NSBundle mainBundle] loadNibNamed:@"LVRecordView" owner:nil options:nil] lastObject];
    recordView.recordTool = [LVRecordTool sharedRecordTool];
    [recordView setup];// 初始化监听事件
    return recordView;
}
- (void)setup {
    self.recordBtn.layer.cornerRadius = 10;
    self.playBtn.layer.cornerRadius = 10;
    [self.recordBtn setTitle:@"按住 说话" forState:UIControlStateNormal];
    [self.recordBtn setTitle:@"松开 结束" forState:UIControlStateHighlighted];
    self.recordTool.delegate = self;
    [self.recordBtn addTarget:self action:@selector(recordBtnDidTouchDown:) forControlEvents:UIControlEventTouchDown]; // 录音按钮
    [self.recordBtn addTarget:self action:@selector(recordBtnDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.recordBtn addTarget:self action:@selector(recordBtnDidTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [self.playBtn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside]; // 播放按钮
}
#pragma mark - 录音按钮事件
- (void)recordBtnDidTouchDown:(UIButton *)recordBtn { // 按下
    self.recordTimeField.text = @""; //置空recordTimeField
    [self.recordTool startRecording];
}
- (void)recordBtnDidTouchUpInside:(UIButton *)recordBtn { // 点击
    double currentTime = self.recordTool.recorder.currentTime;
    NSLog(@"%lf", currentTime);
    if (currentTime < 2) {
        self.imageView.image = [UIImage imageNamed:@"mic_0"];
        [self alertWithMessage:@"说话时间太短"];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.recordTool stopRecording];
            [self.recordTool destructionRecordingFile];
        });
    } else {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.recordTool stopRecording];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = [UIImage imageNamed:@"mic_0"];
            });
        });
        self.recordTimeField.text = [NSString stringWithFormat:@"%f",self.recordTool.recorder.currentTime];
        NSLog(@"已成功录音");
    }
}
- (void)recordBtnDidTouchDragExit:(UIButton *)recordBtn { // 手指从按钮上移除
    self.imageView.image = [UIImage imageNamed:@"mic_0"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.recordTool stopRecording];
        [self.recordTool destructionRecordingFile];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self alertWithMessage:@"已取消录音"];
        });
    });
}
#pragma mark - 弹窗提示
- (void)alertWithMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
#pragma mark - 播放录音
- (void)play {
    [self.recordTool playRecordingFile];
}
- (void)dealloc {
    if ([self.recordTool.recorder isRecording]) [self.recordTool stopPlaying];
    if ([self.recordTool.player isPlaying]) [self.recordTool stopRecording];
}
#pragma mark - LVRecordToolDelegate
- (void)recordTool:(LVRecordTool *)recordTool didstartRecoring:(int)no {
    NSString *imageName = [NSString stringWithFormat:@"mic_%d", no];
    self.imageView.image = [UIImage imageNamed:imageName];
}
@end
