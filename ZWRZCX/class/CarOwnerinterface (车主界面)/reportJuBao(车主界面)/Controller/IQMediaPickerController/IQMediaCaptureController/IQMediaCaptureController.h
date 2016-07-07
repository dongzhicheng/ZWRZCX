

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IQMediaCaptureControllerCaptureMode) {
    IQMediaCaptureControllerCaptureModePhoto,
    IQMediaCaptureControllerCaptureModeVideo,
    IQMediaCaptureControllerCaptureModeAudio,
};

typedef NS_ENUM(NSInteger, IQMediaCaptureControllerCameraDevice) {
    IQMediaCaptureControllerCameraDeviceRear,
    IQMediaCaptureControllerCameraDeviceFront,
};

@protocol IQMediaCaptureControllerDelegate;

@interface IQMediaCaptureController : UIViewController

@property(nonatomic, assign) id<IQMediaCaptureControllerDelegate> delegate;

@property(nonatomic, assign) IQMediaCaptureControllerCaptureMode captureMode;
@property(nonatomic, assign) IQMediaCaptureControllerCameraDevice captureDevice;

@property (nonatomic, assign) BOOL allowsCapturingMultipleItems; // default is NO.

@end


@protocol IQMediaCaptureControllerDelegate <NSObject>

- (void)mediaCaptureController:(IQMediaCaptureController*)controller didFinishMediaWithInfo:(NSDictionary *)info;
- (void)mediaCaptureControllerDidCancel:(IQMediaCaptureController *)controller;

@end
