

#import <UIKit/UIKit.h>
#import "ViewController.h"

typedef void(^QRUrlBlock)(NSString *url);
@interface QRViewController : UIViewController


@property (nonatomic, copy) QRUrlBlock qrUrlBlock;
@property (nonatomic, assign) BOOL newAge;
@property (nonatomic, copy) NSString *stringValue;
@property (nonatomic,assign)int singleNum;


@end
