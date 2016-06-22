

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic,assign) CGFloat ml_x;
@property (nonatomic,assign) CGFloat ml_y;
@property (nonatomic,assign) CGFloat ml_centerX;
@property (nonatomic,assign) CGFloat ml_centerY;
@property (nonatomic,assign) CGFloat ml_width;
@property (nonatomic,assign) CGFloat ml_height;
@property (nonatomic,assign) CGSize ml_size;

- (void)showMessageWithText:(NSString *)text;
@end
