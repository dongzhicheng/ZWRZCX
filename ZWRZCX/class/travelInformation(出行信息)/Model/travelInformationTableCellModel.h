//
//  travelInformationTableCellModel.h
//  ZWRZCX
//
//  Created by 董志成 on 16/6/4.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface travelInformationTableCellModel : NSObject

@property (nonatomic,copy)NSString * cellLabelText;
@property (nonatomic,copy)NSString * cellDetailLabelText;
@property (nonatomic,copy)NSString * cellImageNameText;

+(instancetype)traveCellWithDict:(NSDictionary *)dict;
+(void)travesArrayInfCellWithCompletion:(void (^)(NSArray *travesArrayInCell))completion;
@end
