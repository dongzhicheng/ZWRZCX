
#import <UIKit/UIKit.h>
typedef void(^deleteCallBackBlock)();

@interface MLSelectPhotoBrowserViewController : UIViewController
// 展示的图片 MLSelectAssets
@property (strong,nonatomic) NSArray *photos;
// 长按图片弹出的UIActionSheet
@property (strong,nonatomic) UIActionSheet *sheet;
// 当前提供的分页数
@property (nonatomic , assign) NSInteger currentPage;

@property (nonatomic , copy) deleteCallBackBlock deleteCallBack;
@end
