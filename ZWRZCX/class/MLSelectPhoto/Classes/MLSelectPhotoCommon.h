

#ifndef MLSelectPhoto_h
#define MLSelectPhoto_h

static NSInteger const KPhotoShowMaxCount = 9; // 图片最多显示9张，超过9张取消单击事件
static BOOL const isCameraAutoSavePhoto = YES; // 是否开启拍照自动保存图片
static CGFloat KHUDShowDuration = 1.0; // HUD提示框动画执行的秒数

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define DefaultNavbarTintColor UIColorFromRGB(0x2f3535) // Navigation Color
#define DefaultNavTintColor UIColorFromRGB(0xd5d5d5)
#define DefaultNavTitleColor UIColorFromRGB(0xd5d5d5)

#define iOS7gt ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

static NSString *PICKER_TAKE_DONE = @"PICKER_TAKE_DONE"; // NSNotification

#define MLSelectPhotoSrcName(file) [@"MLSelectPhoto.bundle" stringByAppendingPathComponent:file] // 图片路径

#endif
