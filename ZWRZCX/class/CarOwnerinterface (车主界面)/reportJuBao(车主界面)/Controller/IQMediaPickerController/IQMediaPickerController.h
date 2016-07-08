

#import <UIKit/UIKit.h>
#import "IQMediaPickerControllerConstants.h"
#import "DZCNavigationController.h"

typedef NS_ENUM(NSInteger, IQMediaPickerControllerMediaType) {
    IQMediaPickerControllerMediaTypePhotoLibrary,
    IQMediaPickerControllerMediaTypeVideoLibrary,
    IQMediaPickerControllerMediaTypeAudioLibrary,
    IQMediaPickerControllerMediaTypePhoto,
    IQMediaPickerControllerMediaTypeVideo,
    IQMediaPickerControllerMediaTypeAudio,
};

@protocol IQMediaPickerControllerDelegate;

@interface IQMediaPickerController : DZCNavigationController

@property(nonatomic, assign) id<IQMediaPickerControllerDelegate,UINavigationControllerDelegate> delegate;
@property (nonatomic, assign) BOOL allowsPickingMultipleItems; // default is NO. Currently only applicable for IQMediaPickerControllerMediaTypePhotoLibrary, IQMediaPickerControllerMediaTypeVideoLibrary, IQMediaPickerControllerMediaTypeAudioLibrary;
@property(nonatomic, assign) IQMediaPickerControllerMediaType mediaType;

@end

@protocol IQMediaPickerControllerDelegate <NSObject>

- (void)mediaPickerController:(IQMediaPickerController*)controller didFinishMediaWithInfo:(NSDictionary *)info;
- (void)mediaPickerControllerDidCancel:(IQMediaPickerController *)controller;

@end