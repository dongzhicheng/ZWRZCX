//  BusInquiryViewController.m
//  ZWRZCX

//  Created by 董志成 on 16/6/3.
//  Copyright © 2016年 董志成. All rights reserved.
//  屏幕

#import "BusInquiryViewController.h"
#import "SaomiaoController.h"

#import "DOPScrollableActionSheet.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface BusInquiryViewController ()<AVPlayerViewControllerDelegate,UIPrintInteractionControllerDelegate>

@property(nonatomic,strong)UIButton * btn;
@property (nonatomic,strong)MPMoviePlayerController *playerVc;
@end

@implementation BusInquiryViewController

- (IBAction)TextPrintClick:(id)sender {
    
    [self printActionsbutton2:nil];
    
}

-(void)printActionsbutton2:(id)sender{
    
    UIImage * printImage = [UIImage imageNamed:@"1.png"]; //获取要打印的图片
    //        剪切原图（824 * 2235）  （789 960）                     不成功
    //        UIImage * scanImage = [self scaleToSize:printImage size:CGSizeMake(595, 1660)];
    //        UIImage *jietuImage2 = [self imageFromImage:scanImage inRect:CGRectMake(0, 880, 595, 824)];
    //
    UIPrintInteractionController *printC = [UIPrintInteractionController sharedPrintController]; //显示出打印的用户界面。
    
    printC.delegate = self;
    
    if (!printC) {
        
        NSLog(@"打印机不存在"); // [self showAlertView:@"初始化失败"];
        
    }
    
    printC.showsNumberOfCopies = YES;
    
    printC.showsPageRange = YES;
    
    NSData *imgDate = UIImagePNGRepresentation(printImage);
    
    NSData *data = [NSData dataWithData:imgDate];
    
    if (printC && [UIPrintInteractionController canPrintData:data]) {
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo]; //准备打印信息以预设值初始化的对象。
        
        printInfo.outputType = UIPrintInfoOutputGeneral; //设置输出类型。
        
        printC.showsPageRange = YES; //显示的页面范围
        
        printC.printInfo = printInfo; // printInfo.jobName = @"my.job";
        
        printC.printingItem = data; //single NSData, NSURL, UIImage, ALAsset
        
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
        ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) { // 等待完成
            
            if (!completed && error) {
                NSLog(@"可能无法完成，因为印刷错误: %@", error);
            }
            
        };
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:sender];//调用方法的时候，要注意参数的类型－下面presentFromBarButtonItem:的参数类型是 UIBarButtonItem..如果你是在系统的UIToolbar or UINavigationItem上放的一个打印button，就不需要转换了。
            [printC presentFromBarButtonItem:item animated:YES completionHandler:completionHandler];//在ipad上弹出打印那个页面
            
        } else {
            
            [printC presentAnimated:YES completionHandler:completionHandler];//在iPhone上弹出打印那个页面
            
        }
    }
}


- (void)printInteractionControllerWillStartJob:(UIPrintInteractionController *)printInteractionController{
    
    NSLog(@"printInteractionControllerWillStartJob");
}
- (void)printInteractionControllerDidFinishJob:(UIPrintInteractionController *)printInteractionController{
    
    NSLog(@"printInteractionControllerDidFinishJob");
}

- (UIViewController *)printInteractionControllerParentViewController:(UIPrintInteractionController *)printInteractionController{
    
    UIViewController * vc  = [UIViewController new];
    
    vc.view.backgroundColor = [UIColor redColor];
    
    NSLog(@"11");
    
    return vc;
    
}


