//
//  travelInformationTableCellModel.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/4.
//  Copyright © 2016年 董志成. All rights reserved.
//

@implementation travelInformationTableCellModel

+ (instancetype)traveCellWithDict:(NSDictionary *)dict{
    id obj = [[self alloc] init];
    NSArray * properties = @[@"cellLabelText",@"cellDetailLabelText",@"cellImageNameText"];
    for (NSString * key in properties) {
        if (dict[key]) {
            [obj setValue:dict[key] forKey:key]; //字典转模型 运用运行时机制
        }
    }
    return obj;
}
+(void)travesArrayInfCellWithCompletion:(void (^)(NSArray *))completion{
    NetWorkTool *netWorkTol = [NetWorkTool sharedNetWorkTool];
    [netWorkTol GET:@"ad/headline/0-4.html" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        
        NSString *key = responseObject.keyEnumerator.nextObject;
        
        NSArray *dictArray = responseObject[key];
        
        NSMutableArray * arrayM  =  [[NSMutableArray alloc] init];
        
        for (NSDictionary * dict in dictArray) {
            
            [arrayM addObject:[travelInformationTableCellModel traveCellWithDict:dict]];
        
        }
        NSMutableArray *travelCellModelDataArray = [NSMutableArray array];
        
        completion(travelCellModelDataArray.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"NetWorkTool中的错误:%@",error);
    }];
    
}
@end
