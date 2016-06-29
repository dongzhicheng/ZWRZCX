//
//  CylViewController.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/24.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import "CylViewController.h"

@interface CylViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation CylViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.scrollView.frame;
    
    int numOfImages = 5;
    
    for (int i = 0; i < numOfImages; ++i) {
        
        UIImageView *imageView = [[UIImageView alloc] init];

        [self.scrollView addSubview:imageView];

        NSString *imageName = [NSString stringWithFormat:@"%02d",i+1];
 
        imageView.image = [UIImage imageNamed:imageName];
 
        frame.origin.x = frame.size.width * i;
   
        imageView.frame = frame;
        
    }
    
    self.scrollView.contentSize = CGSizeMake(frame.size.width * numOfImages, 0);

    self.scrollView.pagingEnabled = YES;

    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.scrollView.delegate = self;
    
  

    [self startTimer];
 
}

- (void) nextImage
{

    NSInteger page = self.pageControl.currentPage;

    if (page == self.pageControl.numberOfPages - 1) {
        page = 0;
    }else{
        page++;
    }
    
    [UIView animateWithDuration:1 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(page * self.scrollView.frame.size.width, 0);
        
    }];
    
}

- (void) startTimer
{

    NSTimer *timer  = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];

    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    self.timer = timer;
}

#pragma mark - 代理方法

//停止定时器 让定时器失效，一旦失效就不能在使用了。
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
 
    [self.timer invalidate];
}
/**
 *  当用户的手指从scrollViwew上抬起的时候执行这个方法
 */
- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //  重新开始调度
    [self startTimer];
}

//当scrollView的contentOffset发生改变都会调用该方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // round 函数可以进行四舍五入
    int page = round(scrollView.contentOffset.x / scrollView.frame.size.width) ;
    
    self.pageControl.currentPage = page;
}


@end
