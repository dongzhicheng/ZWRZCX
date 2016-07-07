

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@protocol IQAudioPickerControllerDelegate;

@interface IQAudioPickerController : UITabBarController

@property(nonatomic, assign) id<IQAudioPickerControllerDelegate,UITabBarControllerDelegate> delegate;
@property (nonatomic) BOOL allowsPickingMultipleItems; // default is NO
@property(nonatomic, strong) NSMutableSet *selectedItems;

@end

@protocol IQAudioPickerControllerDelegate <NSObject>

- (void)audioPickerController:(IQAudioPickerController *)mediaPicker didPickMediaItems:(NSArray*)mediaItems;
- (void)audioPickerControllerDidCancel:(IQAudioPickerController *)mediaPicker;

@end
