//
//  UserGuidViewController.m
//  UserGuid
//
//  Created by Durban on 14-1-3.
//  Copyright (c) 2014年 WalkerFree. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DZCTabBarController.h"
#import "UserGuidViewController.h"

@interface UserGuidViewController ()

@end

@implementation UserGuidViewController


- (void)awakeFromNib {
    self.startButton.hidden = YES;
}


- (void)setStartButtonHidden:(BOOL)hidden { //控制按钮的显示或者隐藏
    
    self.startButton.hidden = hidden;
}


- (IBAction)startClick:(id)sender {
    
    DZCTabBarController *vc = [[DZCTabBarController alloc] init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    
}

@synthesize photoList = _photoList;
@synthesize pageScroll = _pageScroll;
@synthesize pageControl = _pageControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.startButton.hidden = YES;
    
    self.pageScroll.pagingEnabled = YES;
    
    NSString *img1 = [[NSBundle mainBundle] pathForResource:@"welcome1"
                                                     ofType:@"png"];
    
    NSString *img2 = [[NSBundle mainBundle] pathForResource:@"welcome2"
                                                     ofType:@"png"];
    
    NSString *img3 = [[NSBundle mainBundle] pathForResource:@"welcome3"
                                                     ofType:@"png"];
    
    NSString *img4 = [[NSBundle mainBundle] pathForResource:@"welcome4"
                                                     ofType:@"png"];
    
    NSString *img5 = [[NSBundle mainBundle] pathForResource:@"welcome5"
                                                     ofType:@"png"];
    
    NSString *img6 = [[NSBundle mainBundle] pathForResource:@"welcome6"
                                                     ofType:@"png"];
    
    NSString *img7 = [[NSBundle mainBundle] pathForResource:@"welcome7"
                                                     ofType:@"png"];
    
    NSString *img8 = [[NSBundle mainBundle] pathForResource:@"welcome8"
                                                     ofType:@"png"];
    
    NSString *img9 = [[NSBundle mainBundle] pathForResource:@"welcome9"
                                                     ofType:@"png"];
    
    _photoList = [[NSArray alloc] initWithObjects:
                  [UIImage imageWithContentsOfFile:img1],
                  [UIImage imageWithContentsOfFile:img2],
                  [UIImage imageWithContentsOfFile:img3],
                  [UIImage imageWithContentsOfFile:img4],
                  [UIImage imageWithContentsOfFile:img5],
                  [UIImage imageWithContentsOfFile:img6],
                  [UIImage imageWithContentsOfFile:img7],
                  [UIImage imageWithContentsOfFile:img8],
                  [UIImage imageWithContentsOfFile:img9], nil
                  ];
    
    NSInteger pageCount = [_photoList count];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = pageCount;
    
    _pageScroll.frame = CGRectMake(0.0,
                                   0.0,
                                   320.0,
                                   568.0);
    _pageScroll.delegate = self;
    for(NSInteger i=0;i<pageCount;i++)
    {
        CGRect frame;
        frame.origin.x = _pageScroll.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = _pageScroll.frame.size;
        UIImageView *pageView = [[UIImageView alloc] initWithImage:[_photoList objectAtIndex:i]];
        pageView.contentMode = UIViewContentModeScaleAspectFill;
        pageView.frame = frame;
        [_pageScroll addSubview:pageView];
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    CGSize pageScrollViewSize = _pageScroll.frame.size;
    _pageScroll.contentSize = CGSizeMake(pageScrollViewSize.width * _photoList.count, pageScrollViewSize.height);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
     [self setStartButtonHidden:YES];
    
    CGFloat pageWidth = _pageScroll.frame.size.width;
   
    int page = floor((_pageScroll.contentOffset.x + pageWidth/2)/pageWidth);  // 在滚动超过页面宽度的50%的时候，切换到新的页面
    
    _pageControl.currentPage = page;
    
    if ( page == 8 ) {
        
        [self setStartButtonHidden:NO];
        
    }
  
}

- (IBAction)PageValueChange:(id)sender
{
    // 更新Scroll View到正确的页面
    CGRect frame;
    frame.origin.x = _pageScroll.frame.size.width * _pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = _pageScroll.frame.size;
    [_pageScroll scrollRectToVisible:frame animated:YES];
}

-(UIImage *)getEmptyUIImage
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(_pageScroll.frame.size.width,
                                                      _pageScroll.frame.size.height), NO, 0.0);
    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return blank;
}
@end
