
#import <UIKit/UIKit.h>

@class IQPartitionView;

@protocol IQPartitionViewDelegate <NSObject>

-(void)partitionView:(IQPartitionView*)partition didSelect:(BOOL)selected;

@end

@interface IQPartitionView : UILabel

@property(nonatomic, assign) id<IQPartitionViewDelegate> delegate;
@property(nonatomic, assign) BOOL selected;
@property(nonatomic, strong, readonly) UITapGestureRecognizer *tapRecognizer;

@end
