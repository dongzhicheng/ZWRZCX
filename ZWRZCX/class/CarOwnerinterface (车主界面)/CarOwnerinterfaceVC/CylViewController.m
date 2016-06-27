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
    
    CGFloat scanViewW = self.scrollView.frame.size.width;
    CGFloat scanViewH = self.scrollView.frame.size.height;
    
    for (int i = 0; i<5; i++) {

        UIImageView *scanView = [UIImageView new];
        scanView.frame = CGRectMake(i* scanViewW, 0, scanViewW, scanViewH);
        [self.scrollView insertSubview:scanView atIndex:0];
        scanView.image = [UIImage imageNamed:[NSString stringWithFormat:@"img_0%d",i+1]];
    }
    
    self.scrollView.contentSize = CGSizeMake(scanViewW *9, 0);
    self.scrollView.pagingEnabled = YES;
    self.pageControl.numberOfPages = 5;
    self.pageControl.currentPage = 0;
    self.scrollView.delegate = self;
    
    [self addTimer];
 
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger pageCount = (offsetX + scrollView.frame.size.width * 0.5)/ scrollView.frame.size.width;
    self.pageControl.currentPage = pageCount;
    
    

}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{

    [self.timer invalidate];
    self.timer = nil;

}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
    [self nextImage];
}

-(void)nextImage{
    
    NSInteger pageCount = self.pageControl.currentPage;
    if (pageCount == 4) {
        pageCount = 0;
    }
    else{
        pageCount ++;
    }
    
    CGFloat scrollViewW = self.scrollView.frame.size.width ;
    [self.scrollView setContentOffset:CGPointMake(pageCount *scrollViewW, 0) animated:YES];
}

-(void)addTimer{

    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    self.timer = timer;

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
