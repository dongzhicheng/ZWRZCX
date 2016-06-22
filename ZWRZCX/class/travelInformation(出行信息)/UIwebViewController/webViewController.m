//
//  webViewController.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/4.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import "webViewController.h"

@interface webViewController ()<UIWebViewDelegate>

@property (nonatomic,assign)double indexInCell;//记录点击的是哪一个Cell


@end

@implementation webViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
   
    UIWebView *webView = (UIWebView *)self.view;
    
    webView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    NSURL * traveWebUrl  = [NSURL URLWithString:@"https://www.baidu.com"];
 
    NSURLRequest * requst = [NSURLRequest requestWithURL:traveWebUrl];
    
    [webView loadRequest:requst];
    
    webView.delegate = self;
    
    NSLog(@"%f",self.indexInCell);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"webViewDidStartLoad");
    
}

- (void)webViewDidFinishLoad:(UIWebView *)web{
    
    NSLog(@"webViewDidFinishLoad");
    
}

-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error{
    
    NSLog(@"DidFailLoadWithError");
    
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
