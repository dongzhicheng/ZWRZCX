//  github: https://github.com/MakeZL/MLSelectPhoto

#ifndef ZLAssetsPickerDemo_ZLPicker_h
#define ZLAssetsPickerDemo_ZLPicker_h

#import "MLSelectPhotoPickerViewController.h"
#import "MLSelectPhotoAssets.h"

/**
 *
 
 // Use
 ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
 // 默认显示相册里面的内容SavePhotos
 pickerVc.status = PickerViewShowStatusCameraRoll;
 // 选择图片的最小数，默认是9张图片
 pickerVc.minCount = 4;
 // 设置代理回调
 pickerVc.delegate = self;
 // 展示控制器
 [pickerVc showPickerVc:self];
 
 第一种回调方法：- (void)pickerViewControllerDoneAsstes:(NSArray *)assets
 第二种回调方法pickerVc.callBack = ^(NSArray *assets){
 // TODO 回调结果，可以不用实现代理
 };
 
 */
#endif
