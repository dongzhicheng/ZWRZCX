//
//  horizontalCell.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/27.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import "horizontalCell.h"

@implementation horizontalCell

//只有在这里才能取到自定义ImageView控件的frame
-(void)awakeFromNib{

      self.TextCollectionCellImge.image = [UIImage imageNamed:@"1"];

}
//重写Model属性对应的方法
-(void)setHorizCellModel:(horizontalModel *)horizCellModel{

    _horizCellModel = horizCellModel;
    
}
@end
