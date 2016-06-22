//
//  NetWorkTool.h
//  ZWRZCX
//
//  Created by 董志成 on 16/6/4.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking.h>

@interface NetWorkTool : AFHTTPSessionManager

+(instancetype)sharedNetWorkTool;

@end