//测试成功播放视频
- (IBAction)textViodPlayer:(id)sender {
   
     [self presentViewController:self.playerVc animated:YES completion:nil];
    
  }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    newRecordObj = [[NewRecordScreen alloc]initWithView:self.view andViewController:self];
    myTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapHandle:)];
    [myTapGesture setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:myTapGesture];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btn setFrame:CGRectMake(280, 50, 40, 40)];
    [_btn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    [_btn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
    _btn.layer.cornerRadius = 20;
    _btn.layer.masksToBounds = YES;
    // 拖移的 Recognizer
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self                                               action:@selector(handlePan:)];
    [_btn addGestureRecognizer:panGestureRecognizer];
    [_btn addTarget:self action:@selector(TextClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Alizee_La_Isla_Bonita.mp4" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    AVPlayerViewController *playerVc = [[AVPlayerViewController alloc]init];
    self.playerVc = playerVc;
    playerVc.showsPlaybackControls = YES;
    playerVc.player = [[AVPlayer alloc]initWithURL:url];
    playerVc.allowsPictureInPicturePlayback = YES;
    [[AVAudioSession sharedInstance]setActive:YES error:nil];
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    playerVc.delegate = self;


    

}

-(void)TextClick{
    
    DOPAction *action1 = [[DOPAction alloc] initWithName:@"Wechat" iconName:@"weixin" handler:^{
        //
        NSLog(@"测试点击了cell对应的qq按钮");

    }];
    DOPAction *action2 = [[DOPAction alloc] initWithName:@"QQ" iconName:@"qq" handler:^{
        //
    }];
    DOPAction *action3 = [[DOPAction alloc] initWithName:@"WxFriends" iconName:@"wxFriends" handler:^{
        //
    }];
    DOPAction *action4 = [[DOPAction alloc] initWithName:@"Qzone" iconName:@"qzone" handler:^{
        //
    }];
    DOPAction *action5 = [[DOPAction alloc] initWithName:@"Weibo" iconName:@"weibo" handler:^{
        //
    }];
    DOPAction *action6 = [[DOPAction alloc] initWithName:@"Twitter" iconName:@"twitter" handler:^{
        //
    }];
    DOPAction *action7 = [[DOPAction alloc] initWithName:@"Facebook" iconName:@"fb" handler:^{
        //
    }];
    DOPAction *action8 = [[DOPAction alloc] initWithName:@"G+" iconName:@"g+" handler:^{
        //
    }];
    DOPAction *action9 = [[DOPAction alloc] initWithName:@"Pin" iconName:@"pin" handler:^{
        //
    }];
    DOPAction *action10 = [[DOPAction alloc] initWithName:@"Whatsapp" iconName:@"whatsapp" handler:^{
        //
    }];
    DOPAction *action11 = [[DOPAction alloc] initWithName:@"Line" iconName:@"line" handler:^{
        //
    }];
    DOPAction *action12 = [[DOPAction alloc] initWithName:@"SMS" iconName:@"sms" handler:^{
        //
    }];
    DOPAction *action13 = [[DOPAction alloc] initWithName:@"Email" iconName:@"email" handler:^{
        //
    }];
    DOPAction *action14 = [[DOPAction alloc] initWithName:@"Print" iconName:@"print" handler:^{
        //
    }];
    DOPAction *action15 = [[DOPAction alloc] initWithName:@"Copy" iconName:@"copy" handler:^{
        //
    }];

    
    NSArray *actions;
    
    switch (0) {
        case 0:{
            actions = @[@"", @[action1, action2, action3, action4, action5]];
        } break;
        case 1:{
            actions = @[@"Share", @[action1, action2, action3, action4, action5]];
        } break;
        case 2:{
            actions = @[@"Share",
                        @[action1, action2, action3, action4, action5],
                        @"",
                        @[action6, action7, action8, action9, action10, action11]];
        } break;
        case 3:{
            actions = @[@"Share",
                        @[action1, action2, action3, action4, action5],
                        @"Share More",
                        @[action6, action7, action8, action9, action10, action11],
                        @"",
                        @[action12, action13, action14, action15]];
        } break;
        default:
            break;
    }
    
    DOPScrollableActionSheet *as = [[DOPScrollableActionSheet alloc] initWithActionArray:actions];
    [as show];
    
    
    
}



- (void)handlePan:(UIPanGestureRecognizer*) recognizer
{
    
    NSLog(@"拖移，慢速移动");
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
}

//双击屏幕实现录屏
-(void)doubleTapHandle:(UITapGestureRecognizer *)recognizer{
    NSLog(@"---tapppedddd");
    if (newRecordObj) {
        
        if (!newRecordObj.isRecording) {
            newRecordObj.shouldStopRecording = NO;
            [newRecordObj confirmRecording];
        }else if (newRecordObj.isRecording){
            newRecordObj.shouldStopRecording = YES;
            [newRecordObj confirmStopRecording];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SaoMiaoBtn:(id)sender {
    SaomiaoController *saoMiaoVC = [[SaomiaoController alloc] init];
    [self.navigationController pushViewController:saoMiaoVC animated:YES];
    
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
