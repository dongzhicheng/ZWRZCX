

#import <Foundation/Foundation.h>

@class MPMediaItemCollection;

@interface IQAudioPickerUtility : NSObject

+(NSString*)secondsToTimeString:(NSTimeInterval)seconds;

+(NSUInteger)secondsToMins:(NSTimeInterval)seconds;

+(NSUInteger)mediaCollectionDuration:(MPMediaItemCollection*)collection;

@end
