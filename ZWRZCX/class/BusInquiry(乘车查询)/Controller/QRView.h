
#import <UIKit/UIKit.h>

@protocol QRViewDelegate <NSObject>

@end
@interface QRView : UIView


@property (nonatomic, weak) id<QRViewDelegate> delegate;
/**
 *  透明的区域
 */
@property (nonatomic, assign) CGSize transparentArea;

-(void)addTimer;
-(void)pauseTiemr;
@end
