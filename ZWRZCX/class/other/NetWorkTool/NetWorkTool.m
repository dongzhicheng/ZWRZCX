//
//  NetWorkTool.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/4.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import "NetWorkTool.h"

static NSString * const NewsBaseURLString = @"http://www.baidu.com/nc/"; //需要改成自己后端的BaseUrl

@implementation NetWorkTool

static NetWorkTool *_instance = nil;
+ (instancetype)sharedNetWorkTool{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:NewsBaseURLString]];
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
    });

    return _instance;
}
@end
