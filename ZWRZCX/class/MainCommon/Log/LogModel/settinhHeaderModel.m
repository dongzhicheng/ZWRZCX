//
//  settinhHeaderModel.m
//  ZWRZCX
//
//  Created by 董志成 on 16/7/2.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import "settinhHeaderModel.h"

@implementation settinhHeaderModel
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.headerStr forKey:@"headerStr"];
    [aCoder encodeObject:self.stringNAME forKey:@"stringNAME"];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.headerStr = [aDecoder decodeObjectForKey:@"headerStr"];
       self.stringNAME = [aDecoder decodeObjectForKey:@"stringNAME"];
    }
    return self;
}



@end
