
#import <UIKit/UIKit.h>
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
@interface UIBarButtonItem (Extension)

/**
 *  通过一张图片返回一个UIBarButtonItem
 *
 *  @param imageName 图片的名字
 *
 *  @return 实例对象
 */
+ (instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;


/**
 *  通过一张图片与文字返回一个UIBarButtonItem
 *
 *  @param imageName 图片的名字
 *  @param title     标题
 *  @param target    谁
 *  @param action    执行的方法
 *
 *  @return 实例对象
 */
+ (instancetype)itemWithImageName:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action;

/**
 *  通过一个文字初始化一个UIBarButtonItem
 *
 *  @param title  标题
 *  @param target 谁
 *  @param action 执行的方法
 *
 *  @return 实例对象
 */
+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;


@end
