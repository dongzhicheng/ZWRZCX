

#import "IQMediaPickerController.h"
#import "IQMediaCaptureController.h"
#import "IQAssetsPickerController.h"
#import "IQAudioPickerController.h"
#import "IQMediaPickerControllerConstants.h"

@interface IQMediaPickerController ()<IQMediaCaptureControllerDelegate,IQAssetsPickerControllerDelegate,IQAudioPickerControllerDelegate,UITabBarControllerDelegate>

@end

@implementation IQMediaPickerController

@dynamic delegate;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setMediaType:IQMediaPickerControllerMediaTypePhoto];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    switch (self.mediaType)
    {
        case IQMediaPickerControllerMediaTypeVideo:
        {
            IQMediaCaptureController *controller = [[IQMediaCaptureController alloc] init];
            controller.allowsCapturingMultipleItems = self.allowsPickingMultipleItems;
            controller.delegate = self;
            controller.captureMode = IQMediaCaptureControllerCaptureModeVideo;
            self.viewControllers = @[controller];
        }
            break;
        case IQMediaPickerControllerMediaTypePhoto:
        {
            IQMediaCaptureController *controller = [[IQMediaCaptureController alloc] init];
            controller.allowsCapturingMultipleItems = self.allowsPickingMultipleItems;
            controller.captureMode = IQMediaCaptureControllerCaptureModePhoto;
            controller.delegate = self;
            self.viewControllers = @[controller];
        }
            break;
        case IQMediaPickerControllerMediaTypeAudio:
        {
            IQMediaCaptureController *controller = [[IQMediaCaptureController alloc] init];
            controller.allowsCapturingMultipleItems = self.allowsPickingMultipleItems;
            controller.delegate = self;
            controller.captureMode = IQMediaCaptureControllerCaptureModeAudio;
            self.viewControllers = @[controller];
        }
            break;
        case IQMediaPickerControllerMediaTypePhotoLibrary:
        {
            IQAssetsPickerController *controller = [[IQAssetsPickerController alloc] init];
            controller.allowsPickingMultipleItems = self.allowsPickingMultipleItems;
            controller.delegate = self;
            controller.pickerType = IQAssetsPickerControllerAssetTypePhoto;
            self.viewControllers = @[controller];
        }
            break;
        case IQMediaPickerControllerMediaTypeVideoLibrary:
        {
            IQAssetsPickerController *controller = [[IQAssetsPickerController alloc] init];
            controller.allowsPickingMultipleItems = self.allowsPickingMultipleItems;
            controller.delegate = self;
            controller.pickerType = IQAssetsPickerControllerAssetTypeVideo;
            self.viewControllers = @[controller];
        }
            break;
        case IQMediaPickerControllerMediaTypeAudioLibrary:
        {
            IQAudioPickerController *controller = [[IQAudioPickerController alloc] init];
            controller.allowsPickingMultipleItems = self.allowsPickingMultipleItems;
            controller.delegate = self;
            self.viewControllers = @[controller];
        }
            break;
        default:
            break;
    }
}

-(void)setMediaType:(IQMediaPickerControllerMediaType)mediaType
{
    _mediaType = mediaType;
}

#pragma mark - IQMediaCaptureControllerDelegate
- (void)mediaCaptureController:(IQMediaCaptureController*)controller didFinishMediaWithInfo:(NSDictionary *)info
{
    if ([self.delegate respondsToSelector:@selector(mediaPickerController:didFinishMediaWithInfo:)])
    {
        [self.delegate mediaPickerController:self didFinishMediaWithInfo:info];
    }
}

- (void)mediaCaptureControllerDidCancel:(IQMediaCaptureController *)controller
{
    if ([self.delegate respondsToSelector:@selector(mediaPickerControllerDidCancel:)])
    {
        [self.delegate mediaPickerControllerDidCancel:self];
    }
}

#pragma mark - IQAssetsPickerControllerDelegate
- (void)assetsPickerController:(IQAssetsPickerController*)controller didFinishMediaWithInfo:(NSDictionary *)info
{
    if ([self.delegate respondsToSelector:@selector(mediaPickerController:didFinishMediaWithInfo:)])
    {
        [self.delegate mediaPickerController:self didFinishMediaWithInfo:info];
    }
}

- (void)assetsPickerControllerDidCancel:(IQAssetsPickerController *)controller
{
    if ([self.delegate respondsToSelector:@selector(mediaPickerControllerDidCancel:)])
    {
        [self.delegate mediaPickerControllerDidCancel:self];
    }
}

#pragma mark - IQAudioPickerControllerDelegate
- (void)audioPickerController:(IQAudioPickerController *)mediaPicker didPickMediaItems:(NSArray*)mediaItems
{
    if ([self.delegate respondsToSelector:@selector(mediaPickerController:didFinishMediaWithInfo:)])
    {
        NSDictionary *info = [NSDictionary dictionaryWithObject:mediaItems forKey:IQMediaTypeAudio];
        
        [self.delegate mediaPickerController:self didFinishMediaWithInfo:info];
    }
}

- (void)audioPickerControllerDidCancel:(IQAudioPickerController *)mediaPicker
{
    if ([self.delegate respondsToSelector:@selector(mediaPickerControllerDidCancel:)])
    {
        [self.delegate mediaPickerControllerDidCancel:self];
    }
}

@end

