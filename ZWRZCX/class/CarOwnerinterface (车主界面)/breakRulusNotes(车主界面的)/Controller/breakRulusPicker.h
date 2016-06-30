//
//  breakRulusPicker.h
//  ZWRZCX
//
//  Created by 董志成 on 16/6/30.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "breakRulusPickerModel.h"

@interface breakRulusPicker : UIView
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
+(instancetype)flagView;
@property(nonatomic,strong)breakRulusPickerModel *breakRulusPickerModel;

@end
