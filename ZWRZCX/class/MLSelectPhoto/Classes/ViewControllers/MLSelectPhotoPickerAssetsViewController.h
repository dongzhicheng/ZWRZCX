
#import <UIKit/UIKit.h>
#import "MLSelectPhotoCommon.h"
#import "MLSelectPhotoPickerGroupViewController.h"

@class MLSelectPhotoPickerGroup;

@interface MLSelectPhotoPickerAssetsViewController : UIViewController

@property (strong,nonatomic) MLSelectPhotoPickerGroupViewController *groupVc;
@property (nonatomic , assign) PickerViewShowStatus status;
@property (nonatomic , strong) MLSelectPhotoPickerGroup *assetsGroup;
@property (nonatomic , assign) NSInteger minCount;
// 需要记录选中的值的数据
@property (strong,nonatomic) NSArray *selectPickerAssets;
// 置顶展示图片
@property (assign,nonatomic) BOOL topShowPhotoPicker;

@end
