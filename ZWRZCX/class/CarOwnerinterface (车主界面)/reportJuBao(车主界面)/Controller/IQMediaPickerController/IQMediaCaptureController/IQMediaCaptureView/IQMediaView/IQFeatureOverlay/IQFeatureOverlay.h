
#import <UIKit/UIKit.h>

@class IQFeatureOverlay;

@protocol IQFeatureOverlayDelegate <NSObject>

@optional
-(void)featureOverlay:(IQFeatureOverlay*)featureOverlay didEndWithCenter:(CGPoint)center;
@end

@interface IQFeatureOverlay : UIImageView

@property(nonatomic, assign) id<IQFeatureOverlayDelegate> delegate;

-(void)animate;

-(void)hideAfterSeconds:(CGFloat)seconds;

@end
