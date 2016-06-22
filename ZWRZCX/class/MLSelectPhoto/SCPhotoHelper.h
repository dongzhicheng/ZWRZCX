
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SCPhotoHelperHeadComplete)(UIImage *headImage);
typedef void(^SCPhotoHelperComplete)(NSArray *assets);

@interface SCPhotoHelper : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

+ (SCPhotoHelper *)sharedInstance;
- (void)chooseHeadPicture:(SCPhotoHelperHeadComplete) headCompleteBlock;
- (void)choosePicture:(SCPhotoHelperComplete)         completeBlock;

@property (nonatomic, assign)   NSInteger                  maxCount;
@property (nonatomic, copy)     SCPhotoHelperHeadComplete  headCompleteBlock;
@property (nonatomic, copy)     SCPhotoHelperComplete      completeBlock;

@end
