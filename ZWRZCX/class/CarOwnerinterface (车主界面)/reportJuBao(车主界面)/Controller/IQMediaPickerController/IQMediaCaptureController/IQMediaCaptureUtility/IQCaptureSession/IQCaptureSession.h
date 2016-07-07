
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "IQMediaCaptureController.h"


typedef NS_ENUM(NSInteger, IQCameraCaptureMode) {
    IQCameraCaptureModePhoto,
    IQCameraCaptureModeVideo,
    IQCameraCaptureModeAudio,
    IQCameraCaptureModeUnspecified,
};

@protocol IQCaptureSessionDelegate;


@interface IQCaptureSession : NSObject

@property(nonatomic, weak) id<IQCaptureSessionDelegate> delegate;

/*****Session*****/
@property(nonatomic, strong, readonly) AVCaptureSession *captureSession; //An instance of AVCaptureSession to coordinate the data flow from the input to the output
//@property(nonatomic, assign) IQCaptureSessionPreset captureSessionPreset;

@property(nonatomic, assign, readonly) BOOL isSessionRunning;

- (void)startRunning;
- (void)stopRunning;
/**********/

/*****Settings*****/
- (BOOL)hasMultipleCameras;
- (BOOL)hasFlash;
- (BOOL)hasTorch;
- (BOOL)hasFocus;
- (BOOL)hasExposure;
- (BOOL)hasWhiteBalance;
- (BOOL)isFocusPointSupported;
- (BOOL)isExposurePointSupported;

- (BOOL)isFlashModeSupported:(AVCaptureFlashMode)flashMode;
- (BOOL)isTorchModeSupported:(AVCaptureTorchMode)torchMode;
- (BOOL)isFocusModeSupported:(AVCaptureFocusMode)focusMode;
- (BOOL)isExposureModeSupported:(AVCaptureExposureMode)exposureMode;
- (BOOL)isWhiteBalanceModeSupported:(AVCaptureWhiteBalanceMode)whiteBalanceMode;

- (IQCameraCaptureMode)captureMode;
+ (NSArray*)supportedVideoCaptureDevices;
- (AVCaptureDevicePosition)cameraPosition;
- (AVCaptureFlashMode)flashMode;
- (AVCaptureTorchMode)torchMode;
- (AVCaptureFocusMode)focusMode;
- (AVCaptureExposureMode)exposureMode;
- (AVCaptureWhiteBalanceMode)whiteBalanceMode;
- (CGPoint)focusPoint;
- (CGPoint)exposurePoint;

- (BOOL)setCaptureMode:(IQCameraCaptureMode)captureMode;
- (BOOL)setCameraPosition:(AVCaptureDevicePosition)cameraPosition;
- (BOOL)setFlashMode:(AVCaptureFlashMode)flashMode;
- (BOOL)setTorchMode:(AVCaptureTorchMode)torchMode;
- (BOOL)setFocusMode:(AVCaptureFocusMode)focusMode;
- (BOOL)setExposureMode:(AVCaptureExposureMode)exposureMode;
- (BOOL)setWhiteBalanceMode:(AVCaptureWhiteBalanceMode)whiteBalanceMode;
- (BOOL)setFocusPoint:(CGPoint)focusPoint;
- (BOOL)setExposurePoint:(CGPoint)exposurePoint;
/**********/

//IQCameraCaptureModePhoto
- (void)takePicture;

//IQCameraCaptureModeVideo
- (void)startVideoRecording;
- (void)stopVideoRecording;

//IQCameraCaptureModeAudio
- (void)startAudioRecording;
- (void)stopAudioRecording;

@property(nonatomic, readonly, getter=isRecording) BOOL recording;
- (CGFloat)recordingDuration;

@end


@protocol IQCaptureSessionDelegate <NSObject>

@optional
- (void)captureSession:(IQCaptureSession*)captureSession didFinishMediaWithInfo:(NSDictionary *)info error:(NSError *)error;

//IQCameraCaptureModeAudio
- (void)captureSession:(IQCaptureSession*)audioSession didUpdateMeterLevel:(CGFloat)meterLevel;

@end
