
#import <UIKit/UIKit.h>
#import "MLSelectPhotoPickerViewController.h"

@interface MLSelectPhotoPickerGroupViewController : UIViewController

@property (nonatomic , weak) id<ZLPhotoPickerViewControllerDelegate> delegate;
@property (nonatomic , assign) PickerViewShowStatus status;
@property (nonatomic , assign) NSInteger minCount;
// 记录选中的值
@property (strong,nonatomic) NSArray *selectAsstes;
@property (assign,nonatomic) BOOL topShowPhotoPicker;

@end
