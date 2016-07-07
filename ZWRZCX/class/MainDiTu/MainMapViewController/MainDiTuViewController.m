//
//  MainDiTuViewController.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/1.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import "MainDiTuViewController.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKMapCamera.h>
#import <UIKit/UIKit.h>
#import "travelInformationVC.h"

@interface MainDiTuViewController ()
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UITextField *destinationField;
@property (weak, nonatomic) IBOutlet UITextField *startNameField;
@property (strong ,nonatomic) MKMapItem * startMapItemNameField;
@property (strong, nonatomic) IBOutlet UIButton *shunFengCarBtn;
@property (strong, nonatomic) IBOutlet UIButton *selectEvidenceBtn;
@property (strong, nonatomic) IBOutlet UIButton *sanLunCarBtn;
@property (strong, nonatomic) IBOutlet UIButton *bigCarBtn;

@end

@implementation MainDiTuViewController
- (IBAction)shunFengCar:(id)sender {
    
    UIViewController * testVc = [[UIViewController alloc] init];
    testVc.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:testVc animated:YES];

    
}
-(void)leftbtnClick {
    NSLog(@"leftbtnClick");

}


- (IBAction)huoCar:(id)sender {
    
    UIStoryboard * iqViewStroyBoard = [UIStoryboard storyboardWithName:@"DZCIQViewController" bundle:nil];
 
    DZCIQViewController *iqViewController = [iqViewStroyBoard instantiateInitialViewController];
    
    [self.navigationController pushViewController:iqViewController animated:YES];
    
}
- (IBAction)sanLunCar:(id)sender {
    
    
}
- (IBAction)bigCar:(id)sender {
    
    
}

- (IBAction)start:(UIButton *)sender {
    
    MKMapItem *currentItem = [MKMapItem mapItemForCurrentLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [MKMapItem openMapsWithItems:@[currentItem,currentItem] launchOptions:nil];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.startNameField resignFirstResponder];
    [self.destinationField resignFirstResponder];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingDiTuBtnStyl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BreakDiTuClick) name:@"mainDiTuClickBtn" object:nil];
    
    self.locationManager = [[CLLocationManager alloc] init];
   
    [self.locationManager requestWhenInUseAuthorization];
   
    self.view.backgroundColor = [UIColor blueColor];
   
    self.hidesBottomBarWhenPushed = NO;
    
    self.navigationController.navigationBarHidden = NO;
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //设置地图类型
    self.mapView.mapType =  MKMapTypeStandard;
   
    self.mapView.showsTraffic = YES;
    
    // 设置代理
    self.mapView.delegate = self;
   
}

-(void)settingDiTuBtnStyl{


    self.shunFengCarBtn.layer.cornerRadius = 35.0;
    self.shunFengCarBtn.layer.borderColor = [[UIColor redColor] CGColor];
    self.shunFengCarBtn.layer.borderWidth = 2.0;
    self.shunFengCarBtn.layer.masksToBounds = YES;
    
    self.selectEvidenceBtn.layer.cornerRadius = 35.0;
    self.selectEvidenceBtn.layer.borderWidth = 2.0;
    self.selectEvidenceBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    self.selectEvidenceBtn.layer.masksToBounds = YES;
    
    self.sanLunCarBtn.layer.cornerRadius = 35.0;
    self.sanLunCarBtn.layer.borderColor = [[UIColor blueColor] CGColor];
    self.sanLunCarBtn.layer.borderWidth = 2.0;
    self.sanLunCarBtn.layer.masksToBounds = YES;
    
    self.bigCarBtn.layer.cornerRadius = 35.0;
    self.bigCarBtn.layer.borderWidth = 2.0;
    self.bigCarBtn.layer.borderColor = [[UIColor yellowColor] CGColor];
    self.bigCarBtn.layer.masksToBounds = YES;
    
    

}

-(void)BreakDiTuClick{


    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

- (IBAction)guidanceStation:(id)sender {

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    MKMapItem *currentItem = [MKMapItem mapItemForCurrentLocation];
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    options[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeTransit;
    options[MKLaunchOptionsMapTypeKey] = MKMapTypeStandard;
    options[MKLaunchOptionsShowsTrafficKey] = @(YES);
    // 导航
    [MKMapItem openMapsWithItems:@[currentItem,currentItem] launchOptions:options];
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //    userLocation.title = @"天朝";
    //    userLocation.subtitle = @"帝都";
    // 1.创建编码对象
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // 2.反地理编码
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
            NSLog(@"%@",error);
            return ;
        }
        //获得地标
        CLPlacemark *placemark = [placemarks firstObject];
        //设置标题
        userLocation.title = placemark.locality;
        // 设置子标题
        userLocation.subtitle = placemark.name;
    }];
}
//配置参数mapItem
//     MKLaunchOptionsDirectionsModeKey  导航模式
//     MKLaunchOptionsMapTypeKey         地图类型
//     MKLaunchOptionsShowsTrafficKey    显示实时路况
//     MKLaunchOptionsDirectionsModeDriving  驾车
//     MKLaunchOptionsDirectionsModeWalking  步行
//     MKLaunchOptionsDirectionsModeTransit  交通
//




#pragma mark --下边为以后使用  地理编码，实现导航
-(void)textDiLiCoder{
    MKMapItem *currentItem = [MKMapItem mapItemForCurrentLocation]; //当前的位置
    CLGeocoder *geocoder1 = [[CLGeocoder alloc] init];
    [geocoder1 geocodeAddressString:self.startNameField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
            return ;
        }
        CLPlacemark *placemark = [placemarks firstObject];
        MKPlacemark *mkplacemark = [[MKPlacemark alloc] initWithPlacemark:placemark];
        self.startMapItemNameField = [[MKMapItem alloc] initWithPlacemark:mkplacemark];
    }];
    
    [geocoder1 geocodeAddressString:self.destinationField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        MKPlacemark *placemark = [[MKPlacemark alloc]initWithPlacemark:placemarks.lastObject];
        MKMapItem *destinationItem = [[MKMapItem  alloc]initWithPlacemark:placemark];
        NSDictionary *dict = @{MKLaunchOptionsDirectionsModeKey:
                                   MKLaunchOptionsDirectionsModeDriving,
                               MKLaunchOptionsMapTypeKey:@(1),
                               MKLaunchOptionsShowsTrafficKey:@(YES)
                               };
        [MKMapItem  openMapsWithItems:@[currentItem,destinationItem] launchOptions:dict];
    }];
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
