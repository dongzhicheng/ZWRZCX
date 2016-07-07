

#import <UIKit/UIKit.h>

@class IQAudioPickerController;

@interface IQSongsListViewController : UITableViewController

@property(nonatomic, assign) IQAudioPickerController *audioPickerController;

@property(nonatomic, strong) NSString *property;

@property(nonatomic, strong) NSArray *collections;

@end
