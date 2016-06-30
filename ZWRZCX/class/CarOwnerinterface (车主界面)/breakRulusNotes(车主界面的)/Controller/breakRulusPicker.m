//
//  breakRulusPicker.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/30.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import "breakRulusPicker.h"

@implementation breakRulusPicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)flagView{

    return [[[NSBundle mainBundle] loadNibNamed:@"breakRulusPicker" owner:nil options:nil] lastObject];
}
- (void)setBreakRulusPickerModel:(breakRulusPickerModel *)breakRulusPickerModel{

    

}

@end
