//
//  horizontalCell.h
//  ZWRZCX
//
//  Created by 董志成 on 16/6/27.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "horizontalModel.h"

@interface horizontalCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *TextCollectionCellImge;

@property (nonatomic ,strong)horizontalModel * horizCellModel;

@end
