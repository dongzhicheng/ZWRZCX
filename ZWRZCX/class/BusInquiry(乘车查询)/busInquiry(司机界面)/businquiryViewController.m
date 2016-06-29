//
//  businquiryViewController.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/29.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import "businquiryViewController.h"
#import <UIImageView+AFNetworking.h>

@interface businquiryViewController ()
@property (strong, nonatomic) IBOutlet UILabel *businquiryName;

@end

@implementation businquiryViewController


- (IBAction)safePositionColle:(id)sender {
    
    MKMapItem *currentItem = [MKMapItem mapItemForCurrentLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [MKMapItem openMapsWithItems:@[currentItem,currentItem] launchOptions:nil];
    
}
-(void)viewWillAppear:(BOOL)animated{

    self.businquiryName.text = @"";
}
-(void)viewDidAppear:(BOOL)animated{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults]; //创建沙盒对象
    self.businquiryName.numberOfLines = 0;
    NSString  * str = [userDefaults stringForKey:@"busInquiry"];
    self.businquiryName.text = str;
    NSLog(@"businquiryViewController--%@",str);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL * url = [NSURL URLWithString:@"http://192.168.4.99:8080/smart/userfiles/1/_thumbs/images/photo/2016/02/50387ada5de8b.jpg?hash=bd645afcb04eba8a17a42bcc198a613b&fileHash=201606290919-11"];
    
    [self.businquiryImageView setImageWithURL:url];

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
